(in-package #:mfiano.graphics.tools.color)

(defclass gray (color)
  ((%value :accessor value
           :initarg :value
           :initform 0)))

(declaim (inline %gray))
(defun %gray (value &key bpc)
  (%check-bpc-values bpc value)
  (make-instance 'gray :bpc bpc :value value))

(defun gray8 (&optional (value 0))
  (%gray value :bpc 8))

(defun gray16 (&optional (value 0))
  (%gray value :bpc 16))

(defmethod decompose ((color gray))
  (value color))

(defmethod canonicalize ((source gray))
  (let ((v (%or-shift-8bpc source (value source))))
    (rgba16-pma v v v)))

(defmethod convert ((source color) (target gray))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color (bpc target)))
    target))
