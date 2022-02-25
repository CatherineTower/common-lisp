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
  ;; Operations
  (:export
   #:adapt-chromaticity
   #:make-color))
