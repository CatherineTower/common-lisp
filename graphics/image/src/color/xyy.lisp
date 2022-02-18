(in-package #:%mfiano.graphics.image.color)

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-spaces ()
  (xyy :illuminant e))

(defclass xyy (model) ()
  (:default-initargs
   :channel-names '(#\x #\y #\Y)))

(defun xyy (|x| |y| Y)
  (make-instance 'xyy :channel0 |x| :channel1 |y| :channel2 Y))

(defmethod default-color ((mode (eql 'xyy)) &rest args)
  (declare (ignore args))
  (xyy 0 0 0))

(declaim (inline xyy->xyz))
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

(declaim (inline xyz->xyy))
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
