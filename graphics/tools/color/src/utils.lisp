(in-package #:mfiano.graphics.tools.color)

(declaim (inline %shift))
(defun %shift (value bit-count)
  (ldb (byte 16 0) (ash value bit-count)))

(defmacro %or-shift (value bit-count)
  `(ldb (byte 16 0)
        (logior ,value
                ,@(loop :for x :from 8 :to bit-count :by 8
                        :collect `(%shift ,value ,x)))))

(declaim (inline %encode-bt709))
(defun %encode-bt709 (rgb bpc)
  ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
  (ash (+ (* 13933 (r rgb)) (* 46871 (g rgb)) (* 4732 (b rgb)) #x8000) (+ bpc -32)))

(defun %length-squared (color1 color2)
  (let ((color1 (canonicalize color1))
        (color2 (canonicalize color2)))
    ;; NOTE: Maximum bit width returned is 34.
    (+ (expt (- (r color2) (r color1)) 2)
       (expt (- (g color2) (g color1)) 2)
       (expt (- (b color2) (b color1)) 2)
       (expt (- (a color2) (a color1)) 2))))
