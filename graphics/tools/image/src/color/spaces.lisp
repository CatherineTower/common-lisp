(in-package #:mfiano.graphics.tools.image)

(defclass color-space ()
  ((%color-space-name
    :type (and symbol (not null))
    :reader color-space-name
    :initarg :color-space)
   (%illuminant-name
    :type symbol
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)))

(defclass xyz (color-space) ())

(defclass rgb (color-space)
  ((%coords
    :type list
    :reader coords
    :initarg :coords)
   (%gamma
    :type (or u:positive-float symbol)
    :reader gamma
    :initarg :gamma
    :initform 2.2)))

(defun register-color-space (name type &rest args)
  (setf (u:href (color-spaces *context*) name) (list* type :color-space type args))
  (values))

(defmacro define-builtin-color-spaces (() &body body)
  `(with-context (*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v)))
              `(register-color-space ',name ',(or model name) ,@(u:plist-remove args :model)))))
        body)))

(defun make-color-space (name)
  (u:if-found (args (u:href (color-spaces *context*) name))
    (apply #'make-instance args)
    (error "Color space ~s is not defined." name)))
