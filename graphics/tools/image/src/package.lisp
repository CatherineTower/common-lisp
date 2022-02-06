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
  ;; Context
  (:export
   #:context
   #:make-context)
  ;; Color constructors
  (:export
   #:rgb
   #:rgba
   #:xyz)
  ;; Color spaces
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
   #:dci-p3
   #:don-rgb-4
   #:eci-rgb-v2
   #:ekta-space-ps5
   #:ntsc-rgb
   #:pal/secam-rgb
   #:prophoto-rgb
   #:simple-srgb
   #:smpte-c-rgb
   #:srgb
   #:wide-gamut-rgb
   #:xyz)
  ;; Color operations
  (:export
   #:adapt-chromaticity
   #:convert)
  ;; Image
  (:export
   #:height
   #:image
   #:width))
