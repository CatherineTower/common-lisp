(in-package #:%mfiano.graphics.image.color)

;;; Macro helper

(defmacro with-convert ((from to) &body body)
  `(with-pool-colors (,@(butlast (rest (car body))))
     ,@(loop :with last := (first (last (car body)))
             :for (x y) :on (car body) :by #'cdr
             :for first := from :then nil
             :for op := (u:symbolicate x '#:-> y)
             :when first
               :collect `(copy-illuminant-name ,to ,y)
             :unless (or (eq x last) (eq y last))
               :collect `(,op ,(if first from x) ,y)
             :when (and y (eq y last))
               :collect `(,op ,x ,to))))

;;; From XYZ

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

(defmethod base:convert ((from xyz) (to cielab))
  (xyz->cielab from to))

(defmethod base:convert ((from xyz) (to lch-ab))
  (with-convert (from to)
    (xyz cielab lch-ab)))

(defmethod base:convert ((from xyz) (to lch-uv))
  (with-convert (from to)
    (xyz luv lch-uv)))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

;;; From xyY

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))

(defmethod base:convert ((from xyy) (to cielab))
  (with-convert (from to)
    (xyy xyz cielab)))

(defmethod base:convert ((from xyy) (to lch-ab))
  (with-convert (from to)
    (xyy xyz cielab lch-ab)))

(defmethod base:convert ((from xyy) (to lch-uv))
  (with-convert (from to)
    (xyy xyz luv lch-uv)))

(defmethod base:convert ((from xyy) (to luv))
  (with-convert (from to)
    (xyy xyz luv)))

(defmethod base:convert ((from xyy) (to rgb))
  (with-convert (from to)
    (xyy xyz rgb)))

;;; From CIELAB

(defmethod base:convert ((from cielab) (to xyz))
  (cielab->xyz from to))

(defmethod base:convert ((from cielab) (to xyy))
  (with-convert (from to)
    (cielab xyz xyy)))

(defmethod base:convert ((from cielab) (to lch-ab))
  (cielab->lch-ab from to))

(defmethod base:convert ((from cielab) (to lch-uv))
  (with-convert (from to)
    (cielab xyz luv lch-uv)))

(defmethod base:convert ((from cielab) (to luv))
  (with-convert (from to)
    (cielab xyz luv)))

(defmethod base:convert ((from cielab) (to rgb))
  (with-convert (from to)
    (cielab xyz rgb)))

;;; From LCHab

(defmethod base:convert ((from lch-ab) (to xyz))
  (with-convert (from to)
    (lch-ab cielab xyz)))

(defmethod base:convert ((from lch-ab) (to xyy))
  (with-convert (from to)
    (lch-ab cielab xyz xyy)))

(defmethod base:convert ((from lch-ab) (to cielab))
  (lch-ab->cielab from to))

(defmethod base:convert ((from lch-ab) (to lch-uv))
  (with-convert (from to)
    (lch-ab cielab xyz luv lch-uv)))

(defmethod base:convert ((from lch-ab) (to luv))
  (with-convert (from to)
    (lch-ab cielab xyz luv)))

(defmethod base:convert ((from lch-ab) (to rgb))
  (with-convert (from to)
    (lch-ab cielab xyz rgb)))

;;; From LCHuv

(defmethod base:convert ((from lch-uv) (to xyz))
  (with-convert (from to)
    (lch-uv luv xyz)))

(defmethod base:convert ((from lch-uv) (to xyy))
  (with-convert (from to)
    (lch-uv luv xyz xyy)))

(defmethod base:convert ((from lch-uv) (to cielab))
  (with-convert (from to)
    (lch-uv luv xyz cielab)))

(defmethod base:convert ((from lch-uv) (to lch-ab))
  (with-convert (from to)
    (lch-uv luv xyz cielab lch-ab)))

(defmethod base:convert ((from lch-uv) (to luv))
  (lch-uv->luv from to))

(defmethod base:convert ((from lch-uv) (to rgb))
  (with-convert (from to)
    (lch-uv luv xyz rgb)))

;;; From Luv

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from luv) (to xyy))
  (with-convert (from to)
    (luv xyz xyy)))

(defmethod base:convert ((from luv) (to cielab))
  (with-convert (from to)
    (luv xyz cielab)))

(defmethod base:convert ((from luv) (to lch-ab))
  (with-convert (from to)
    (luv xyz cielab lch-ab)))

(defmethod base:convert ((from luv) (to lch-uv))
  (luv->lch-uv from to))

(defmethod base:convert ((from luv) (to rgb))
  (with-convert (from to)
    (luv xyz rgb)))

;;; From RGB/RGBA

(defmethod base:convert ((from rgba) to)
  (with-pool-color (rgba 'rgba :space (space-name from) :copy from)
    (when (pre-multiplied-alpha-p from)
      (un-pre-multiply-alpha rgba))
    (call-next-method rgba to)))

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from rgb) (to xyy))
  (with-convert (from to)
    (rgb xyz xyy)))

(defmethod base:convert ((from rgb) (to cielab))
  (with-convert (from to)
    (rgb xyz cielab)))

(defmethod base:convert ((from rgb) (to lch-ab))
  (with-convert (from to)
    (rgb xyz cielab lch-ab)))

(defmethod base:convert ((from rgb) (to lch-uv))
  (with-convert (from to)
    (rgb xyz luv lch-uv)))

(defmethod base:convert ((from rgb) (to luv))
  (with-convert (from to)
    (rgb xyz luv)))

(defmethod base:convert ((from rgb) (to rgb))
  (rgb->* from to))

(define-rgb-value-converters (xyz))
(define-rgb-value-converters (xyy))
(define-rgb-value-converters (cielab))
(define-rgb-value-converters (lch-ab))
(define-rgb-value-converters (lch-uv))
(define-rgb-value-converters (luv))
(define-rgb-value-converters (rgb))
