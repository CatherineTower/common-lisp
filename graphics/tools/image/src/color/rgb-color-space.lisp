(in-package #:mfiano.graphics.tools.image)

(u:define-constant +rgb-working-spaces+
    '(adobe-rgb apple-rgb best-rgb beta-rgb bruce-rgb cie-rgb colormatch-rgb don-rgb-4 eci-rgb-v2
      ekta-space-ps5 ntsc-rgb pal/secam-rgb prophoto-rgb simple-srgb smpte-c-rgb srgb
      wide-gamut-rgb)
  :test #'equal)

(deftype rgb-working-space () `(member ,@+rgb-working-spaces+))

(gv:define-global-var -rgb-chromaticity-coordinates- (u:dict))

(defclass rgb (color-space) ())

(macrolet ((define-rgb-color-space (name standard-illuminant chromaticity-coordinates)
               `(u:eval-always
                  (setf (u:href -rgb-chromaticity-coordinates- ',name) ',chromaticity-coordinates)
                  (define-color-space ,name ,standard-illuminant (rgb)))))
  (define-rgb-color-space adobe-rgb :d65 ((0.64 0.33) (0.21 0.71) (0.15 0.06)))
  (define-rgb-color-space apple-rgb :d65 ((0.625 0.34) (0.28 0.595) (0.155 0.07)))
  (define-rgb-color-space best-rgb :d50 ((0.7347 0.2653) (0.215 0.775) (0.13 0.035)))
  (define-rgb-color-space beta-rgb :d50 ((0.6888 0.3112) (0.1986 0.7551) (0.1265 0.0352)))
  (define-rgb-color-space bruce-rgb :d65 ((0.64 0.33) (0.28 0.65) (0.15 0.06)))
  (define-rgb-color-space cie-rgb :e ((0.735 0.265) (0.274 0.717) (0.167 0.009)))
  (define-rgb-color-space colormatch-rgb :d50 ((0.63 0.34) (0.295 0.605) (0.15 0.075)))
  (define-rgb-color-space don-rgb-4 :d50 ((0.696 0.3) (0.215 0.765) (0.13 0.035)))
  (define-rgb-color-space eci-rgb-v2 :d50 ((0.67 0.33) (0.21 0.71) (0.14 0.08)))
  (define-rgb-color-space ekta-space-ps5 :d50 ((0.695 0.305) (0.26 0.7) (0.11 0.005)))
  (define-rgb-color-space ntsc-rgb :c ((0.67 0.33) (0.21 0.71) (0.14 0.08)))
  (define-rgb-color-space pal/secam-rgb :d65 ((0.64 0.33) (0.29 0.6) (0.15 0.06)))
  (define-rgb-color-space prophoto-rgb :d50 ((0.7347 0.2653) (0.1596 0.8404) (0.0366 0.0001)))
  (define-rgb-color-space simple-srgb :d65 ((0.64 0.33) (0.3 0.6) (0.15 0.06)))
  (define-rgb-color-space smpte-c-rgb :d65 ((0.63 0.34) (0.31 0.595) (0.155 0.07)))
  (define-rgb-color-space srgb :d65 ((0.64 0.33) (0.3 0.6) (0.15 0.06)))
  (define-rgb-color-space wide-gamut-rgb :d50 ((0.735 0.265) (0.115 0.826) (0.157 0.018))))

(defun rgb (r g b &key (working-space 'srgb) standard-illuminant)
  (check-type working-space rgb-working-space)
  (let ((color (%make-color-space working-space standard-illuminant)))
    (add-mixin color 'color-storage3 :c0 r :c1 g :c2 b)))

(defun rgba (r g b a &key (working-space 'srgb) standard-illuminant pre-multiply-alpha)
  (check-type working-space rgb-working-space)
  (let ((color (%make-color-space working-space standard-illuminant)))
    (add-mixin color 'color-storage4 :c0 r :c1 g :c2 b :c3 a)
    (add-mixin color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))
