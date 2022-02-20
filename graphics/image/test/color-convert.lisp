(in-package #:mfiano.graphics.image.test)

(plan nil)

(subtest "From XYZ (one way)"

  ;; Select illuminant E on Lindbloom.
  ;; The conversion pipeline is: XYZ -> xyY.
  ;; The second element is xyY, which is defined to use E.
  (test-one-way (i:xyz 0.1 0.5 0.9) i:xyy (0.066667 0.333333 0.5))

  ;; Select illuminant D65 on Lindbloom.
  ;; The conversion pipeline is: XYZ -> CIELAB.
  ;; The second element is CIELAB, which is defined to use D65.
  (test-one-way (i:xyz 0.1 0.5 0.9) i:cielab (76.0693 -160.8076 -28.957))

  ;; Select illuminant D65 on Lindbloom.
  ;; The conversion pipeline is: XYZ -> CIELAB -> LCHab.
  ;; The second element is CIELAB, which is defined to use D65.
  (test-one-way (i:xyz 0.1 0.5 0.9) i:lch-ab (76.0693 163.394 190.208))

  ;; Select illuminant E on Lindbloom.
  ;; The conversion pipeline is: XYZ -> Luv -> LCHuv.
  ;; The second element is Luv, which is defined to use E.
  (test-one-way (i:xyz 0.1 0.5 0.9) i:lch-uv (76.0693 173.64 192.0948))

  ;; Select illuminant E on Lindbloom.
  ;; The conversion pipeline is: XYZ -> Luv.
  ;; The second element is Luv, which is defined to use E.
  (test-one-way (i:xyz 0.1 0.5 0.9) i:luv (76.0693 -169.7857 -36.3826)))

(subtest "From xyY (one way)"

  ;; Select illuminant E on Lindbloom.
  ;; The conversion pipeline is: xyY -> XYZ.
  ;; The second element is XYZ, which is defined to use E.
  (test-one-way (i:xyy 0.1 0.5 0.9) i:xyz (0.18 0.9 0.72))

  ;; Un-analyzed.
  (test-one-way (i:xyy 0.1 0.5 0.9) i:cielab (95.9968 -195.6128 18.8554))

  ;; Un-analyzed.
  (test-one-way (i:xyy 0.1 0.5 0.9) i:lch-ab (95.9968 196.5195 174.4942))

  ;; Un-analyzed.
  (test-one-way (i:xyy 0.1 0.5 0.9) i:lch-uv (95.9968 211.3012 167.1419))

  ;; Un-analyzed.
  (test-one-way (i:xyy 0.1 0.5 0.9) i:luv (95.9968 -206.0026 47.0223)))

;; (subtest "From XYZ (round trip)"
;;   (test-round-trip i:xyz i:xyy)
;;   (test-round-trip i:xyz i:cielab)
;;   (test-round-trip i:xyz i:lch-ab)
;;   (test-round-trip i:xyz i:lch-uv)
;;   (test-round-trip i:xyz i:luv)
;;   (test-round-trip i:xyz (i:rgb i:adobe-rgb))
;;   (test-round-trip i:xyz (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:xyz (i:rgb i:apple-rgb))
;;   (test-round-trip i:xyz (i:rgb i:best-rgb))
;;   (test-round-trip i:xyz (i:rgb i:beta-rgb))
;;   (test-round-trip i:xyz (i:rgb i:bruce-rgb))
;;   (test-round-trip i:xyz (i:rgb i:bt.2020))
;;   (test-round-trip i:xyz (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:xyz (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:xyz (i:rgb i:bt.709))
;;   (test-round-trip i:xyz (i:rgb i:cie-rgb))
;;   (test-round-trip i:xyz (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:xyz (i:rgb i:dci-p3))
;;   (test-round-trip i:xyz (i:rgb i:dci-p3+))
;;   (test-round-trip i:xyz (i:rgb i:don-rgb-4))
;;   (test-round-trip i:xyz (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:xyz (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:xyz (i:rgb i:romm-rgb))
;;   (test-round-trip i:xyz (i:rgb i:simple-srgb))
;;   (test-round-trip i:xyz (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:xyz (i:rgb i:srgb)))

;; (subtest "From xyY (round trip)"
;;   (test-round-trip i:xyy i:xyz)
;;   (test-round-trip i:xyy i:cielab)
;;   (test-round-trip i:xyy i:lch-ab)
;;   (test-round-trip i:xyy i:lch-uv)
;;   (test-round-trip i:xyy i:luv)
;;   (test-round-trip i:xyy (i:rgb i:adobe-rgb))
;;   (test-round-trip i:xyy (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:xyy (i:rgb i:apple-rgb))
;;   (test-round-trip i:xyy (i:rgb i:best-rgb))
;;   (test-round-trip i:xyy (i:rgb i:beta-rgb))
;;   (test-round-trip i:xyy (i:rgb i:bruce-rgb))
;;   (test-round-trip i:xyy (i:rgb i:bt.2020))
;;   (test-round-trip i:xyy (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:xyy (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:xyy (i:rgb i:bt.709))
;;   (test-round-trip i:xyy (i:rgb i:cie-rgb))
;;   (test-round-trip i:xyy (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:xyy (i:rgb i:dci-p3))
;;   (test-round-trip i:xyy (i:rgb i:dci-p3+))
;;   (test-round-trip i:xyy (i:rgb i:don-rgb-4))
;;   (test-round-trip i:xyy (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:xyy (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:xyy (i:rgb i:romm-rgb))
;;   (test-round-trip i:xyy (i:rgb i:simple-srgb))
;;   (test-round-trip i:xyy (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:xyy (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:xyy (i:rgb i:srgb)))

;; (subtest "From CIELAB (round trip)"
;;   (test-round-trip i:cielab i:xyz)
;;   (test-round-trip i:cielab i:xyy)
;;   (test-round-trip i:cielab i:lch-ab)
;;   (test-round-trip i:cielab i:lch-uv)
;;   (test-round-trip i:cielab i:luv)
;;   (test-round-trip i:cielab (i:rgb i:adobe-rgb))
;;   (test-round-trip i:cielab (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:cielab (i:rgb i:apple-rgb))
;;   (test-round-trip i:cielab (i:rgb i:best-rgb))
;;   (test-round-trip i:cielab (i:rgb i:beta-rgb))
;;   (test-round-trip i:cielab (i:rgb i:bruce-rgb))
;;   (test-round-trip i:cielab (i:rgb i:bt.2020))
;;   (test-round-trip i:cielab (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:cielab (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:cielab (i:rgb i:bt.709))
;;   (test-round-trip i:cielab (i:rgb i:cie-rgb))
;;   (test-round-trip i:cielab (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:cielab (i:rgb i:dci-p3))
;;   (test-round-trip i:cielab (i:rgb i:dci-p3+))
;;   (test-round-trip i:cielab (i:rgb i:don-rgb-4))
;;   (test-round-trip i:cielab (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:cielab (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:cielab (i:rgb i:romm-rgb))
;;   (test-round-trip i:cielab (i:rgb i:simple-srgb))
;;   (test-round-trip i:cielab (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:cielab (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:cielab (i:rgb i:srgb)))

;; (subtest "From LCHab (round trip)"
;;   (test-round-trip i:lch-ab i:xyz)
;;   (test-round-trip i:lch-ab i:xyy)
;;   (test-round-trip i:lch-ab i:cielab)
;;   (test-round-trip i:lch-ab i:lch-uv)
;;   (test-round-trip i:lch-ab i:luv)
;;   (test-round-trip i:lch-ab (i:rgb i:adobe-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:apple-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:best-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:beta-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:bruce-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:bt.2020))
;;   (test-round-trip i:lch-ab (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:lch-ab (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:lch-ab (i:rgb i:bt.709))
;;   (test-round-trip i:lch-ab (i:rgb i:cie-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:dci-p3))
;;   (test-round-trip i:lch-ab (i:rgb i:dci-p3+))
;;   (test-round-trip i:lch-ab (i:rgb i:don-rgb-4))
;;   (test-round-trip i:lch-ab (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:lch-ab (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:lch-ab (i:rgb i:romm-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:simple-srgb))
;;   (test-round-trip i:lch-ab (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:lch-ab (i:rgb i:srgb)))

;; (subtest "From LCHuv (round trip)"
;;   (test-round-trip i:lch-uv i:xyz)
;;   (test-round-trip i:lch-uv i:xyy)
;;   (test-round-trip i:lch-uv i:cielab)
;;   (test-round-trip i:lch-uv i:lch-ab)
;;   (test-round-trip i:lch-uv i:luv)
;;   (test-round-trip i:lch-uv (i:rgb i:adobe-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:apple-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:best-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:beta-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:bruce-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:bt.2020))
;;   (test-round-trip i:lch-uv (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:lch-uv (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:lch-uv (i:rgb i:bt.709))
;;   (test-round-trip i:lch-uv (i:rgb i:cie-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:dci-p3))
;;   (test-round-trip i:lch-uv (i:rgb i:dci-p3+))
;;   (test-round-trip i:lch-uv (i:rgb i:don-rgb-4))
;;   (test-round-trip i:lch-uv (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:lch-uv (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:lch-uv (i:rgb i:romm-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:simple-srgb))
;;   (test-round-trip i:lch-uv (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:lch-uv (i:rgb i:srgb)))

;; (subtest "From Luv (round trip)"
;;   (test-round-trip i:luv i:xyz)
;;   (test-round-trip i:luv i:xyy)
;;   (test-round-trip i:luv i:cielab)
;;   (test-round-trip i:luv i:lch-ab)
;;   (test-round-trip i:luv i:lch-uv)
;;   (test-round-trip i:luv (i:rgb i:adobe-rgb))
;;   (test-round-trip i:luv (i:rgb i:adobe-wide-gamut-rgb))
;;   (test-round-trip i:luv (i:rgb i:apple-rgb))
;;   (test-round-trip i:luv (i:rgb i:best-rgb))
;;   (test-round-trip i:luv (i:rgb i:beta-rgb))
;;   (test-round-trip i:luv (i:rgb i:bruce-rgb))
;;   (test-round-trip i:luv (i:rgb i:bt.2020))
;;   (test-round-trip i:luv (i:rgb i:bt.470-ntsc))
;;   (test-round-trip i:luv (i:rgb i:bt.470-pal/secam))
;;   (test-round-trip i:luv (i:rgb i:bt.709))
;;   (test-round-trip i:luv (i:rgb i:cie-rgb))
;;   (test-round-trip i:luv (i:rgb i:colormatch-rgb))
;;   (test-round-trip i:luv (i:rgb i:dci-p3))
;;   (test-round-trip i:luv (i:rgb i:dci-p3+))
;;   (test-round-trip i:luv (i:rgb i:don-rgb-4))
;;   (test-round-trip i:luv (i:rgb i:eci-rgb-v2))
;;   (test-round-trip i:luv (i:rgb i:ekta-space-ps5))
;;   (test-round-trip i:luv (i:rgb i:romm-rgb))
;;   (test-round-trip i:luv (i:rgb i:simple-srgb))
;;   (test-round-trip i:luv (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:luv (i:rgb i:smpte-c-rgb))
;;   (test-round-trip i:luv (i:rgb i:srgb)))

(finalize)
