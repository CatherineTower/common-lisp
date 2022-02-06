(in-package #:mfiano.graphics.tools.image)

(defun rgb (&key (r 0) (g 0) (b 0) (space 'srgb))
  (check-type space rgb-space)
  (let ((color (make-instance space)))
    (add-mixin color 'color-storage3 :c0 r :c1 g :c2 b)))

(defun rgba (&key (r 0) (b 0) (g 0) (a 1) (space 'srgb) pre-multiply-alpha)
  (check-type space rgb-space)
  (let ((color (make-instance space)))
    (add-mixin color 'color-storage4 :c0 r :c1 g :c2 b :c3 a)
    (add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

(defun xyz (&key (x 0) (y 0) (z 0))
  (let ((color (make-instance 'xyz)))
    (add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))