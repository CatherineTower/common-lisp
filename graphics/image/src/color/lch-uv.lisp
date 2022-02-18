(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (lch-uv :illuminant d65))

(defclass lch-uv (model) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)))

(defun lch-uv (l c h)
  (make-instance 'lch-uv :channel0 l :channel1 c :channel2 h))

(defmethod default-color ((model (eql 'lch-uv)) &rest args)
  (declare (ignore args))
  (lch-uv 0 0 0))
