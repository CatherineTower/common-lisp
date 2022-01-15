(in-package #:mfiano.graphics.tools.color)

(defstruct (cmyk
            (:include model)
            (:constructor cmyk (c m y k))
            (:predicate nil)
            (:copier nil))
  (c 0 :type u:ub8)
  (m 0 :type u:ub8)
  (y 0 :type u:ub8)
  (k 0 :type u:ub8))

(defun %rgb->cmyk (r g b)
  (declare (optimize speed)
           (u:ub16 r g b))
  (let ((w (max r g b)))
    (if (zerop w)
        (values 0 0 0 #xff)
        (values (truncate (* (- w r) #xff) w)
                (truncate (* (- w g) #xff) w)
                (truncate (* (- w b) #xff) w)
                (- #xff w)))))

(defmethod decompose ((model cmyk))
  (declare (optimize speed))
  (let ((w (- #xffff (%or-shift8 (cmyk-k model)))))
    (values (truncate (* (- #xffff (%or-shift8 (cmyk-c model))) w) #xffff)
            (truncate (* (- #xffff (%or-shift8 (cmyk-m model))) w) #xffff)
            (truncate (* (- #xffff (%or-shift8 (cmyk-y model))) w) #xffff)
            #xffff)))

(defmethod convert ((source model) (target cmyk))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (u:mvlet ((c m y k (%rgb->cmyk (ash r -8) (ash g -8) (ash b -8))))
      (setf (cmyk-c target) c
            (cmyk-m target) m
            (cmyk-y target) y
            (cmyk-k target) k)
      target)))

(defmethod convert ((source model) (target (eql 'cmyk)))
  (declare (optimize speed))
  (convert source (cmyk 0 0 0 0)))
