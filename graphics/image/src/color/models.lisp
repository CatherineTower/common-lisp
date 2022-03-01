(in-package #:%mfiano.graphics.image.color)

(define-model hsl (rgb)
  (:channel-names '(#\H #\S #\L)))

(define-model hsv (rgb)
  (:channel-names '(#\H #\S #\V)))

(define-model lab ()
  (:channel-names '("L*" "a*" "b*")
   :default-space 'lab))

(define-model lchab ()
  (:channel-names '("L*" #\C #\H)
   :default-space 'lchab))

(define-model lchuv ()
  (:channel-names '("L*" #\C #\H)
   :default-space 'lchuv))

(define-model luv ()
  (:channel-names '(#\L #\u #\v)
   :default-space 'luv))

(define-model rgb (rgb-base))

(define-model rgba (rgb-base alpha)
  (:channels (v4:zero)
   :channel-names '(#\R #\G #\B #\A)
   :alpha-index 3))

(define-model xyy ()
  (:channel-names '(#\x #\y #\Y)
   :default-space 'xyy))

(define-model xyz ()
  (:channel-names '(#\X #\Y #\Z)
   :default-space 'xyz))
