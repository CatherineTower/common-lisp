(in-package #:mfiano.graphics.tools.image.color)

(defmethod b:convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize-rgb from)
  (transform-rgb-xyz from to (illuminant-name from)))

(defmethod b:convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (illuminant-name to))
  (delinearize-rgb to))
