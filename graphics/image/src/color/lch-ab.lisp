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
