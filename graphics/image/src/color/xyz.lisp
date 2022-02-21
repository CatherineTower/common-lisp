(in-package #:%mfiano.graphics.image.color)

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-spaces ()
  (xyz :illuminant :e))

(defclass xyz (model) ()
  (:default-initargs
   :channel-names '(#\X #\Y #\Z)))

(defun xyz (x y z &key illuminant)
  (make-instance 'xyz :illuminant illuminant :channel0 x :channel1 y :channel2 z))

(defmethod default-color ((model (eql 'xyz)) &rest args)
  (apply #'xyz 0 0 0 :allow-other-keys t args))
