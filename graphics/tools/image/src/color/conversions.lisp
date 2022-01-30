(in-package #:mfiano.graphics.tools.image)

;;; Color space conversion routines.

;;; NOTE: This file must be loaded after all color space types are defined because the method
;;; specializers must reference defined classes.

;; TODO
(defmethod convert ((from xyz) (to srgb)))

(defmethod convert ((from srgb) (to xyz))
  (declare (optimize speed))
  (flet ((linearize-channel (value)
           (declare ((u:f32 0f0 1f0) value))
           (if (<= value +transition-point/srgb+)
               (* value #.(/ +linear-gain/srgb+))
               (expt (* (+ value #.(1- +offset/srgb+)) #.(/ +offset/srgb+)) 2.4f0))))
    (declare (inline linearize-channel))
    (setf (c0 to) (linearize-channel (c0 from))
          (c1 to) (linearize-channel (c1 from))
          (c2 to) (linearize-channel (c2 from)))
    ;; NOTE: The following is correct. We previously wrote the linearization of FROM to the TO
    ;; color, to preserve the original FROM. Now we are transforming the linearized sRGB color
    ;; stored in TO, to XYZ, also written to TO. By only writing to the output for both operations,
    ;; we remove the need for allocating any temporary objects.
    (transform-color to to +srgb->xyz+)))
