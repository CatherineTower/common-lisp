(in-package #:mfiano.graphics.tools.image)

;;;; Color space conversion routines.

;;;; NOTE: This file must be loaded after all color space types are defined because the method
;;;; specializers must reference defined classes.

;;; XYZ to sRGB

(defmethod convert ((from xyz) (to srgb)))

;;; sRGB to XYZ

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (flet ((linearize-channel (value)
           (declare ((u:f32 0f0 1f0) value))
           (let ((offset 1.055f0))
             (if (<= value 0.04045f0)
                 (* value #.(/ 12.92f0))
                 (expt (* (+ value (1- offset)) (/ offset)) 2.4f0)))))
    (declare (inline linearize-channel))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (setf (c0 from) (linearize-channel (c0 from))
          (c1 from) (linearize-channel (c1 from))
          (c2 from) (linearize-channel (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))
    to))

;;; Simple sRGB to XYZ

(defmethod convert ((from simple-srgb) (to xyz))
  (declare (optimize speed))
  (flet ((linearize-channel (value)
           (declare ((u:f32 0f0 1f0) value))
           (expt value 2.2f0)))
    (declare (inline linearize-channel))
    ;; TODO: don't mutate FROM input. Instead get a temporary color from thread-local storage.
    (setf (c0 from) (linearize-channel (c0 from))
          (c1 from) (linearize-channel (c1 from))
          (c2 from) (linearize-channel (c2 from)))
    (%transform-rgb-xyz from to (standard-illuminant from))
    to))
