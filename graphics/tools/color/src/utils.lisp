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

(declaim (inline %or-shift))
(defun %or-shift (value bit-count)
  (%wrap (* value (/ (1- (ash 1 (+ bit-count 8))) #xff)) 16))

(declaim (inline %shift-8bpc))
(defun %or-shift-8bpc (color value &optional (shift 8))
  (%or-shift value (if (= (bpc color) 8) shift 0)))

;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
(declaim (inline %encode-bt709))
(defun %encode-bt709 (rgb bpc)
  (ash (+ (* 13933 (r rgb)) (* 46871 (g rgb)) (* 4732 (b rgb)) #x8000) (+ bpc -32)))

;; NOTE: Maximum bit width returned is 34.
(defun %length-squared (color1 color2)
  (let ((color1 (canonicalize color1))
        (color2 (canonicalize color2)))
    (+ (expt (- (r color2) (r color1)) 2)
       (expt (- (g color2) (g color1)) 2)
       (expt (- (b color2) (b color1)) 2)
       (expt (- (a color2) (a color1)) 2))))
