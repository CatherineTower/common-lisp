(in-package #:cl-user)

(mfiano.misc.utils:define-package #:mfiano.graphics.tools.image
  (:use #:cl)
  (:inherit
   #:%mfiano.graphics.tools.image.base
   ;; Context
   #:context
   #:make-context
   #:with-context
   ;; Conditions
   #:color-error
   #:final-mixin-removed
   #:mixin-error
   #:mixin-not-present
   ;; Protocol
   #:convert)
  (:inherit-external
   #:%mfiano.graphics.tools.image.color))

(defpackage #:mfiano.graphics.tools.image.user
  (:local-nicknames
   (#:img #:mfiano.graphics.tools.image))
  (:use #:cl))

(in-package #:mfiano.graphics.tools.image.user)

(defvar *context* (img:make-context))
