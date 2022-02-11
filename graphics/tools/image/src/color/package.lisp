(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image.color
  (:local-nicknames
   (#:b #:mfiano.graphics.tools.image.base)
   (#:u #:mfiano.misc.utils)
   (#:v2 #:mfiano.math.origin.dvec2)
   (#:v3 #:mfiano.math.origin.dvec3)
   (#:v4 #:mfiano.math.origin.dvec4)
   (#:m3 #:mfiano.math.origin.dmat3))
  (:use #:cl)
  ;; Context
  (:export
   #:register-chromatic-adaptation-method
   #:register-color-space
   #:register-illuminant)
  ;; Illuminants
  (:export
   #:a
   #:b
   #:c
   #:d50
   #:d55
   #:d65
   #:d75
   #:d93
   #:dci
   #:e
   #:f1
   #:f2
   #:f3
   #:f4
   #:f5
   #:f6
   #:f7
   #:f8
   #:f9
   #:f10
   #:f11
   #:f12
   #:led-b1
   #:led-b2
   #:led-b3
   #:led-b4
   #:led-b5
   #:led-bh1
   #:led-rgb1
   #:led-v1
   #:led-v2)
  ;; Chromatic adaptation methods
  (:export
   #:bradford
   #:ciecam02
   #:cat16
   #:fairchild
   #:sharp
   #:von-kries
   #:xyz-scaling)
  ;; Models
  (:export
   #:rgb
   #:xyz)
  ;; Constructors
  (:export
   #:abgr
   #:argb
   #:bgr
   #:bgra
   #:rgb
   #:rgba
   #:xyz)
  ;; Spaces
  (:export
   #:adobe-rgb
   #:adobe-wide-gamut-rgb
   #:apple-rgb
   #:best-rgb
   #:beta-rgb
   #:bruce-rgb
   #:bt.2020
   #:bt.470-ntsc
   #:bt.470-pal/secam
   #:bt.709
   #:cie-rgb
   #:colormatch-rgb
   #:dci-p3
   #:dci-p3+
   #:don-rgb-4
   #:eci-rgb-v2
   #:ekta-space-ps5
   #:romm-rgb
   #:simple-srgb
   #:smpte-c-rgb
   #:srgb
   #:xyz)
  ;; Operations
  (:export
   #:adapt-chromaticity))
