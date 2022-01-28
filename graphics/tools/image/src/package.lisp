(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image
  (:local-nicknames
   (#:lp #:lparallel)
   (#:m #:mfiano.math.gfxmath)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; context
  (:export
   #:context
   #:make-context)
  ;; image
  (:export
   #:height
   #:image
   #:width))
