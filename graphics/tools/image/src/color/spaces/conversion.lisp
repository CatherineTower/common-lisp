(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; Simple sRGB to XYZ

(defmethod convert ((from simple-srgb) (to xyz))
  (declare (optimize speed))
  (let ((standard-illuminant (standard-illuminant from)))
    (linearize-trc from 'gamma-2.2)
    (adapt-chromaticity to standard-illuminant)
    (%transform-rgb-xyz from to (standard-illuminant from))
    to))

;;; sRGB to XYZ

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (let ((standard-illuminant (standard-illuminant from)))
    (linearize-trc from 'srgb)
    (adapt-chromaticity to standard-illuminant)
    (%transform-rgb-xyz from to standard-illuminant)
    to))

;;; XYZ to sRGB

(defmethod convert ((from xyz) (to srgb))
  (declare (optimize speed))
  (let ((standard-illuminant (standard-illuminant to)))
    (adapt-chromaticity to standard-illuminant)
    (%transform-rgb-xyz from to standard-illuminant)
    (delinearize-trc to 'srgb)
    to))
