(in-package #:%mfiano.graphics.tools.image.color)

(declaim (inline get-color-space-spec))
(defun get-color-space-spec (space-name)
  (u:href (base:color-spaces base:*context*) space-name))

(defun register-color-space (model-name space-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defmacro define-builtin-color-spaces (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v))
                  (model-name (or model space-name)))
              `(register-color-space ',model-name ',space-name ,@(u:plist-remove args :model)))))
        body)))

;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
;; Reference: http://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf
;; Reference: https://en.wikipedia.org/wiki/Wide-gamut_RGB_color_space
;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.2020-1-201406-S!!PDF-E.pdf
;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.470-6-199811-S!!PDF-E.pdf
;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.709-5-200204-S!!PDF-E.pdf
;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
;; Reference: https://en.wikipedia.org/wiki/DCI-P3#DCI-P3+_and_Cinema_Gamut
;; Reference: https://www.color.org/ROMMRGB.pdf
;; Reference: https://en.wikipedia.org/wiki/SRGB
(define-builtin-color-spaces ()
  (xyz
   :illuminant e)
  (luv
   :illuminant e)
  (adobe-rgb
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.21d0 0.71d0) (0.15d0 0.06d0))
   :gamma #.(float 563/256 1d0))
  (adobe-wide-gamut-rgb
   :model rgb
   :illuminant d50
   :coords ((0.7347d0 0.2653d0) (0.1152d0 0.8264d0) (0.1566d0 0.0177d0))
   :gamma #.(float 563/256 1d0))
  (apple-rgb
   :model rgb
   :illuminant d65
   :coords ((0.625d0 0.34d0) (0.28d0 0.595d0) (0.155d0 0.07d0))
   :gamma 1.8d0)
  (best-rgb
   :model rgb
   :illuminant d50
   :coords ((0.7347d0 0.2653d0) (0.215d0 0.775d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  (beta-rgb
   :model rgb
   :illuminant d50
   :coords ((0.6888d0 0.3112d0) (0.1986d0 0.7551d0) (0.1265d0 0.0352d0))
   :gamma 2.2d0)
  (bruce-rgb
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.28d0 0.65d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  (bt.2020
   :model rgb
   :illuminant d65
   :coords ((0.708d0 0.292d0) (0.17d0 0.797d0) (0.131d0 0.046d0))
   :gamma rec.709)
  (bt.470-ntsc
   :model rgb
   :illuminant c
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma 2.2d0)
  (bt.470-pal/secam
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.29d0 0.6d0) (0.15d0 0.06d0))
   :gamma 2.8d0)
  (bt.709
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma rec.709)
  (cie-rgb
   :model rgb
   :illuminant e
   :coords ((0.7347d0 0.2653d0) (0.2738d0 0.7174d0) (0.1666d0 0.0089d0))
   :gamma 2.2d0)
  (colormatch-rgb
   :model rgb
   :illuminant d50
   :coords ((0.63d0 0.34d0) (0.295d0 0.605d0) (0.15d0 0.075d0))
   :gamma 1.8d0)
  (dci-p3
   :model rgb
   :illuminant dci
   :coords ((0.68d0 0.32d0) (0.265d0 0.69d0) (0.15d0 0.06d0))
   :gamma 2.6d0)
  (dci-p3+
   :model rgb
   :illuminant dci
   :coords ((0.74d0 0.27d0) (0.22d0 0.78d0) (0.09d0 -0.09d0))
   :gamma 2.6d0)
  (don-rgb-4
   :model rgb
   :illuminant d50
   :coords ((0.696d0 0.3d0) (0.215d0 0.765d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  (eci-rgb-v2
   :model rgb
   :illuminant d50
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma L*)
  (ekta-space-ps5
   :model rgb
   :illuminant d50
   :coords ((0.695d0 0.305d0) (0.26d0 0.7d0) (0.11d0 0.005d0))
   :gamma 2.2d0)
  (romm-rgb
   :model rgb
   :illuminant d50
   :coords ((0.7347d0 0.2653d0) (0.1596d0 0.8404d0) (0.0366d0 0.0001d0))
   :gamma 1.8d0)
  (simple-srgb
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  (smpte-c-rgb
   :model rgb
   :illuminant d65
   :coords ((0.63d0 0.34d0) (0.31d0 0.595d0) (0.155d0 0.07d0))
   :gamma 2.2d0)
  (srgb
   :model rgb
   :illuminant d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma srgb))
