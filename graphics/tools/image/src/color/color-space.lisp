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

(defmacro define-color-space (name standard-illuminant &optional (super-classes '(color-space)))
  "Defines NAME as a class inheriting from SUPER-CLASSES. The slot STANDARD-ILLUMINANT in the
  newly-defined class will have the provided STANDARD-ILLUMINANT as a
  DEFAULT-INITARG."
  `(defclass ,name ,super-classes ()
     (:default-initargs
      :name ',name
      :standard-illuminant ,standard-illuminant)))
