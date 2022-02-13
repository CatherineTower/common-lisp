(in-package #:mfiano.graphics.tools.image.color)

;;; RGB<->XYZ

(defmethod base:convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize-rgb from)
  (transform-rgb-xyz from to (illuminant-name from)))

(defmethod base:convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (illuminant-name to))
  (delinearize-rgb to))

;;; RGB<->RGB (the RGB model has multiple color spaces)

(defmethod base:convert ((from rgb) (to rgb))
  (declare (optimize speed))
  (let ((xyz (base:convert from (xyz))))
    (base:convert xyz to)))

;;; Luv<->XYZ

(defmethod base:convert ((from luv) (to xyz))
  (declare (optimize speed))
  (adapt-chromaticity from (illuminant-name to))
  (%luv->xyz from to))

(defmethod base:convert ((from xyz) (to luv))
  (declare (optimize speed))
  (adapt-chromaticity from (illuminant-name to))
  (%xyz->luv from to))

;;; Luv<->RGB

(defmethod base:convert ((from luv) (to rgb))
  (declare (optimize speed))
  (let ((xyz (base:convert from (xyz))))
    (base:convert xyz to)))

(defmethod base:convert ((from rgb) (to luv))
  (declare (optimize speed))
  (let ((xyz (base:convert from (xyz))))
    (base:convert xyz to)))
