(in-package #:mfiano.graphics.tools.image.color)

(defmethod b:convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize from)
  (transform-rgb-xyz from to (illuminant-name from)))

(defmethod b:convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (illuminant-name to))
  (delinearize to))

(defmethod b:convert ((from rgb) (to rgb))
  (declare (optimize speed))
  (let ((xyz (b:convert from (xyz))))
    (b:convert xyz to)))
