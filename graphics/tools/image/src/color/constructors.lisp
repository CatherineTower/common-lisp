(in-package #:mfiano.graphics.tools.image.color)

;;; XYZ

(defun xyz (&key (x 0) (y 0) (z 0))
  (let ((color (make-color 'xyz 'xyz)))
    (b::add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))

;;; RGB

(defun rgb (&key (r 0) (g 0) (b 0) (space 'srgb))
  (let ((color (make-color 'rgb space)))
    (b::add-mixin color 'color-storage3 :c0 r :c1 g :c2 b)))

(defun bgr (&key (b 0) (g 0) (r 0) (space 'srgb))
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-order '(b g r))
    (b::add-mixin color 'color-storage3 :c0 b :c1 g :c2 r)))

(defun rgba (&key (r 0) (b 0) (g 0) (a 1) (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-order '(r g b a))
    (b::add-mixin color 'color-storage4 :c0 r :c1 g :c2 b :c3 a)
    (b::add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

(defun bgra (&key (b 0) (g 0) (r 0) (a 1) (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-order '(b g r a))
    (b::add-mixin color 'color-storage4 :c0 b :c1 g :c2 r :c3 a)
    (b::add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

(defun argb (&key (a 1) (r 0) (g 0) (b 0) (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-order '(a r g b))
    (b::add-mixin color 'color-storage4 :c0 a :c1 r :c2 g :c3 b)
    (b::add-mixin color 'alpha :alpha-index 0 :pre-multiply-alpha pre-multiply-alpha)))

(defun abgr (&key (a 1) (b 0) (g 0) (r 0) (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-order '(a b g r))
    (b::add-mixin color 'color-storage4 :c0 a :c1 b :c2 g :c3 r)
    (b::add-mixin color 'alpha :alpha-index 0 :pre-multiply-alpha pre-multiply-alpha)))
