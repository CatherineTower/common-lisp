(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image
  (:local-nicknames
   (#:b #:mfiano.graphics.tools.image.base)
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils)
   (#:v4 #:mfiano.math.origin.vec4))
  (:use #:cl)
  (:export
   #:height
   #:image
   #:width))
