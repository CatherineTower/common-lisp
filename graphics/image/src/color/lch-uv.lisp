(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (lch-uv :illuminant e))

(defclass lch-uv (model) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)))

(defun lch-uv (l c h &key illuminant)
  (make-instance 'lch-uv :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(defmethod default-color ((model (eql 'lch-uv)) &rest args)
  (apply #'lch-uv 0 0 0 :allow-other-keys t args))

(declaim (inline lch-uv->luv))
(defun lch-uv->luv (lch-uv luv)
  (declare (optimize speed))
  (let ((lch-channels (channels lch-uv))
        (luv-channels (channels luv)))
    (declare (v3:vec lch-channels luv-channels))
    (v3:with-components ((lch- lch-channels)
                         (luv- luv-channels))
      (let ((h (u:degrees->radians lch-z)))
        (setf luv-x lch-x
              luv-y (* lch-y (cos h))
              luv-z (* lch-y (sin h)))
        luv))))

(declaim (inline luv->lch-uv))
(defun luv->lch-uv (luv lch-uv)
  (declare (optimize speed))
  (let ((luv-channels (channels luv))
        (lch-channels (channels lch-uv)))
    (declare (v3:vec luv-channels lch-channels))
    (v3:with-components ((luv- luv-channels)
                         (lch- lch-channels))
      (let ((arctan (atan luv-z luv-y)))
        (setf lch-x luv-x
              lch-y (sqrt (+ (expt luv-y 2) (expt luv-z 2)))
              lch-z (if (plusp arctan)
                        (u:radians->degrees arctan)
                        (+ (u:radians->degrees arctan) 360)))
        lch-uv))))
