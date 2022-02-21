(in-package #:%mfiano.graphics.image.color)

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-spaces ()
  (:xyy
   :models (xyy)
   :illuminant :e))

(defclass xyy (model) ()
  (:default-initargs
   :channel-names '(#\x #\y #\Y)))

(defun xyy (|x| |y| Y &key illuminant)
  (make-instance 'xyy :illuminant illuminant :channel0 |x| :channel1 |y| :channel2 Y))

(declaim (notinline xyy->xyz))
(defun xyy->xyz (xyy xyz)
  (declare (optimize speed))
  (let ((xyy-channels (channels xyy))
        (xyz-channels (channels xyz)))
    (declare (v3:vec xyy-channels xyz-channels))
    (v3:with-components ((xyy- xyy-channels)
                         (xyz- xyz-channels))
      (if (zerop xyy-y)
          (v3:zero! xyz-channels)
          (setf xyz-x (/ (* xyy-x xyy-z) xyy-y)
                xyz-y xyy-z
                xyz-z (/ (* (- 1 xyy-x xyy-y) xyy-z) xyy-y)))
      xyz)))

(declaim (notinline xyz->xyy))
(defun xyz->xyy (xyz xyy)
  (declare (optimize speed))
  (let ((xyz-channels (channels xyz))
        (xyy-channels (channels xyy)))
    (declare (v3:vec xyz-channels xyy-channels))
    (v3:with-components ((xyz- xyz-channels)
                         (xyy- xyy-channels))
      (let ((x+y+z (+ xyz-x xyz-y xyz-z)))
        (setf xyy-x (if (zerop x+y+z) 0d0 (/ xyz-x x+y+z))
              xyy-y (if (zerop x+y+z) 0d0 (/ xyz-y x+y+z))
              xyy-z xyz-y)
        xyy))))
