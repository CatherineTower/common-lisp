(in-package #:mfiano.graphics.tools.image)

;;; Base class that all color spaces inherit from.

(defclass color-space ()
  ((%standard-illuminant
    :type standard-illuminant
    :reader standard-illuminant
    :initarg :standard-illuminant)))

(declaim (inline %make-color-space))
(defun %make-color-space (color-space standard-illuminant)
  (declare (optimize speed))
  (check-type standard-illuminant (or standard-illuminant null))
  (apply #'make-instance
         color-space
         (when standard-illuminant
           `(:standard-illuminant ,standard-illuminant))))

;;; RGB

(defclass adobe-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass apple-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass best-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass beta-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass bruce-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass cie-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :e))

(defclass colormatch-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass don-rgb-4 (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass eci-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass ekta-space-ps5 (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass ntsc-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :c))

(defclass pal/secam-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass prophoto-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defclass smtpe-c-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass srgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d65))

(defclass wide-gamut-rgb (color-space) ()
  (:default-initargs
   :standard-illuminant :d50))

(defun rgb (r g b &key (working-space 'srgb) standard-illuminant)
  (check-type working-space rgb-working-space)
  (let ((color (%make-color-space working-space standard-illuminant)))
    (add-mixin color 'color-storage3 :c0 r :c1 g :c2 b)))

(defun rgba (r g b a &key (working-space 'srgb) standard-illuminant pre-multiply-alpha)
  (check-type working-space rgb-working-space)
  (let ((color (%make-color-space working-space standard-illuminant)))
    (add-mixin color 'color-storage4 :c0 r :c1 g :c2 b :c3 a)
    (add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

;;; XYZ

(defclass xyz (color-space) ()
  (:default-initargs
   :standard-illuminant :e))

(defun xyz (x y z &key standard-illuminant)
  (let ((color (%make-color-space 'xyz standard-illuminant)))
    (add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))
