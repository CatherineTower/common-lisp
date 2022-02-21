(in-package #:%mfiano.graphics.image.color)

(defclass model (storage)
  ((%space-name
    :type symbol
    :reader space-name
    :initarg :space)
   (%default-illuminant-name
    :initarg :default-illuminant
    :reader default-illuminant-name
    :accessor %default-illuminant-name)
   (%illuminant-name
    :type symbol
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)))

(u:define-printer (model stream :type nil)
  (format stream "COLOR (model: ~a, space: ~a, illuminant: ~a)~%  ~{~{~a~^: ~}~^~%  ~}"
          (type-of model)
          (space-name model)
          (illuminant-name model)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names model)
               (channels model))))

(defmethod initialize-instance :after ((instance model) &key space illuminant)
  (let* ((model (type-of instance))
         (space (or space (u:make-keyword model))))
    (u:if-found (spec (get-color-space-spec space))
      (destructuring-bind (space &rest args &key models ((:illuminant default-illuminant)) &allow-other-keys) spec
        (setf (%default-illuminant-name instance) default-illuminant)
        (let ((args (if illuminant (list* :illuminant illuminant args) args)))
          (if (member model models)
              (apply #'reinitialize-instance instance :allow-other-keys t args)
              (error "Color space ~s is not valid for color model ~a." space model))))
      (error "Color space ~s is not defined." space))))

(defgeneric default-color (model &rest args))

(defun make-color (model &rest args &key space &allow-other-keys)
  (if (subtypep model 'model)
      (let ((space (u:make-keyword (or space model))))
        (apply #'make-instance model :space space args))
      (error "Color model ~s is not defined." model)))

(declaim (inline copy-illuminant-name))
(defun copy-illuminant-name (from to &optional default)
  (declare (optimize speed))
  (let ((illuminant-name (if default (default-illuminant-name from) (illuminant-name from))))
    (setf (%illuminant-name to) illuminant-name)
    (values)))

(defmacro define-rgb-value-converters ((model))
  (u:with-gensyms (color)
    (let* ((model-spaces (u:hash-values (base:color-spaces base:*context*)))
           (rgb-spaces (mapcar
                        (lambda (x) (u:plist-get (cdr x) :space))
                        (remove-if-not
                         (lambda (x) (eq x 'rgb))
                         model-spaces :key #'car))))
      `(progn
         ,@(unless (eq model 'rgb)
             `((defmethod base:convert ((from rgb) (to (eql ',model)))
                 (with-pool-color (,color ',model :space to)
                   (decompose-channels (base:convert from ,color))))))
         ,@(mapcar
            (lambda (x)
              (destructuring-bind (from to) x
                `(defmethod base:convert ((from ,from) (to (eql ',to)))
                   (with-pool-color (,color (get-space-model to) :space to)
                     (decompose-channels (base:convert from ,color))))))
            (u:map-product #'list `(,model) rgb-spaces))))))
