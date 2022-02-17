(in-package #:%mfiano.graphics.tools.image.color)

(defclass model ()
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
    :initarg :illuminant)
   (%channel-names
    :type list
    :reader channel-names
    :initarg :channel-names)))

(u:define-printer (model stream :type nil)
  (format stream "COLOR (model: ~s, space: ~s)~%  ~{~{~a~^: ~}~^~%  ~}"
          (type-of model)
          (space-name model)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names model)
               (data model))))

(declaim (inline get-color-space-spec))
(defun get-color-space-spec (space-name)
  (u:href (base:color-spaces base:*context*) space-name))

(defmethod initialize-instance :after ((instance model) &key space)
  (let ((model (type-of instance)))
    (u:if-found (spec (get-color-space-spec (or space model)))
      (destructuring-bind (space-model . space-args) spec
        (if (eq model space-model)
            (apply #'reinitialize-instance instance space-args)
            (error "Color space ~s is not valid for color model ~s." space model)))
      (error "Color space ~s is not defined." space))
    (setf (slot-value instance '%default-illuminant-name) (illuminant-name instance))))

(defun register-color-space (model-name space-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defmacro define-builtin-color-spaces (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v))
                  (model-name (or model space-name)))
              `(register-color-space ',model-name ',space-name ,@(u:plist-remove args :model)))))
        body)))

(defmacro define-rgb-value-converters ((model))
  (u:with-gensyms (color)
    (let* ((model-spaces (u:hash-values (base:color-spaces base:*default-context*)))
           (rgb-spaces (mapcar
                        (lambda (x) (u:plist-get (cdr x) :space))
                        (remove-if-not
                         (lambda (x) (eq x 'rgb))
                         model-spaces :key #'car))))
      `(progn
         ,@(unless (eq model 'rgb)
             `((defmethod base:convert ((from rgb) (to (eql ',model)))
                 (with-pool-color (,color to)
                   (extract-values (base:convert from ,color))))))
         ,@(mapcar
            (lambda (x)
              (destructuring-bind (from to) x
                `(defmethod base:convert ((from ,from) (to (eql ',to)))
                   (with-pool-color (,color to)
                     (extract-values (base:convert from ,color))))))
            (u:map-product #'list `(,model) rgb-spaces))))))
