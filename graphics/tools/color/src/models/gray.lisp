(in-package #:mfiano.graphics.tools.color)

(defclass gray (color)
  ((%value :accessor value
           :initarg :value
           :initform 0)))

(defun gray (value &key (bpc 8))
  (make-instance 'gray :bpc bpc :value value))

(defmethod canonicalize ((source gray))
  (let ((v (%or-shift-8bpc source (value source))))
    (rgba v v v #xffff :bpc 16 :pma t)))

(defmethod convert ((source color) (target gray))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color (bpc target)))
    target))
