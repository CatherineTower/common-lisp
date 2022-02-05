(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image
  (:local-nicknames
   (#:gv #:global-vars)
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils)
   (#:v2 #:mfiano.math.origin.vec2)
   (#:v3 #:mfiano.math.origin.vec3)
   (#:v4 #:mfiano.math.origin.vec4)
   (#:m3 #:mfiano.math.origin.mat3))
  (:use #:cl)
  ;; context
  (:export
   #:context
   #:make-context)
  ;; chromatic adaptation methods
  (:export
   #:bradford
   #:ciecam02
   #:cat16
   #:ciecam97s-revised
   #:fairchild
   #:sharp
   #:von-kries
   #:xyz-scaling)
  ;; tonal response curves
  (:export
   #:L*
   #:rec.709
   #:srgb)
  ;; color spaces
  (:export
   #:adobe-rgb
   #:apple-rgb
   #:best-rgb
   #:beta-rgb
   #:bruce-rgb
   #:bt.2020
   #:bt.709
   #:cie-rgb
   #:colormatch-rgb
   #:don-rgb-4
   #:eci-rgb-v2
   #:ekta-space-ps5
   #:ntsc-rgb
   #:pal/secam-rgb
   #:prophoto-rgb
   #:smpte-c-rgb
   #:srgb
   #:wide-gamut-rgb
   #:xyz)
  ;; image
  (:export
   #:height
   #:image
   #:width))
