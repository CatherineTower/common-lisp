(in-package #:%mfiano.graphics.tools.image.color)

(defclass illuminant ()
  ((%name
    :type (and symbol (not null))
    :reader name
    :initarg :name)
   (%x
    :type u:positive-real
    :reader x
    :initarg :x)
   (%y
    :type u:positive-real
    :reader y
    :initarg :y)
   (%white-point
    :type v3:vec
    :reader white-point
    :initarg :white-point)))

(u:define-printer (illuminant stream)
  (format stream "~s" (name illuminant)))

(defun register-illuminant (name x y)
  (assert (and (plusp x) (plusp y)))
  (let* ((white-point (v3:vec (/ x y) 1 (/ (- 1 x y) y)))
         (illuminant (make-instance 'illuminant :name name :x x :y y :white-point white-point)))
    (setf (u:href (base:illuminants base:*context*) name) illuminant)
    (values)))

(defmacro define-builtin-illuminants (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name &key x y) x
            `(register-illuminant ',name ,x ,y)))
        body)))

(declaim (inline get-white-point))
(defun get-white-point (illuminant-name)
  (declare (optimize speed))
  (white-point (u:href (base:illuminants base:*context*) illuminant-name)))
