(in-package #:mfiano.graphics.tools.color)

(declaim (inline %or-shift8))
(defun %or-shift8 (value)
  (logior value (ash value 8)))

(declaim (inline %encode-bt709))
(defun %encode-bt709 (r g b bpc)
  ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
  (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) (+ bpc -32)))
