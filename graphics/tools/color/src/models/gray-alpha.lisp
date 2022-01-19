(in-package #:mfiano.graphics.tools.color)

(defclass gray-alpha (gray alpha) ())

(declaim (inline %gray-alpha))
(defun %gray-alpha (value alpha &key bpc)
  (%check-bpc-values bpc value alpha)
  (make-instance 'gray-alpha :bpc bpc :value value :a alpha))

(defun gray-alpha8 (&optional (value 0) (alpha #xff))
  (%gray-alpha value alpha :bpc 8))

(defun gray-alpha16 (&optional (value 0) (alpha #xffff))
  (%gray-alpha value alpha :bpc 16))

(defmethod decompose ((color gray-alpha))
  (values (value color) (a color)))

(defmethod canonicalize ((source gray-alpha))
  (let ((v (%or-shift-8bpc source (value source)))
        (a (%or-shift-8bpc source (a source))))
    (rgba16-pma v v v a)))

(defmethod convert ((source color) (target gray-alpha))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color (bpc target))
          (a target) (%or-shift-8bpc target (a color) -8))
    target))
