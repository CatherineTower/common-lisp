(in-package #:mfiano.graphics.tools.image)

(define-color-space xyz ()
  :standard-illuminant :e)

(defun xyz (x y z &key standard-illuminant)
  (let ((color (%make-color-space 'xyz standard-illuminant)))
    (add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))
