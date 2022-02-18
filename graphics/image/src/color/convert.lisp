(in-package #:%mfiano.graphics.image.color)

;;; RGB <-> *

(defmethod base:convert ((from rgba) to)
  (with-pool-color (rgba 'rgba :space (space-name from) :copy from)
    (when (pre-multiplied-alpha-p from)
      (un-pre-multiply-alpha rgba))
    (call-next-method rgba to)))

(defmethod base:convert ((from rgb) (to rgb))
  (rgb->* from to))

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

(defmethod base:convert ((from rgb) (to xyy))
  (rgb->* from to))

(defmethod base:convert ((from xyy) (to rgb))
  (*->xyz->rgb from to))

(defmethod base:convert ((from rgb) (to luv))
  (rgb->* from to))

(defmethod base:convert ((from luv) (to rgb))
  (*->xyz->rgb from to))

(define-rgb-value-converters (rgb))
(define-rgb-value-converters (xyz))
(define-rgb-value-converters (xyy))
(define-rgb-value-converters (luv))

;;; XYZ <-> *

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))
