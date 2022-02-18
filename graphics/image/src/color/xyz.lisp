(in-package #:%mfiano.graphics.image.color)

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-spaces ()
  (xyz :illuminant e))

(defclass xyz (model) ()
  (:default-initargs
   :channel-names '(x y z)))

(defun xyz (x y z &key)
  (make-instance 'xyz :channel0 x :channel1 y :channel2 z))

(defmethod default-color ((model (eql 'xyz)) &rest args)
  (declare (ignore args))
  (xyz 0 0 0))
