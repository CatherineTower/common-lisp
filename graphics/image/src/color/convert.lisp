(in-package #:%mfiano.graphics.image.color)

;;; RGBA -> anything (handles un-pre-multiplying alpha before calling next method)

(defmethod base:convert ((from rgba) to)
  (with-pool-color (rgba 'rgba :space (space-name from) :copy from)
    (when (pre-multiplied-alpha-p from)
      (un-pre-multiply-alpha rgba))
    (call-next-method rgba to)))

;;; RGB <-> XYZ

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

(define-rgb-value-converters (xyz))

;;; RGB <-> xyY

(defmethod base:convert ((from rgb) (to xyy))
  (rgb->* from to))

(defmethod base:convert ((from xyy) (to rgb))
  (*->xyz->rgb from to))

;;; RGB <-> RGB (the RGB model has multiple color spaces)

(defmethod base:convert ((from rgb) (to rgb))
  (rgb->* from to))

(define-rgb-value-converters (rgb))

;;; Luv <-> XYZ

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

;;; Luv <-> RGB

(defmethod base:convert ((from rgb) (to luv))
  (rgb->* from to))

(defmethod base:convert ((from luv) (to rgb))
  (*->xyz->rgb from to))

(define-rgb-value-converters (luv))

;;; xyY <-> XYZ

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))
