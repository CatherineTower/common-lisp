(in-package #:mfiano.graphics.image.test)

(defvar *float-tolerance* 1d-10)

(defun float= (x y)
  (<= (abs (- x y)) (* *float-tolerance* (max (abs x) (abs y)))))

(defun color= (x y)
  (every (lambda (x y) (float= x y)) (c::channels x) (c::channels y)))
