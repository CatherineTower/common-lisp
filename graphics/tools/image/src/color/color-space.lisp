(in-package #:mfiano.graphics.tools.image)

(defclass color-space ()
  ((%name
    :type (and symbol (not null))
    :reader color-space
    :initarg :name)
   (%standard-illuminant
    :type standard-illuminant
    :reader standard-illuminant
    :accessor %standard-illuminant
    :initarg :standard-illuminant)))

(declaim (inline %make-color-space))
(defun %make-color-space (color-space standard-illuminant)
  (declare (optimize speed))
  (check-type standard-illuminant (or standard-illuminant null))
  (apply #'make-instance
         color-space
         (when standard-illuminant
           `(:standard-illuminant ,standard-illuminant))))

(defmacro define-color-space (name super-classes &body (&key standard-illuminant))
  `(defclass ,name ,(or super-classes '(color-space)) ()
     (:default-initargs
      :name ',name
      :standard-illuminant ,standard-illuminant)))
