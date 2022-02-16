(in-package #:mfiano.graphics.tools.image.color)

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
    (setf (%illuminant-name xyz) (illuminant-name to))
    (base:convert from xyz)
    (base:convert xyz to)))

(define-rgb-value-converters (luv))