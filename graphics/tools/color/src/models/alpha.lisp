(in-package #:mfiano.graphics.tools.color)

(defclass alpha (color)
  ((%a :accessor a
       :initarg :a
       :initform 0)))

(declaim (inline %alpha))
(defun %alpha (value &key bpc)
  (%check-bpc-values bpc value)
  (make-instance 'alpha :bpc bpc :a value))

(defun alpha8 (&optional (value #xff))
  (%alpha value :bpc 8))

(defun alpha16 (&optional (value #xffff))
  (%alpha value :bpc 16))

(defmethod decompose ((color alpha))
  (a color))

(defmethod canonicalize ((source alpha))
  (let ((a (%or-shift-8bpc source (a source))))
    (rgba16-pma a a a a)))

(defmethod convert ((source color) (target alpha))
  (let ((color (canonicalize source)))
    (setf (a target) (%or-shift-8bpc target (a color) -8))
    target))
