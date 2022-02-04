(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; XYZ to sRGB

(defmethod convert ((from xyz) (to srgb))
  (declare (optimize speed))
  (flet ((compand (value)
           (declare ((u:f32 0f0) value))
           (if (<= value 0.0031308f0)
               (* value 12.92f0)
               (- (expt (* value 1.055f0) #.(/ 2.4f0)) 0.055f0))))
    (declare (inline compand))
    (setf (c0 from) (compand (c0 from))
          (c1 from) (compand (c1 from))
          (c2 from) (compand (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))))

;;; Simple sRGB to XYZ

(defmethod convert ((from simple-srgb) (to xyz))
  (declare (optimize speed))
  (flet ((invert-compansion (value)
           (declare ((u:f32 0f0 1f0) value))
           (expt value 2.2f0)))
    (declare (inline invert-compansion))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (setf (c0 from) (invert-compansion (c0 from))
          (c1 from) (invert-compansion (c1 from))
          (c2 from) (invert-compansion (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))))

;;; sRGB to XYZ

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (flet ((invert-compansion (value)
           (declare ((u:f32 0f0 1f0) value))
           (if (<= value 0.04045f0)
               (* value #.(/ 12.92f0))
               (expt (* (+ value 0.055f0) #.(/ 1.055f0)) 2.4f0))))
    (declare (inline invert-compansion))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (setf (c0 from) (invert-compansion (c0 from))
          (c1 from) (invert-compansion (c1 from))
          (c2 from) (invert-compansion (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))

    ;; HACK: Perform chromatic adaptation
    ;; NOTE: For some reason this only works if the :standard-illuminant is not specified for the
    ;; sRGB source, but specifying it for the XYZ target seems to match up with Lindbloom's
    ;; calculator for any RGB triplet I tested. Why can't we specify a source standard illuminant???
    (m3:*v3! (data to)
             (get-chromatic-adaptation-matrix
              'bradford
              (standard-illuminant from)
              (standard-illuminant to))
             (data to))

    to))
