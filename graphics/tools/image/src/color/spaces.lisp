(in-package #:mfiano.graphics.tools.image)

(defmacro define-color-space (name standard-illuminant super-classes)
  `(defclass ,name ,(or super-classes '(color-space)) ()
     (:default-initargs
      :name ',name
      :standard-illuminant ,standard-illuminant)))

(defclass color-space ()
  ((%name
    :type (and symbol (not null))
    :reader color-space
    :initarg :name)
   (%standard-illuminant
    :type standard-illuminant
    :reader standard-illuminant
    :accessor %standard-illuminant
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

(defclass rgb (color-space) ())
(define-color-space adobe-rgb :d65 (rgb))
(define-color-space apple-rgb :d65 (rgb))
(define-color-space best-rgb :d50 (rgb))
(define-color-space beta-rgb :d50 (rgb))
(define-color-space bruce-rgb :d65 (rgb))
(define-color-space cie-rgb :e (rgb))
(define-color-space colormatch-rgb :d50 (rgb))
(define-color-space don-rgb-4 :d50 (rgb))
(define-color-space eci-rgb :d50 (rgb))
(define-color-space ekta-space-ps5 :d50 (rgb))
(define-color-space ntsc-rgb :c (rgb))
(define-color-space pal/secam-rgb :d65 (rgb))
(define-color-space prophoto-rgb :d50 (rgb))
(define-color-space simple-srgb :d65 (rgb))
(define-color-space smtpe-c-rgb :d65 (rgb))
(define-color-space srgb :d65 (rgb))
(define-color-space wide-gamut-rgb :d50 (rgb))

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

(define-color-space xyz :d50 ())

(defun xyz (x y z &key standard-illuminant)
  (let ((color (%make-color-space 'xyz standard-illuminant)))
    (add-mixin color 'color-storage3 :c0 x :c1 y :c2 z)))
