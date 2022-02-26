(in-package #:%mfiano.graphics.image.color)

(defun register-color-space (space-name model-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defmacro define-color-spaces (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key models &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v)))
              `(register-color-space ',space-name ',models ,@(u:plist-remove args :model)))))
        body)))

(define-color-spaces ()
  ;; Reference: http://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf
  (adobe-rgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.21d0 0.71d0) (0.15d0 0.06d0))
   :gamma #.(float 563/256 1d0))
  ;; Reference: https://en.wikipedia.org/wiki/Wide-gamut_RGB_color_space
  (adobe-wide-gamut-rgb
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.1152d0 0.8264d0) (0.1566d0 0.0177d0))
   :gamma #.(float 563/256 1d0))
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (apple-rgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.625d0 0.34d0) (0.28d0 0.595d0) (0.155d0 0.07d0))
   :gamma 1.8d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (best-rgb
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.215d0 0.775d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (beta-rgb
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.6888d0 0.3112d0) (0.1986d0 0.7551d0) (0.1265d0 0.0352d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (bruce-rgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.28d0 0.65d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  ;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.2020-1-201406-S!!PDF-E.pdf
  (bt2020
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.708d0 0.292d0) (0.17d0 0.797d0) (0.131d0 0.046d0))
   :gamma rec.709)
  ;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.470-6-199811-S!!PDF-E.pdf
  (bt470-ntsc
   :models (hsl rgb rgba)
   :illuminant :c
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma 2.2d0)
  ;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.470-6-199811-S!!PDF-E.pdf
  (bt470-pal/secam
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.29d0 0.6d0) (0.15d0 0.06d0))
   :gamma 2.8d0)
  ;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.709-5-200204-S!!PDF-E.pdf
  (bt709
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma rec.709)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (cie-rgb
   :models (hsl rgb rgba)
   :illuminant :e
   :coords ((0.7347d0 0.2653d0) (0.2738d0 0.7174d0) (0.1666d0 0.0089d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (colormatch-rgb
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.63d0 0.34d0) (0.295d0 0.605d0) (0.15d0 0.075d0))
   :gamma 1.8d0)
  ;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
  (dci-p3
   :models (hsl rgb rgba)
   :illuminant :dci
   :coords ((0.68d0 0.32d0) (0.265d0 0.69d0) (0.15d0 0.06d0))
   :gamma 2.6d0)
  ;; Reference: https://en.wikipedia.org/wiki/DCI-P3#DCI-P3+_and_Cinema_Gamut
  (dci-p3+
   :models (hsl rgb rgba)
   :illuminant :dci
   :coords ((0.74d0 0.27d0) (0.22d0 0.78d0) (0.09d0 -0.09d0))
   :gamma 2.6d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (don-rgb-4
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.696d0 0.3d0) (0.215d0 0.765d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (eci-rgb-v2
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma L*)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (ekta-space-ps5
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.695d0 0.305d0) (0.26d0 0.7d0) (0.11d0 0.005d0))
   :gamma 2.2d0)
  ;; Reference: https://en.wikipedia.org/wiki/CIELAB_color_space
  (lab
   :models (lab)
   :illuminant :d65)
  ;; Reference: https://en.wikipedia.org/wiki/CIELAB_color_space
  (lchab
   :models (lchab)
   :illuminant :d65)
  ;; Reference: https://en.wikipedia.org/wiki/CIELUV
  (lchuv
   :models (lchuv)
   :illuminant :e)
  ;; Reference: https://en.wikipedia.org/wiki/CIELUV
  (luv
   :models (luv)
   :illuminant :e)
  ;; Reference: https://www.color.org/ROMMRGB.pdf
  (prophoto-rgb
   :models (hsl rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.1596d0 0.8404d0) (0.0366d0 0.0001d0))
   :gamma 1.8d0)
  ;; Reference: http://www.brucelindbloom.com/index.html?Eqn_RGB_to_XYZ.html
  (simple-srgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (smpte-c-rgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.63d0 0.34d0) (0.31d0 0.595d0) (0.155d0 0.07d0))
   :gamma 2.2d0)
  ;; Reference: https://en.wikipedia.org/wiki/SRGB
  (srgb
   :models (hsl rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma srgb)
  ;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
  (xyy
   :models (xyy)
   :illuminant :e)
  ;; Reference: https://en.wikipedia.org/wiki/CIE_1931_color_space
  (xyz
   :models (xyz)
   :illuminant :e))
