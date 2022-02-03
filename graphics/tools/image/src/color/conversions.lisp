(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; XYZ to sRGB

(defmethod convert ((from xyz) (to srgb))
  (declare (optimize speed))
  (flet ((compand (value)
           (declare ((u:f32 0f0) value))
           (let ((offset 1.055f0))
             (if (<= value 0.0031308f0)
                 (* value 12.92f0)
                 (+ (expt (* value offset) (/ 2.4f0)) (1- offset))))))
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
           (let ((offset 1.055f0))
             (if (<= value 0.04045f0)
                 (* value #.(/ 12.92f0))
                 (expt (* (+ value (1- offset)) (/ offset)) 2.4f0)))))
    (declare (inline invert-compansion))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (setf (c0 from) (invert-compansion (c0 from))
          (c1 from) (invert-compansion (c1 from))
          (c2 from) (invert-compansion (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))))
