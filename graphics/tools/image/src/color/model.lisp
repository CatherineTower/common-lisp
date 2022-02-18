(in-package #:%mfiano.graphics.tools.image.color)

(defclass model (storage)
  ((%space-name
    :type (and symbol (not null))
    :reader space-name
    :initarg :space)
   (%default-illuminant-name
    :reader default-illuminant-name)
   (%illuminant-name
    :type (and symbol (not null))
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)))

(u:define-printer (model stream :type nil)
  (format stream "COLOR (model: ~s, space: ~s)~%  ~{~{~a~^: ~}~^~%  ~}"
          (type-of model)
          (space-name model)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names model)
               (channels model))))

(defmethod initialize-instance :after ((instance model) &key space)
  (let ((model (type-of instance)))
    (u:if-found (spec (get-color-space-spec (or space model)))
      (destructuring-bind (space-model . space-args) spec
        (if (subtypep model space-model)
            (apply #'reinitialize-instance instance space-args)
            (error "Color space ~s is not valid for color model ~s." space model)))
      (error "Color space ~s is not defined." space))
    (setf (slot-value instance '%default-illuminant-name) (illuminant-name instance))))

(defgeneric default-color (model &rest args))

(declaim (inline make-model))
(defun make-model (model-name space-name)
  (make-instance model-name :space space-name :allow-other-keys t))

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
