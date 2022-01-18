(in-package #:mfiano.graphics.tools.color)

(defclass gray-alpha (gray alpha) ())

(defun gray-alpha (value alpha &key (bpc 8))
  (make-instance 'gray-alpha :bpc bpc :value value :a alpha))

(defmethod canonicalize ((color gray-alpha))
  (let ((v (%or-shift (value color) 8))
        (a (%or-shift (a color) 8)))
    (rgba v v v a :bpc 16 :pma t)))

(defmethod convert ((source color) (target gray-alpha))
  (let ((color (canonicalize source))
        (bpc (bpc target)))
    (setf (value target) (%encode-bt709 color bpc)
          (a target) (if (= bpc 8) (%shift (a color) -8) (a color)))
    target))
