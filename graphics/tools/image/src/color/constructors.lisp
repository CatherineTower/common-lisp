(in-package #:mfiano.graphics.tools.image.color)

;;; XYZ

(defun xyz (&key (x 0) (y 0) (z 0))
  (let ((color (make-color 'xyz 'xyz)))
    (b::add-mixin color 'storage3 :channel0 x :channel1 y :channel2 z)))

;;; RGB

(defun rgb (&key (r 0) (g 0) (b 0) (space 'srgb))
  (let ((color (make-color 'rgb space)))
    (b::add-mixin color 'storage3 :channel0 r :channel1 g :channel2 b)))

(defun rgba (&key (r 0) (b 0) (g 0) (a 1) (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-names '(r g b a))
    (b::add-mixin color 'storage4 :channel0 r :channel1 g :channel2 b :channel3 a)
    (b::add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))
