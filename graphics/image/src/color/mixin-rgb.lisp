(in-package #:%mfiano.graphics.image.color)

(defclass rgb-base (color)
  ((%coords
    :type list
    :reader coords
    :initarg :coords)
   (%gamma
    :type (or u:positive-float symbol)
    :reader gamma
    :initarg :gamma))
  (:default-initargs
   :channel-names '(#\R #\G #\B)
   :default-space 'srgb))
