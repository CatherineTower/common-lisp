(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; RGB -> XYZ

(defmethod convert ((from rgb) (to xyz))
  (declare (optimize speed))
  (linearize-rgb from)
  (transform-rgb-xyz from to (standard-illuminant from)))

;;; XYZ -> RGB

(defmethod convert ((from xyz) (to rgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (standard-illuminant to))
  (delinearize-rgb to))
