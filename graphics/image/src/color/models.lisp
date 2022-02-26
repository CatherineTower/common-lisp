(in-package #:%mfiano.graphics.image.color)

(defclass hsl (rgb) ()
  (:default-initargs
   :channel-names '(#\H #\S #\L)))

(defclass hsv (rgb) ()
  (:default-initargs
   :channel-names '(#\H #\S #\V)))

(defclass lab (color) ()
  (:default-initargs
   :channel-names '("L*" "a*" "b*")
   :default-space 'lab))

(defclass lchab (color) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchab))

(defclass lchuv (color) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchuv))

(defclass luv (color) ()
  (:default-initargs
   :channel-names '(#\L #\u #\v)
   :default-space 'luv))

(defclass rgb (color)
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

(defclass rgba (rgb alpha) ()
  (:default-initargs
   :channels (v4:zero)
   :channel-names '(#\R #\G #\B #\A)
   :alpha-index 3))

(defclass xyy (color) ()
  (:default-initargs
   :channel-names '(#\x #\y #\Y)
   :default-space 'xyy))

(defclass xyz (color) ()
  (:default-initargs
   :channel-names '(#\X #\Y #\Z)
   :default-space 'xyz))
