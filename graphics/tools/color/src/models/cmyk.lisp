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

;; Helper function for the CONVERT method below. This assumes 16-bit pre-multiplied alpha RGB input
;; values, as returned by DECOMPOSE, also below. It does not make sense to export this, as the
;; CONVERT function handles bi-directional conversions.
(defun %rgb->cmyk (r g b)
  (declare (optimize speed)
           (u:ub16 r g b))
  (let* ((r (ash r -8))
         (g (ash g -8))
         (b (ash b -8))
         (w (max r g b)))
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
  (u:mvlet* ((r g b (decompose source))
             (c m y k (%rgb->cmyk r g b)))
    (setf (cmyk-c target) c
          (cmyk-m target) m
          (cmyk-y target) y
          (cmyk-k target) k)
    target))

(defmethod convert ((source model) (target (eql 'cmyk)))
  (declare (optimize speed))
  (convert source (cmyk 0 0 0 0)))
