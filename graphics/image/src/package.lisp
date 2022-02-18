(in-package #:cl-user)

(mfiano.misc.utils:define-package #:mfiano.graphics.image
  (:use #:cl)
  (:inherit
   #:%mfiano.graphics.image.base
   #:color-error
   #:convert
   #:with-threads)
  (:inherit-external
   #:%mfiano.graphics.image.color))

(defpackage #:mfiano.graphics.image.user
  (:local-nicknames
   (#:img #:mfiano.graphics.image))
  (:use #:cl))
