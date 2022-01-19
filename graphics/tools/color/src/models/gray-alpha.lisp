(in-package #:mfiano.graphics.tools.color)

(defclass gray-alpha (gray alpha) ())

(defun gray-alpha (value alpha &key (bpc 8))
  (make-instance 'gray-alpha :bpc bpc :value value :a alpha))

(defmethod canonicalize ((source gray-alpha))
  (let ((v (%or-shift-8bpc source (value source)))
        (a (%or-shift-8bpc source (a source))))
    (rgba16pma v v v a)))

(defmethod convert ((source color) (target gray-alpha))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color (bpc target))
          (a target) (%or-shift-8bpc target (a color) -8))
    target))
