(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; Simple sRGB to XYZ

(defmethod convert ((from simple-srgb) (to xyz))
  (declare (optimize speed))
  (flet ((inverse-compand-channel (value)
           (declare ((u:f32 0f0 1f0) value))
           (expt value 2.2f0)))
    (declare (inline inverse-compand-channel))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (let ((standard-illuminant (standard-illuminant from)))
      (setf (c0 from) (inverse-compand-channel (c0 from))
            (c1 from) (inverse-compand-channel (c1 from))
            (c2 from) (inverse-compand-channel (c2 from)))
      (%transform-rgb-xyz from to (standard-illuminant from))
      (adapt-chromaticity to standard-illuminant)
      to)))

;;; sRGB to XYZ

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (flet ((inverse-compand-channel (value)
           (declare ((u:f32 0f0 1f0) value))
           (if (<= value 0.04045f0)
               (* value #.(/ 12.92f0))
               (expt (* (+ value 0.055f0) #.(/ 1.055f0)) 2.4f0))))
    (declare (inline inverse-compand-channel))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (let ((standard-illuminant (standard-illuminant from)))
      (setf (c0 from) (inverse-compand-channel (c0 from))
            (c1 from) (inverse-compand-channel (c1 from))
            (c2 from) (inverse-compand-channel (c2 from)))
      (%transform-rgb-xyz from to standard-illuminant)
      (adapt-chromaticity to standard-illuminant)
      to)))

;;; XYZ to sRGB

(defmethod convert ((from xyz) (to srgb))
  (declare (optimize speed))
  (flet ((compand-channel (value)
           (declare ((u:f32 0f0) value))
           (if (<= value 0.0031308f0)
               (* value 12.92f0)
               (- (* (expt value #.(/ 2.4f0)) 1.055f0) 0.055f0))))
    (declare (inline compand-channel))
    (let ((standard-illuminant (standard-illuminant to)))
      (adapt-chromaticity to standard-illuminant)
      (%transform-rgb-xyz from to standard-illuminant)
      (setf (c0 to) (compand-channel (c0 to))
            (c1 to) (compand-channel (c1 to))
            (c2 to) (compand-channel (c2 to)))
      to)))
