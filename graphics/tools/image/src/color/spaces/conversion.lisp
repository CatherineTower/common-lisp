(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

(defmethod convert ((from simple-srgb) (to xyz))
  (declare (optimize speed))
  (linearize-trc from 'gamma-2.2)
  (transform-rgb-xyz from to (standard-illuminant from)))

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (linearize-trc from 'srgb)
  (transform-rgb-xyz from to (standard-illuminant from)))

(defmethod convert ((from xyz) (to simple-srgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (standard-illuminant to))
  (delinearize-trc to 'gamma-2.2))

(defmethod convert ((from xyz) (to srgb))
  (declare (optimize speed))
  (transform-rgb-xyz from to (standard-illuminant to))
  (delinearize-trc to 'srgb))
