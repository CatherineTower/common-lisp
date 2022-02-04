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
  ;; standard illuminants
  (:export
   #:a
   #:b
   #:c
   #:d50
   #:d55
   #:d65
   #:d75
   #:d93
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
   #:led-b2
   #:led-b3
   #:led-b4
   #:led-b5
   #:led-bh1
   #:led-rgb1
   #:led-v1
   #:led-v2)
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
  ;; color spaces
  (:export
   #:adobe-rgb
   #:apple-rgb
   #:best-rgb
   #:beta-rgb
   #:bruce-rgb
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
