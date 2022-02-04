(in-package #:mfiano.graphics.tools.image)

(defun rgb (r g b &key (space 'srgb))
  (check-type space rgb-space)
  (let ((color (%make-color-space space)))
    (add-mixin color 'color-storage3 :c0 r :c1 g :c2 b)))

(defun rgba (r g b a &key (space 'srgb) pre-multiply-alpha)
  (check-type space rgb-space)
  (let ((color (%make-color-space space)))
    (add-mixin color 'color-storage4 :c0 r :c1 g :c2 b :c3 a)
    (add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

(defun xyz (x y z)
  (let ((color (%make-color-space 'xyz)))
    (add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))
