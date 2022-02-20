(in-package #:mfiano.graphics.image.test)

(plan nil)

;; TODO: Why are most of the RGB results clamped to zero in the red channel?
;; Lindbloom's calculator returns negative values. We need these negatives so we can detect out of
;; gamut conditions.
#++(subtest "From XYZ (one way)"
     (let* ((*read-default-float-format* 'double-float)
            (xyz (i:xyz 0.1 0.5 0.9)))
       (test xyz (color 'i:xyy) '(0.066667 0.333333 0.5))
       (test xyz (color 'i:cielab) '(76.0693 -164.7708 -34.3578))
       (test xyz (color 'i:lch-ab) '(76.0693 168.3148 191.7785))
       (test xyz (color 'i:lch-uv) '(76.0693 173.6400 192.0948))
       (test xyz (color 'i:luv) '(76.0693 -169.7857 -36.3826))
       (test xyz (color 'i:rgb 'i:adobe-rgb) '(0 0.942808 0.931774))
       (test xyz (color 'i:rgb 'i:adobe-wide-gamut-rgb) '(0 0.867999 1.050559))
       (test xyz (color 'i:rgb 'i:apple-rgb) '(0 0.954964 0.917227))
       (test xyz (color 'i:rgb 'i:best-rgb) '(0 0.860436 1.042103))
       (test xyz (color 'i:rgb 'i:beta-rgb) '(0 0.911917 1.046369))
       (test xyz (color 'i:rgb 'i:bruce-rgb) '(0 0.942808 0.931798))

       ;; FIXME: Lindbloom's calculator doesn't support this RGB space.
       ;; (test xyz (color 'i:rgb 'i:bt.2020) expected)

       (test xyz (color 'i:rgb 'i:bt.470-ntsc) '(0 0.941423 0.879781))

       ;; FIXME: Lindbloom's calculator uses gamma of 2.2, but spec uses 2.8.
       ;; (test xyz (color 'i:rgb 'i:bt.470-pal/secam) '(0 0.942808 0.931158))

       ;; FIXME: Lindbloom's calculator doesn't support this RGB space.
       ;; (test xyz (color 'i:rgb 'i:bt.709) expected)

       (test xyz (color 'i:rgb 'i:cie-rgb) '(0 0.872615 0.954026))
       (test xyz (color 'i:rgb 'i:colormatch-rgb) '(0 0.962020 1.095406))

       ;; FIXME: Lindbloom's calculator doesn't support this RGB space.
       ;; (test xyz (color 'i:rgb 'i:dci-p3) expected)

       ;; FIXME: Lindbloom's calculator doesn't support this RGB space.
       ;; (test xyz (color 'i:rgb 'i:dci-p3+) expected)

       (test xyz (color 'i:rgb 'i:don-rgb-4) '(0 0.899744 1.045874))
       (test xyz (color 'i:rgb 'i:eci-rgb-v2) '(0 0.940182 1.041749))
       (test xyz (color 'i:rgb 'i:ekta-space-ps5) '(0 0.908817 1.046715))
       (test xyz (color 'i:rgb 'i:romm-rgb) '(0 0.831964 1.049379))
       (test xyz (color 'i:rgb 'i:simple-srgb) '(0 0.942808 0.931297))
       (test xyz (color 'i:rgb 'i:smpte-c-rgb) '(0 0.959787 0.929933))
       (test xyz (color 'i:rgb 'i:srgb) '(0 0.944556 0.933363))))

(subtest "From XYZ (one way)"
  (test-one-way i:xyz i:xyy)
  (test-one-way i:xyz i:cielab)
  (test-one-way i:xyz i:lch-ab)
  (test-one-way i:xyz i:lch-uv)
  (test-one-way i:xyz i:luv))

(subtest "From XYZ (round trip)"
  (test-round-trip i:xyz i:xyy)
  (test-round-trip i:xyz i:cielab)
  (test-round-trip i:xyz i:lch-ab)
  (test-round-trip i:xyz i:lch-uv)
  (test-round-trip i:xyz i:luv)
  (test-round-trip i:xyz (i:rgb i:adobe-rgb))
  (test-round-trip i:xyz (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:xyz (i:rgb i:apple-rgb))
  (test-round-trip i:xyz (i:rgb i:best-rgb))
  (test-round-trip i:xyz (i:rgb i:beta-rgb))
  (test-round-trip i:xyz (i:rgb i:bruce-rgb))
  (test-round-trip i:xyz (i:rgb i:bt.2020))
  (test-round-trip i:xyz (i:rgb i:bt.470-ntsc))
  (test-round-trip i:xyz (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:xyz (i:rgb i:bt.709))
  (test-round-trip i:xyz (i:rgb i:cie-rgb))
  (test-round-trip i:xyz (i:rgb i:colormatch-rgb))
  (test-round-trip i:xyz (i:rgb i:dci-p3))
  (test-round-trip i:xyz (i:rgb i:dci-p3+))
  (test-round-trip i:xyz (i:rgb i:don-rgb-4))
  (test-round-trip i:xyz (i:rgb i:eci-rgb-v2))
  (test-round-trip i:xyz (i:rgb i:ekta-space-ps5))
  (test-round-trip i:xyz (i:rgb i:romm-rgb))
  (test-round-trip i:xyz (i:rgb i:simple-srgb))
  (test-round-trip i:xyz (i:rgb i:smpte-c-rgb))
  (test-round-trip i:xyz (i:rgb i:srgb)))

(subtest "From xyY (round trip)"
  (test-round-trip i:xyy i:xyz)
  (test-round-trip i:xyy i:cielab)
  (test-round-trip i:xyy i:lch-ab)
  (test-round-trip i:xyy i:lch-uv)
  (test-round-trip i:xyy i:luv)
  (test-round-trip i:xyy (i:rgb i:adobe-rgb))
  (test-round-trip i:xyy (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:xyy (i:rgb i:apple-rgb))
  (test-round-trip i:xyy (i:rgb i:best-rgb))
  (test-round-trip i:xyy (i:rgb i:beta-rgb))
  (test-round-trip i:xyy (i:rgb i:bruce-rgb))
  (test-round-trip i:xyy (i:rgb i:bt.2020))
  (test-round-trip i:xyy (i:rgb i:bt.470-ntsc))
  (test-round-trip i:xyy (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:xyy (i:rgb i:bt.709))
  (test-round-trip i:xyy (i:rgb i:cie-rgb))
  (test-round-trip i:xyy (i:rgb i:colormatch-rgb))
  (test-round-trip i:xyy (i:rgb i:dci-p3))
  (test-round-trip i:xyy (i:rgb i:dci-p3+))
  (test-round-trip i:xyy (i:rgb i:don-rgb-4))
  (test-round-trip i:xyy (i:rgb i:eci-rgb-v2))
  (test-round-trip i:xyy (i:rgb i:ekta-space-ps5))
  (test-round-trip i:xyy (i:rgb i:romm-rgb))
  (test-round-trip i:xyy (i:rgb i:simple-srgb))
  (test-round-trip i:xyy (i:rgb i:smpte-c-rgb))
  (test-round-trip i:xyy (i:rgb i:smpte-c-rgb))
  (test-round-trip i:xyy (i:rgb i:srgb)))

(subtest "From CIELAB (round trip)"
  (test-round-trip i:cielab i:xyz)
  (test-round-trip i:cielab i:xyy)
  (test-round-trip i:cielab i:lch-ab)
  (test-round-trip i:cielab i:lch-uv)
  (test-round-trip i:cielab i:luv)
  (test-round-trip i:cielab (i:rgb i:adobe-rgb))
  (test-round-trip i:cielab (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:cielab (i:rgb i:apple-rgb))
  (test-round-trip i:cielab (i:rgb i:best-rgb))
  (test-round-trip i:cielab (i:rgb i:beta-rgb))
  (test-round-trip i:cielab (i:rgb i:bruce-rgb))
  (test-round-trip i:cielab (i:rgb i:bt.2020))
  (test-round-trip i:cielab (i:rgb i:bt.470-ntsc))
  (test-round-trip i:cielab (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:cielab (i:rgb i:bt.709))
  (test-round-trip i:cielab (i:rgb i:cie-rgb))
  (test-round-trip i:cielab (i:rgb i:colormatch-rgb))
  (test-round-trip i:cielab (i:rgb i:dci-p3))
  (test-round-trip i:cielab (i:rgb i:dci-p3+))
  (test-round-trip i:cielab (i:rgb i:don-rgb-4))
  (test-round-trip i:cielab (i:rgb i:eci-rgb-v2))
  (test-round-trip i:cielab (i:rgb i:ekta-space-ps5))
  (test-round-trip i:cielab (i:rgb i:romm-rgb))
  (test-round-trip i:cielab (i:rgb i:simple-srgb))
  (test-round-trip i:cielab (i:rgb i:smpte-c-rgb))
  (test-round-trip i:cielab (i:rgb i:smpte-c-rgb))
  (test-round-trip i:cielab (i:rgb i:srgb)))

(subtest "From LCHab (round trip)"
  (test-round-trip i:lch-ab i:xyz)
  (test-round-trip i:lch-ab i:xyy)
  (test-round-trip i:lch-ab i:cielab)
  (test-round-trip i:lch-ab i:lch-uv)
  (test-round-trip i:lch-ab i:luv)
  (test-round-trip i:lch-ab (i:rgb i:adobe-rgb))
  (test-round-trip i:lch-ab (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:lch-ab (i:rgb i:apple-rgb))
  (test-round-trip i:lch-ab (i:rgb i:best-rgb))
  (test-round-trip i:lch-ab (i:rgb i:beta-rgb))
  (test-round-trip i:lch-ab (i:rgb i:bruce-rgb))
  (test-round-trip i:lch-ab (i:rgb i:bt.2020))
  (test-round-trip i:lch-ab (i:rgb i:bt.470-ntsc))
  (test-round-trip i:lch-ab (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:lch-ab (i:rgb i:bt.709))
  (test-round-trip i:lch-ab (i:rgb i:cie-rgb))
  (test-round-trip i:lch-ab (i:rgb i:colormatch-rgb))
  (test-round-trip i:lch-ab (i:rgb i:dci-p3))
  (test-round-trip i:lch-ab (i:rgb i:dci-p3+))
  (test-round-trip i:lch-ab (i:rgb i:don-rgb-4))
  (test-round-trip i:lch-ab (i:rgb i:eci-rgb-v2))
  (test-round-trip i:lch-ab (i:rgb i:ekta-space-ps5))
  (test-round-trip i:lch-ab (i:rgb i:romm-rgb))
  (test-round-trip i:lch-ab (i:rgb i:simple-srgb))
  (test-round-trip i:lch-ab (i:rgb i:smpte-c-rgb))
  (test-round-trip i:lch-ab (i:rgb i:smpte-c-rgb))
  (test-round-trip i:lch-ab (i:rgb i:srgb)))

(subtest "From LCHuv (round trip)"
  (test-round-trip i:lch-uv i:xyz)
  (test-round-trip i:lch-uv i:xyy)
  (test-round-trip i:lch-uv i:cielab)
  (test-round-trip i:lch-uv i:lch-ab)
  (test-round-trip i:lch-uv i:luv)
  (test-round-trip i:lch-uv (i:rgb i:adobe-rgb))
  (test-round-trip i:lch-uv (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:lch-uv (i:rgb i:apple-rgb))
  (test-round-trip i:lch-uv (i:rgb i:best-rgb))
  (test-round-trip i:lch-uv (i:rgb i:beta-rgb))
  (test-round-trip i:lch-uv (i:rgb i:bruce-rgb))
  (test-round-trip i:lch-uv (i:rgb i:bt.2020))
  (test-round-trip i:lch-uv (i:rgb i:bt.470-ntsc))
  (test-round-trip i:lch-uv (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:lch-uv (i:rgb i:bt.709))
  (test-round-trip i:lch-uv (i:rgb i:cie-rgb))
  (test-round-trip i:lch-uv (i:rgb i:colormatch-rgb))
  (test-round-trip i:lch-uv (i:rgb i:dci-p3))
  (test-round-trip i:lch-uv (i:rgb i:dci-p3+))
  (test-round-trip i:lch-uv (i:rgb i:don-rgb-4))
  (test-round-trip i:lch-uv (i:rgb i:eci-rgb-v2))
  (test-round-trip i:lch-uv (i:rgb i:ekta-space-ps5))
  (test-round-trip i:lch-uv (i:rgb i:romm-rgb))
  (test-round-trip i:lch-uv (i:rgb i:simple-srgb))
  (test-round-trip i:lch-uv (i:rgb i:smpte-c-rgb))
  (test-round-trip i:lch-uv (i:rgb i:smpte-c-rgb))
  (test-round-trip i:lch-uv (i:rgb i:srgb)))

(subtest "From Luv (round trip)"
  (test-round-trip i:luv i:xyz)
  (test-round-trip i:luv i:xyy)
  (test-round-trip i:luv i:cielab)
  (test-round-trip i:luv i:lch-ab)
  (test-round-trip i:luv i:lch-uv)
  (test-round-trip i:luv (i:rgb i:adobe-rgb))
  (test-round-trip i:luv (i:rgb i:adobe-wide-gamut-rgb))
  (test-round-trip i:luv (i:rgb i:apple-rgb))
  (test-round-trip i:luv (i:rgb i:best-rgb))
  (test-round-trip i:luv (i:rgb i:beta-rgb))
  (test-round-trip i:luv (i:rgb i:bruce-rgb))
  (test-round-trip i:luv (i:rgb i:bt.2020))
  (test-round-trip i:luv (i:rgb i:bt.470-ntsc))
  (test-round-trip i:luv (i:rgb i:bt.470-pal/secam))
  (test-round-trip i:luv (i:rgb i:bt.709))
  (test-round-trip i:luv (i:rgb i:cie-rgb))
  (test-round-trip i:luv (i:rgb i:colormatch-rgb))
  (test-round-trip i:luv (i:rgb i:dci-p3))
  (test-round-trip i:luv (i:rgb i:dci-p3+))
  (test-round-trip i:luv (i:rgb i:don-rgb-4))
  (test-round-trip i:luv (i:rgb i:eci-rgb-v2))
  (test-round-trip i:luv (i:rgb i:ekta-space-ps5))
  (test-round-trip i:luv (i:rgb i:romm-rgb))
  (test-round-trip i:luv (i:rgb i:simple-srgb))
  (test-round-trip i:luv (i:rgb i:smpte-c-rgb))
  (test-round-trip i:luv (i:rgb i:smpte-c-rgb))
  (test-round-trip i:luv (i:rgb i:srgb)))

(finalize)
