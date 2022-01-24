(in-package #:mfiano.graphics.tools.color)

(defun %check-bpc-values (bpc &rest values)
  (unless (every (lambda (x) (typep x `(unsigned-byte ,bpc))) values)
    (error "Color component is not a ~dbit unsigned integer." bpc)))

(declaim (inline %wrap))
(defun %wrap (value bit-count)
  (ldb (byte bit-count 0) value))

(declaim (inline %shift))
(defun %shift (value bit-count)
  (%wrap (ash value bit-count) 16))

;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
(declaim (inline %encode-bt709))
(defun %encode-bt709 (r g b bpc)
  (ash (+ (* r 13933) (* g 46871) (* b 4732) #x8000) (+ bpc -32)))

(defun %length-squared (color1 color2)
  (with-channels ((r1 g1 b1 a1) (%canonicalize color1))
    (with-channels ((r2 g2 b2 a2) (%canonicalize color2))
      (+ (expt (- r2 r1) 2)
         (expt (- g2 g1) 2)
         (expt (- b2 b1) 2)
         (expt (- a2 a1) 2)))))
