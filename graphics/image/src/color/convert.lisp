(in-package #:%mfiano.graphics.image.color)

;;; XYZ -> *

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

(defmethod base:convert ((from xyz) (to cielab))
  (xyz->cielab from to))

(defmethod base:convert ((from xyz) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from xyz) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

;;; xyY -> *

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))

(defmethod base:convert ((from xyy) (to cielab))
  (error "Not implemented."))

(defmethod base:convert ((from xyy) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from xyy) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from xyy) (to luv))
  (error "Not implemented."))

(defmethod base:convert ((from xyy) (to rgb))
  (*->xyz->rgb from to))

;;; CIELAB -> *

(defmethod base:convert ((from cielab) (to xyz))
  (cielab->xyz from to))

(defmethod base:convert ((from cielab) (to xyy))
  (error "Not implemented."))

(defmethod base:convert ((from cielab) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from cielab) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from cielab) (to luv))
  (error "Not implemented."))

(defmethod base:convert ((from cielab) (to rgb))
  (*->xyz->rgb from to))

;;; LCHab -> *

(defmethod base:convert ((from lch-ab) (to xyz))
  (error "Not implemented."))

(defmethod base:convert ((from lch-ab) (to xyy))
  (error "Not implemented."))

(defmethod base:convert ((from lch-ab) (to cielab))
  (error "Not implemented."))

(defmethod base:convert ((from lch-ab) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from lch-ab) (to luv))
  (error "Not implemented."))

(defmethod base:convert ((from lch-ab) (to rgb))
  (error "Not implemented."))

;;; Luv -> *

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from luv) (to xyy))
  (error "Not implemented."))

(defmethod base:convert ((from luv) (to cielab))
  (error "Not implemented."))

(defmethod base:convert ((from luv) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from luv) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from luv) (to rgb))
  (*->xyz->rgb from to))

;;; LCHuv -> *

(defmethod base:convert ((from lch-uv) (to xyz))
  (error "Not implemented."))

(defmethod base:convert ((from lch-uv) (to xyy))
  (error "Not implemented."))

(defmethod base:convert ((from lch-uv) (to cielab))
  (error "Not implemented."))

(defmethod base:convert ((from lch-uv) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from lch-uv) (to luv))
  (error "Not implemented."))

(defmethod base:convert ((from lch-uv) (to rgb))
  (error "Not implemented."))

;;; RGB <-> *

(defmethod base:convert ((from rgba) to)
  (with-pool-color (rgba 'rgba :space (space-name from) :copy from)
    (when (pre-multiplied-alpha-p from)
      (un-pre-multiply-alpha rgba))
    (call-next-method rgba to)))

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from rgb) (to xyy))
  (rgb->* from to))

(defmethod base:convert ((from rgb) (to cielab))
  (rgb->* from to))

(defmethod base:convert ((from rgb) (to lch-ab))
  (error "Not implemented."))

(defmethod base:convert ((from rgb) (to lch-uv))
  (error "Not implemented."))

(defmethod base:convert ((from rgb) (to luv))
  (rgb->* from to))

(defmethod base:convert ((from rgb) (to rgb))
  (rgb->* from to))

(define-rgb-value-converters (xyz))
(define-rgb-value-converters (xyy))
(define-rgb-value-converters (cielab))
(define-rgb-value-converters (lch-ab))
(define-rgb-value-converters (lch-uv))
(define-rgb-value-converters (luv))
(define-rgb-value-converters (rgb))
