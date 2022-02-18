(in-package #:cl-user)

(defpackage #:%mfiano.graphics.image
  (:local-nicknames
   (#:base #:%mfiano.graphics.image.base)
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils)
   (#:v4 #:mfiano.math.origin.vec4))
  (:use #:cl)
  (:export
   #:height
   #:image
   #:width))
