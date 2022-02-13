(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image
  (:local-nicknames
   (#:base #:%mfiano.graphics.tools.image.internal.base)
   (#:lp #:lparallel)
   (#:m #:mfiano.math.gfxmath)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:height
   #:image
   #:width))
