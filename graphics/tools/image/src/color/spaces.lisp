(in-package #:mfiano.graphics.tools.image.color)

(defclass color-space ()
  ((%color-space-name
    :type (and symbol (not null))
    :reader color-space-name
    :initarg :color-space)
   (%illuminant-name
    :type (and symbol (not null))
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
    :initarg :gamma)))

(u:define-printer (color-space stream :type nil)
  (format stream "COLOR: ~a (~a): ~{~d~^, ~}"
          (color-space-name color-space)
          (illuminant-name color-space)
          (map 'list (lambda (x) (float x 1f0)) (data color-space))))

(defun register-color-space (name type &rest args)
  (setf (u:href (b::color-spaces b::*context*) name) (list* type :color-space name args))
  (values))

(defmacro define-builtin-color-spaces (() &body body)
  `(b:with-context (b::*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v)))
              `(register-color-space ',name ',(or model name) ,@(u:plist-remove args :model)))))
        body)))

(defun make-color-space (model-name space-name)
  (u:if-found (args (u:href (b::color-spaces b::*context*) space-name))
    (destructuring-bind (required-model-name . rest) args
      (declare (ignore rest))
      (if (eq model-name required-model-name)
          (apply #'make-instance args)
          (error "Color space ~s is not valid for color model ~s." space-name model-name)))
    (error "Color space ~s is not defined." space-name)))
