(in-package #:%mfiano.graphics.tools.image.color)

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

;;; RGB <-> RGB (the RGB model has multiple color spaces)

(defmethod base:convert ((from rgb) (to rgb))
  (with-pool-color (xyz 'xyz)
    (base:convert from xyz)
    (base:convert xyz to)))

(define-rgb-value-converters (rgb))

;;; Luv <-> XYZ

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

;;; Luv <-> RGB

(defmethod base:convert ((from rgb) (to luv))
  (with-pool-color (xyz 'xyz)
    (base:convert from xyz)
    (base:convert xyz to)))

(defmethod base:convert ((from luv) (to rgb))
  (with-pool-color (xyz 'xyz)
    ;; Whenever we convert from a non-RGB space to XYZ as part of an intermediary conversion, we
    ;; must set the temporary XYZ color's illuminant name to that of the target RGB.
    (copy-illuminant-name to xyz)
    (base:convert from xyz)
    (base:convert xyz to)))

(define-rgb-value-converters (luv))
