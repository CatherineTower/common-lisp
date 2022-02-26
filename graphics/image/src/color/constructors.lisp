(in-package #:%mfiano.graphics.image.color)

(defun hsl (h s l &key (space 'srgb) illuminant)
  (make-instance 'hsl :space space :illuminant illuminant :channel0 h :channel1 s :channel2 l))

(defun hsv (h s v &key (space 'srgb) illuminant)
  (make-instance 'hsv :space space :illuminant illuminant :channel0 h :channel1 s :channel2 v))

(defun lab (l a b &key illuminant)
  (make-instance 'lab :illuminant illuminant :channel0 l :channel1 a :channel2 b))

(defun lchab (l c h &key illuminant)
  (make-instance 'lchab :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(defun lchuv (l c h &key illuminant)
  (make-instance 'lchuv :illuminant illuminant :channel0 l :channel1 c :channel2 h))

(defun luv (l u v &key illuminant)
  (make-instance 'luv :illuminant illuminant :channel0 l :channel1 u :channel2 v))

(defun rgb (r g b &key (space 'srgb) illuminant)
  (make-instance 'rgb :space space :illuminant illuminant :channel0 r :channel1 g :channel2 b))

(defun rgba (r g b a &key (space 'srgb) illuminant pre-multiply-alpha)
  (make-instance 'rgba
                 :space space
                 :illuminant illuminant
                 :pre-multiply-alpha pre-multiply-alpha
                 :channel0 r
                 :channel1 g
                 :channel2 b
                 :channel3 a))

(defun xyy (x y y* &key illuminant)
  (make-instance 'xyy :illuminant illuminant :channel0 x :channel1 y :channel2 y*))

(defun xyz (x y z &key illuminant)
  (make-instance 'xyz :illuminant illuminant :channel0 x :channel1 y :channel2 z))
