(in-package #:mfiano.graphics.tools.image)

(gv:define-global-var -rgb-spaces- nil)

(gv:define-global-var -rgb-chromaticity-coordinates- (u:dict))

(defclass rgb (color-space) ())

(defmacro define-rgb-color-space (name () &body (&key r g b standard-illuminant))
  `(u:eval-always
     (define-color-space ,name (rgb)
       :standard-illuminant ,standard-illuminant)
     (setf (u:href -rgb-chromaticity-coordinates- ',name) '(,r ,g ,b))
     (pushnew ',name -rgb-spaces-)))

(define-rgb-color-space adobe-rgb ()
  :r (0.64 0.33)
  :g (0.21 0.71)
  :b (0.15 0.06)
  :standard-illuminant :d65)

(define-rgb-color-space apple-rgb ()
  :r (0.625 0.34)
  :g (0.28 0.595)
  :b (0.155 0.07)
  :standard-illuminant :d65)

(define-rgb-color-space best-rgb ()
  :r (0.7347 0.2653)
  :g (0.215 0.775)
  :b (0.13 0.035)
  :standard-illuminant :d50)

(define-rgb-color-space beta-rgb ()
  :r (0.6888 0.3112)
  :g (0.1986 0.7551)
  :b (0.1265 0.0352)
  :standard-illuminant :d50)

(define-rgb-color-space bruce-rgb ()
  :r (0.64 0.33)
  :g (0.28 0.65)
  :b (0.15 0.06)
  :standard-illuminant :d65)

(define-rgb-color-space cie-rgb ()
  :r (0.735 0.265)
  :g (0.274 0.717)
  :b (0.167 0.009)
  :standard-illuminant :e)

(define-rgb-color-space colormatch-rgb ()
  :r (0.63 0.34)
  :g (0.295 0.605)
  :b (0.15 0.075)
  :standard-illuminant :d50)

(define-rgb-color-space don-rgb-4 ()
  :r (0.696 0.3)
  :g (0.215 0.765)
  :b (0.13 0.035)
  :standard-illuminant :d50)

(define-rgb-color-space eci-rgb-v2 ()
  :r (0.67 0.33)
  :g (0.21 0.71)
  :b (0.14 0.08)
  :standard-illuminant :d50)

(define-rgb-color-space ekta-space-ps5 ()
  :r (0.695 0.305)
  :g (0.26 0.7)
  :b (0.11 0.005)
  :standard-illuminant :d50)

(define-rgb-color-space ntsc-rgb ()
  :r (0.67 0.33)
  :g (0.21 0.71)
  :b (0.14 0.08)
  :standard-illuminant :c)

(define-rgb-color-space pal/secam-rgb ()
  :r (0.64 0.33)
  :g (0.29 0.6)
  :b (0.15 0.06)
  :standard-illuminant :d65)

(define-rgb-color-space prophoto-rgb ()
  :r (0.7347 0.2653)
  :g (0.1596 0.8404)
  :b (0.0366 0.0001)
  :standard-illuminant :d50)

(define-rgb-color-space simple-srgb ()
  :r (0.64 0.33)
  :g (0.3 0.6)
  :b (0.15 0.06)
  :standard-illuminant :d65)

(define-rgb-color-space smpte-c-rgb ()
  :r (0.63 0.34)
  :g (0.31 0.595)
  :b (0.155 0.07)
  :standard-illuminant :d65)

(define-rgb-color-space srgb ()
  :r (0.64 0.33)
  :g (0.3 0.6)
  :b (0.15 0.06)
  :standard-illuminant :d65)

(define-rgb-color-space wide-gamut-rgb ()
  :r (0.735 0.265)
  :g (0.115 0.826)
  :b (0.157 0.018)
  :standard-illuminant :d50)

(deftype rgb-space () `(member ,@-rgb-spaces-))
