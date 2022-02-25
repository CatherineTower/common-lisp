(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (lchuv
   :models (lchuv)
   :illuminant :e))

(defclass lchuv (model) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchuv))

(defun lchuv (l c h &key illuminant)
  (make-instance 'lchuv :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(declaim (inline lchuv->luv))
(defun lchuv->luv (lchuv luv)
  (declare (optimize speed))
  (let ((lchchannels (channels lchuv))
        (luv-channels (channels luv)))
    (declare (v3:vec lchchannels luv-channels))
    (v3:with-components ((lch lchchannels)
                         (luv- luv-channels))
      (let ((h (u:degrees->radians lchz)))
        (copy-illuminant-name lchuv luv)
        (setf luv-x lchx
              luv-y (* lchy (cos h))
              luv-z (* lchy (sin h)))
        luv))))

(declaim (inline luv->lchuv))
(defun luv->lchuv (luv lchuv)
  (declare (optimize speed))
  (let ((luv-channels (channels luv))
        (lchchannels (channels lchuv)))
    (declare (v3:vec luv-channels lchchannels))
    (v3:with-components ((luv- luv-channels)
                         (lch lchchannels))
      (let ((arctan (atan luv-z luv-y)))
        (copy-illuminant-name luv lchuv)
        (setf lchx luv-x
              lchy (sqrt (+ (expt luv-y 2) (expt luv-z 2)))
              lchz (if (plusp arctan)
                        (u:radians->degrees arctan)
                        (+ (u:radians->degrees arctan) 360)))
        lchuv))))
