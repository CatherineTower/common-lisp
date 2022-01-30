(in-package #:mfiano.graphics.tools.image)

;;; sRGB

(u:define-constant +transition-point/srgb+ 0.04045f0)

(u:define-constant +linear-gain/srgb+ 12.92f0)

(u:define-constant +linear-domain-threshold/srgb+ 0.0031308f0)

(u:define-constant +offset/srgb+ 1.055f0)

;; TODO: This assumes the standard reference whitepoint of D65 defined by sRGB. We may want to have
;; a separate API for "Chromatic Adaptation", which redefines the reference whitepoint of a color
;; space, and re-adjusts all the colors according to it.
(u:define-constant +srgb->xyz+
    (m3:mat 0.4124564 0.2126729 0.0193339
            0.3575761 0.7151522 0.1191920
            0.1804375 0.0721750 0.9503041)
  :test #'equalp)

(defclass srgb (color3) ())

(defun srgb (&optional (r 0) (g 0) (b 0))
  (make-instance 'srgb :c0 r :c1 g :c2 b))

;;; XYZ

(u:define-constant +xyz->srgb+ (m3:invert +srgb->xyz+) :test #'equalp)

(defclass xyz (color3) ())

(defun xyz (&optional (x 0) (y 0) (z 0))
  (make-instance 'xyz :c0 x :c1 y :c2 z))
