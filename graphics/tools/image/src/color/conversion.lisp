(in-package #:mfiano.graphics.tools.image)

(defmethod convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize-rgb from)
  (transform-rgb-xyz from to (illuminant-name from)))

(defmethod convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (illuminant-name to))
  (delinearize-rgb to))
