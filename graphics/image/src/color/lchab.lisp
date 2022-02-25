(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (lchab
   :models (lchab)
   :illuminant :d65))

(defclass lchab (model) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchab))

(defun lchab (l c h &key illuminant)
  (make-instance 'lchab :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(declaim (inline lchab->lab))
(defun lchab->lab (lchab lab)
  (declare (optimize speed))
  (let ((lchchannels (channels lchab))
        (lab-channels (channels lab)))
    (declare (v3:vec lchchannels lab-channels))
    (v3:with-components ((lch lchchannels)
                         (lab- lab-channels))
      (let ((h (u:degrees->radians lchz)))
        (copy-illuminant-name lchab lab)
        (setf lab-x lchx
              lab-y (* lchy (cos h))
              lab-z (* lchy (sin h)))
        lab))))

(declaim (inline lab->lchab))
(defun lab->lchab (lab lchab)
  (declare (optimize speed))
  (let ((lab-channels (channels lab))
        (lchchannels (channels lchab)))
    (declare (v3:vec lab-channels lchchannels))
    (v3:with-components ((lab- lab-channels)
                         (lch lchchannels))
      (let ((arctan (atan lab-z lab-y)))
        (copy-illuminant-name lab lchab)
        (setf lchx lab-x
              lchy (sqrt (+ (expt lab-y 2) (expt lab-z 2)))
              lchz (if (plusp arctan)
                        (u:radians->degrees arctan)
                        (+ (u:radians->degrees arctan) 360)))
        lchab))))
