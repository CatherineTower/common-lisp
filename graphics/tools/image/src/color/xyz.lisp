(in-package #:%mfiano.graphics.tools.image.color)

(defclass xyz (model storage3) ()
  (:default-initargs
   :channel-names '(x y z)))

(defun xyz (x y z &key)
  (make-instance 'xyz :channel0 x :channel1 y :channel2 z))
