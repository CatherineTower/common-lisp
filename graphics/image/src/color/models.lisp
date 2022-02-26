(in-package #:%mfiano.graphics.image.color)

(defclass hsl (rgb) ()
  (:default-initargs
   :channel-names '(#\H #\S #\L)))

(defun hsl (h s l &key (space 'srgb) illuminant)
  (make-instance 'hsl :space space :illuminant illuminant :channel0 h :channel1 s :channel2 l))

(defclass hsv (rgb) ()
  (:default-initargs
   :channel-names '(#\H #\S #\V)))

(defun hsv (h s v &key (space 'srgb) illuminant)
  (make-instance 'hsv :space space :illuminant illuminant :channel0 h :channel1 s :channel2 v))

(defclass lab (color) ()
  (:default-initargs
   :channel-names '("L*" "a*" "b*")
   :default-space 'lab))

(defun lab (l a b &key illuminant)
  (make-instance 'lab :illuminant illuminant :channel0 l :channel1 a :channel2 b))

(defclass lchab (color) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchab))

(defun lchab (l c h &key illuminant)
  (make-instance 'lchab :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(defclass lchuv (color) ()
  (:default-initargs
   :channel-names '(#\L #\C #\H)
   :default-space 'lchuv))

(defun lchuv (l c h &key illuminant)
  (make-instance 'lchuv :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(defclass luv (color) ()
  (:default-initargs
   :channel-names '(#\L #\u #\v)
   :default-space 'luv))

(defun luv (l u v &key illuminant)
  (make-instance 'luv :illuminant illuminant :channel0 l :channel1 u :channel2 v))

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

(defun rgb (r g b &key (space 'srgb) illuminant)
  (make-instance 'rgb :space space :illuminant illuminant :channel0 r :channel1 g :channel2 b))

(defclass rgba (rgb alpha) ()
  (:default-initargs
   :channels (v4:zero)
   :channel-names '(#\R #\G #\B #\A)
   :alpha-index 3))

(defun rgba (r g b a &key (space 'srgb) illuminant pre-multiply-alpha)
  (make-instance 'rgba
                 :space space
                 :illuminant illuminant
                 :pre-multiply-alpha pre-multiply-alpha
                 :channel0 r
                 :channel1 g
                 :channel2 b
                 :channel3 a))

(defclass xyy (color) ()
  (:default-initargs
   :channel-names '(#\x #\y #\Y)
   :default-space 'xyy))

(defun xyy (x y y* &key illuminant)
  (make-instance 'xyy :illuminant illuminant :channel0 x :channel1 y :channel2 y*))

(defclass xyz (color) ()
  (:default-initargs
   :channel-names '(#\X #\Y #\Z)
   :default-space 'xyz))

(defun xyz (x y z &key illuminant)
  (make-instance 'xyz :illuminant illuminant :channel0 x :channel1 y :channel2 z))
