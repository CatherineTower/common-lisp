(in-package #:cl-user)

(mfiano.misc.utils:define-package #:mfiano.graphics.tools.image
  (:use #:cl)
  (:inherit
   #:%mfiano.graphics.tools.image.base
   #:color-error
   #:convert
   #:with-threads)
  (:inherit-external
   #:%mfiano.graphics.tools.image.color))

(defpackage #:mfiano.graphics.tools.image.user
  (:local-nicknames
   (#:img #:mfiano.graphics.tools.image))
  (:use #:cl))
