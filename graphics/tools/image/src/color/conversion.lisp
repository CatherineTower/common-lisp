(in-package #:mfiano.graphics.tools.image.color)

;;; RGB<->XYZ

;; NOTE: Chromatic adaptation is implicitly encoded in the rgb/xyz transformation matrix, so we
;; don't need to explicitly adapt.
(defmethod base:convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize-rgb from)
  (transform-rgb-xyz from to (illuminant-name from)))

;; NOTE: Chromatic adaptation is implicitly encoded in the rgb/xyz transformation matrix, so we
;; don't need to explicitly adapt.
(defmethod base:convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (illuminant-name to))
  (delinearize-rgb to))

;;; RGB<->RGB (the RGB model has multiple color spaces)

;; NOTE: Chromatic adaptation is implicitly encoded in the rgb/xyz transformation matrix, so we
;; don't need to explicitly adapt.
(defmethod base:convert ((from rgb) (to rgb))
  (declare (optimize speed))
  (let ((xyz (base:convert from (xyz))))
    (base:convert xyz to)))

;;; Luv<->XYZ

(defmethod base:convert ((from luv) (to xyz))
  (declare (optimize speed))
  (%luv->xyz from to))

(defmethod base:convert ((from xyz) (to luv))
  (declare (optimize speed))
  (%xyz->luv from to))

;;; Luv<->RGB

(defmethod base:convert ((from luv) (to rgb))
  (declare (optimize speed))
  (let ((xyz (xyz)))
    (adapt-chromaticity xyz (illuminant-name to))
    (base:convert from xyz)
    (base:convert xyz to)))

(defmethod base:convert ((from rgb) (to luv))
  (declare (optimize speed))
  (let ((xyz (xyz)))
    (adapt-chromaticity xyz (illuminant-name from))
    (base:convert from xyz)
    (base:convert xyz to)))
