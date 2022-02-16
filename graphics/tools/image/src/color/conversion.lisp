(in-package #:mfiano.graphics.tools.image.color)

;;; RGB <-> XYZ

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

;;; RGB <-> RGB (the RGB model has multiple color spaces)

(defmethod base:convert ((from rgb) (to rgb))
  (with-temporary-color (xyz 'xyz)
    (base:convert from xyz)
    (base:convert xyz to)))

;;; Luv <-> XYZ

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

;;; Luv <-> RGB

(defmethod base:convert ((from luv) (to rgb))
  (with-temporary-color (xyz 'xyz)
    (adapt-chromaticity xyz (illuminant-name to))
    (base:convert from xyz)
    (base:convert xyz to)))

(defmethod base:convert ((from rgb) (to luv))
  (with-temporary-color (xyz 'xyz)
    (adapt-chromaticity xyz (illuminant-name from))
    (base:convert from xyz)
    (base:convert xyz to)))
