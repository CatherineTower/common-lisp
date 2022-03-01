(in-package #:%mfiano.graphics.image.color)

(defun register-color-space (space-name model-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-space-data base:*context*) space-name) args)
    (values)))

(defmacro define-color-space (name () &key (model name) (illuminant :d65) (gamma 2.2d0) coords)
  `(register-color-space ',name ',model :illuminant ',illuminant :gamma ',gamma :coords ',coords))

;; Reference: http://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf
(define-color-space adobe-rgb ()
  :model rgb
  :gamma #.(float 563/256 1d0)
  :coords ((0.64d0 0.33d0) (0.21d0 0.71d0) (0.15d0 0.06d0)))

;; Reference: https://en.wikipedia.org/wiki/Wide-gamut_RGB_color_space
(define-color-space adobe-wide-gamut-rgb ()
  :model rgb
  :illuminant :d50
  :gamma #.(float 563/256 1d0)
  :coords ((0.7347d0 0.2653d0) (0.1152d0 0.8264d0) (0.1566d0 0.0177d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space apple-rgb ()
  :model rgb
  :gamma 1.8d0
  :coords ((0.625d0 0.34d0) (0.28d0 0.595d0) (0.155d0 0.07d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space best-rgb ()
  :model rgb
  :illuminant :d50
  :coords ((0.7347d0 0.2653d0) (0.215d0 0.775d0) (0.13d0 0.035d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space beta-rgb ()
  :model rgb
  :illuminant :d50
  :coords ((0.6888d0 0.3112d0) (0.1986d0 0.7551d0) (0.1265d0 0.0352d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space bruce-rgb ()
  :model rgb
  :coords ((0.64d0 0.33d0) (0.28d0 0.65d0) (0.15d0 0.06d0)))

;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.2020-1-201406-S!!PDF-E.pdf
(define-color-space bt2020 ()
  :model rgb
  :gamma rec.709
  :coords ((0.708d0 0.292d0) (0.17d0 0.797d0) (0.131d0 0.046d0)))

;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.470-6-199811-S!!PDF-E.pdf
(define-color-space bt470-ntsc ()
  :model rgb
  :illuminant :c
  :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0)))

(define-color-space bt470-pal/secam ()
  :model rgb
  :gamma 2.8d0
  :coords ((0.64d0 0.33d0) (0.29d0 0.6d0) (0.15d0 0.06d0)))

;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.709-5-200204-S!!PDF-E.pdf
(define-color-space bt709 ()
  :model rgb
  :gamma rec.709
  :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space cie-rgb ()
  :model rgb
  :illuminant :e
  :coords ((0.7347d0 0.2653d0) (0.2738d0 0.7174d0) (0.1666d0 0.0089d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space colormatch-rgb ()
  :model rgb
  :illuminant :d50
  :gamma 1.8d0
  :coords ((0.63d0 0.34d0) (0.295d0 0.605d0) (0.15d0 0.075d0)))

;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
(define-color-space dci-p3 ()
  :model rgb
  :illuminant :dci
  :gamma 2.6d0
  :coords ((0.68d0 0.32d0) (0.265d0 0.69d0) (0.15d0 0.06d0)))

;; Reference: https://en.wikipedia.org/wiki/DCI-P3#DCI-P3+_and_Cinema_Gamut
(define-color-space dci-p3+ ()
  :model rgb
  :illuminant :dci
  :gamma 2.6d0
  :coords ((0.74d0 0.27d0) (0.22d0 0.78d0) (0.09d0 -0.09d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space don-rgb-4 ()
  :model rgb
  :illuminant :d50
  :coords ((0.696d0 0.3d0) (0.215d0 0.765d0) (0.13d0 0.035d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space eci-rgb-v2 ()
  :model rgb
  :illuminant :d50
  :gamma L*
  :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space ekta-space-ps5 ()
  :model rgb
  :illuminant :d50
  :coords ((0.695d0 0.305d0) (0.26d0 0.7d0) (0.11d0 0.005d0)))

;; Reference: https://en.wikipedia.org/wiki/CIELAB_color_space
(define-color-space lab ())

;; Reference: https://en.wikipedia.org/wiki/CIELAB_color_space
(define-color-space lchab ())

;; Reference: https://en.wikipedia.org/wiki/CIELUV
(define-color-space lchuv ()
  :illuminant :e)

;; Reference: https://en.wikipedia.org/wiki/CIELUV
(define-color-space luv ()
  :illuminant :e)

;; Reference: https://www.color.org/ROMMRGB.pdf
(define-color-space prophoto-rgb ()
  :model rgb
  :illuminant :d50
  :gamma 1.8d0
  :coords ((0.7347d0 0.2653d0) (0.1596d0 0.8404d0) (0.0366d0 0.0001d0)))

;; Reference: http://www.brucelindbloom.com/index.html?Eqn_RGB_to_XYZ.html
(define-color-space simple-srgb ()
  :model rgb
  :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0)))

;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
(define-color-space smpte-c-rgb ()
  :model rgb
  :coords ((0.63d0 0.34d0) (0.31d0 0.595d0) (0.155d0 0.07d0)))

;; Reference: https://en.wikipedia.org/wiki/SRGB
(define-color-space srgb ()
  :model rgb
  :gamma srgb
  :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0)))

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-space xyy ()
  :illuminant :e)

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
(define-color-space xyz ()
  :illuminant :e)
