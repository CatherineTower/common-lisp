(in-package #:mfiano.graphics.tools.color)

(declaim (inline %or-shift8))
(defun %or-shift8 (value)
  (logior value (ash value 8)))

(declaim (inline %or-shift16))
(defun %or-shift16 (value)
  (logior value (ash value 8) (ash value 16)))

(declaim (inline %encode-bt709))
(defun %encode-bt709 (r g b bpc)
  ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
  (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) (+ bpc -32)))

(defun %length-squared (color1 color2)
  (declare (optimize speed))
  (u:mvlet ((c1r c1g c1b c1a (decompose color1))
            (c2r c2g c2b c2a (decompose color2)))
    (declare (u:ub16 c1r c1g c1b c1a c2r c2g c2b c2a))
    ;; NOTE: Maximum bit width returned is 34. Callers should optimize for type FIXNUM.
    (+ (expt (- c2r c1r) 2)
       (expt (- c2g c1g) 2)
       (expt (- c2b c1b) 2)
       (expt (- c2a c1a) 2))))
