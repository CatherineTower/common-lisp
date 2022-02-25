(in-package #:cl-user)

(defpackage #:%mfiano.graphics.image.color
  (:local-nicknames
   (#:base #:%mfiano.graphics.image.base)
   (#:m3 #:mfiano.math.origin.dmat3)
   (#:u #:mfiano.misc.utils)
   (#:v2 #:mfiano.math.origin.dvec2)
   (#:v3 #:mfiano.math.origin.dvec3)
   (#:v4 #:mfiano.math.origin.dvec4))
  (:use #:cl)
  ;; Models
  (:export
   #:lab
   #:lchab
   #:lchuv
   #:luv
   #:rgb
   #:rgba
   #:xyy
   #:xyz)
  ;; RGB Spaces
  (:export
   #:adobe-rgb
   #:adobe-wide-gamut-rgb
   #:apple-rgb
   #:best-rgb
   #:beta-rgb
   #:bruce-rgb
   #:bt470-ntsc
   #:cie-rgb
   #:colormatch-rgb
   #:dci-p3
   #:dci-p3+
   #:don-rgb-4
   #:eci-rgb-v2
   #:ekta-space-ps5
   #:prophoto-rgb
   #:simple-srgb
   #:smpte-c-rgb
   #:srgb)
  ;; Operations
  (:export
   #:adapt-chromaticity
   #:make-color))
