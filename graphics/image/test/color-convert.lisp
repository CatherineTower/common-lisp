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

(subtest "From XYZ (round trip)"
  (with-round-trips i:xyz i:xyy)
  (with-round-trips i:xyz i:cielab)
  (with-round-trips i:xyz i:lch-ab)
  (with-round-trips i:xyz i:lch-uv)
  (with-round-trips i:xyz i:luv)
  (with-round-trips i:xyz (i:rgb i:srgb))
  (with-round-trips i:xyz (i:rgb i:adobe-rgb))
  #++(let* ((xyz (i:xyz 0.1 0.5 0.9))
            (expected (v3:copy (c::channels xyz))))
       (test/round-trip xyz (color 'i:xyy) expected)
       (test/round-trip xyz (color 'i:cielab) expected)
       (test/round-trip xyz (color 'i:lch-ab) expected)
       (test/round-trip xyz (color 'i:lch-uv) expected)
       (test/round-trip xyz (color 'i:luv) expected)
       ;; Interesting: The ones that fail are all the ones that do not have an illuminant of D65 and do
       ;; have a symbol gamma function.
       (test/round-trip xyz (color 'i:rgb 'i:adobe-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:adobe-wide-gamut-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:apple-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:best-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:beta-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:bruce-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:bt.2020) expected)
       (test/round-trip xyz (color 'i:rgb 'i:bt.470-ntsc) expected)
       (test/round-trip xyz (color 'i:rgb 'i:bt.470-pal/secam) expected)
       (test/round-trip xyz (color 'i:rgb 'i:bt.709) expected)
       (test/round-trip xyz (color 'i:rgb 'i:cie-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:colormatch-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:dci-p3) expected)
       (test/round-trip xyz (color 'i:rgb 'i:dci-p3+) expected)
       (test/round-trip xyz (color 'i:rgb 'i:don-rgb-4) expected)
       (test/round-trip xyz (color 'i:rgb 'i:eci-rgb-v2) expected)
       (test/round-trip xyz (color 'i:rgb 'i:ekta-space-ps5) expected)
       (test/round-trip xyz (color 'i:rgb 'i:romm-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:simple-srgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:smpte-c-rgb) expected)
       (test/round-trip xyz (color 'i:rgb 'i:srgb) expected)))

(finalize)
