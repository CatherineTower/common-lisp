(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (lch-ab :illuminant d65))

(defclass lch-ab (model) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)))

(defun lch-ab (l c h)
  (make-instance 'lch-ab :channel0 l :channel1 c :channel2 h))

(defmethod default-color ((model (eql 'lch-ab)) &rest args)
  (declare (ignore args))
  (lch-ab 0 0 0))

(declaim (inline lch-ab->cielab))
(defun lch-ab->cielab (lch-ab cielab)
  (declare (optimize speed))
  (let ((lch-channels (channels lch-ab))
        (lab-channels (channels cielab)))
    (declare (v3:vec lch-channels lab-channels))
    (v3:with-components ((lch- lch-channels)
                         (lab- lab-channels))
      (let ((h (u:degrees->radians lch-z)))
        (setf lab-x lch-x
              lab-y (* lch-y (cos h))
              lab-z (* lch-y (sin h)))
        cielab))))

(declaim (inline cielab->lch-ab))
(defun cielab->lch-ab (cielab lch-ab)
  (declare (optimize speed))
  (let ((lab-channels (channels cielab))
        (lch-channels (channels lch-ab)))
    (declare (v3:vec lab-channels lch-channels))
    (v3:with-components ((lab- lab-channels)
                         (lch- lch-channels))
      (let ((arctan (atan lab-z lab-y)))
        (setf lch-x lab-x
              lch-y (sqrt (+ (expt lab-y 2) (expt lab-z 2)))
              lch-z (if (plusp arctan)
                        (u:radians->degrees arctan)
                        (+ (u:radians->degrees arctan) 360)))
        lch-ab))))