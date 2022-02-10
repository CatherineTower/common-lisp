(in-package #:mfiano.graphics.tools.image)

;; Reference: https://en.wikipedia.org/wiki/Standard_illuminant#White_points_of_standard_illuminants
;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
(define-builtin-illuminants ()
  (a :x 0.44757 :y 0.40745)
  (b :x 0.34842 :y 0.35161)
  (c :x 0.31006 :y 0.31616)
  (d50 :x 0.34567 :y 0.3585)
  (d55 :x 0.33242 :y 0.34743)
  (d65 :x 0.31271 :y 0.32902)
  (d75 :x 0.29902 :y 0.31485)
  (d93 :x 0.28315 :y 0.29711)
  (dci :x 0.314 :y 0.351)
  (e :x 1/3 :y 1/3)
  (f1 :x 0.3131 :y 0.33727)
  (f2 :x 0.37208 :y 0.37529)
  (f3 :x 0.4091 :y 0.3943)
  (f4 :x 0.44018 :y 0.40329)
  (f5 :x 0.31379 :y 0.34531)
  (f6 :x 0.3779 :y 0.38835)
  (f7 :x 0.31292 :y 0.32933)
  (f8 :x 0.34588 :y 0.35875)
  (f9 :x 0.37417 :y 0.37281)
  (f10 :x 0.34609 :y 0.35986)
  (f11 :x 0.38052 :y 0.37713)
  (f12 :x 0.43695 :y 0.40441)
  (led-b1 :x 0.456 :y 0.4078)
  (led-b2 :x 0.4357 :y 0.4012)
  (led-b3 :x 0.3756 :y 0.3723)
  (led-b4 :x 0.3422 :y 0.3502)
  (led-b5 :x 0.3118 :y 0.3236)
  (led-bh1 :x 0.4474 :y 0.4066)
  (led-rgb1 :x 0.4557 :y 0.4211)
  (led-v1 :x 0.456 :y 0.4548)
  (led-v2 :x 0.3781 :y 0.3775))

;; Reference: http://www.brucelindbloom.com/index.html?Eqn_ChromAdapt.html
;; Reference: https://en.wikipedia.org/wiki/CIECAM02#CAT02
;; Reference: https://observablehq.com/@jrus/cam16
;; Reference: http://markfairchild.org/PDFs/PRO17.pdf
;; Reference: https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.364.1672&rep=rep1&type=pdf
(define-builtin-chromatic-adaptation-methods ()
  (bradford
   (0.8951 -0.7502 0.0389 0.2664 1.7135 -0.0685 -0.1614 0.0367 1.0296))
  (cat02
   (0.7328 -0.7036 0.003 0.4296 1.6975 0.0136 -0.1624 0.0061 0.9834))
  (cat16
   (0.401288 -0.250268 -0.002079 0.650173 1.204414 0.048952 -0.051461 0.045854 0.953127))
  (fairchild
   (0.8562 -0.836 0.0357 0.3372 1.8327 -0.0469 -0.1934 0.0033 1.0112))
  (sharp
   (1.2694 -0.8364 0.0297 -0.0988 1.8006 -0.0315 -0.1706 0.0357 1.0018))
  (von-kries
   (0.40024 -0.2263 0 0.7076 1.16532 0 -0.08081 0.0457 0.91822))
  (xyz-scaling
   (1 0 0 0 1 0 0 0 1)))

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
  (adobe-rgb
   :model rgb
   :illuminant d65
   :coords ((0.64 0.33) (0.21 0.71) (0.15 0.06))
   :gamma 563/256)
  (adobe-wide-gamit-rgb
   :model rgb
   :illuminant D50
   :coords ((0.7347 0.2653) (0.1152 0.8264) (0.1566 0.0177))
   :gamma 563/256)
  (apple-rgb
   :model rgb
   :illuminant D65
   :coords ((0.625 0.34) (0.28 0.595) (0.155 0.07))
   :gamma 1.8)
  (best-rgb
   :model rgb
   :illuminant D50
   :coords ((0.7347 0.2653) (0.215 0.775) (0.13 0.035))
   :gamma 2.2)
  (beta-rgb
   :model rgb
   :illuminant D50
   :coords ((0.6888 0.3112) (0.1986 0.7551) (0.1265 0.0352))
   :gamma 2.2)
  (bruce-rgb
   :model rgb
   :illuminant D65
   :coords ((0.64 0.33) (0.28 0.65) (0.15 0.06))
   :gamma 2.2)
  (bt.2020
   :model rgb
   :illuminant D65
   :coords ((0.708 0.292) (0.17 0.797) (0.131 0.046))
   :gamma rec.709)
  (bt.470-ntsc
   :model rgb
   :illuminant C
   :coords ((0.67 0.33) (0.21 0.71) (0.14 0.08))
   :gamma 2.2)
  (bt-470-pal/secam
   :model rgb
   :illuminant D65
   :coords ((0.64 0.33) (0.29 0.6) (0.15 0.06))
   :gamma 2.8)
  (bt.709
   :model rgb
   :illuminant D65
   :coords ((0.64 0.33) (0.3 0.6) (0.15 0.06))
   :gamma rec.709)
  (cie-rgb
   :model rgb
   :illuminant E
   :coords ((0.7347 0.2653) (0.2738 0.7174) (0.1666 0.0089))
   :gamma 2.2)
  (colormatch-rgb
   :model rgb
   :illuminant D50
   :coords ((0.63 0.34) (0.295 0.605) (0.15 0.075))
   :gamma 1.8)
  (dci-p3
   :model rgb
   :illuminant DCI
   :coords ((0.68 0.32) (0.265 0.69) (0.15 0.06))
   :gamma 2.6)
  (dci-p3+
   :model rgb
   :illuminant DCI
   :coords ((0.74 0.27) (0.22 0.78) (0.09 -0.09))
   :gamma 2.6)
  (don-rgb-4
   :model rgb
   :illuminant D50
   :coords ((0.696 0.3) (0.215 0.765) (0.13 0.035))
   :gamma 2.2)
  (eci-rgb-v2
   :model rgb
   :illuminant D50
   :coords ((0.67 0.33) (0.21 0.71) (0.14 0.08))
   :gamma L*)
  (ekta-space-ps5
   :model rgb
   :illuminant D50
   :coords ((0.695 0.305) (0.26 0.7) (0.11 0.005))
   :gamma 2.2)
  (romm-rgb
   :model rgb
   :illuminant D50
   :coords ((0.7347 0.2653) (0.1596 0.8404) (0.0366 0.0001))
   :gamma 1.8)
  (simple-srgb
   :model rgb
   :illuminant D65
   :coords ((0.64 0.33) (0.3 0.6) (0.15 0.06))
   :gamma 2.2)
  (smpte-c-rgb
   :model rgb
   :illuminant D65
   :coords ((0.63 0.34) (0.31 0.595) (0.155 0.07))
   :gamma 2.2)
  (srgb
   :model rgb
   :illuminant D65
   :coords ((0.64 0.33) (0.3 0.6) (0.15 0.06))
   :gamma srgb))
