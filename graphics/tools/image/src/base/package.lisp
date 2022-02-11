(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.image.base
  (:local-nicknames
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils)
   (#:v3 #:mfiano.math.origin.dvec3))
  (:use #:cl)
  ;; Context
  (:export
   #:context
   #:make-context
   #:with-context)
  ;; Conditions
  (:export
   #:mixin-error
   #:mixin-last-removed-error
   #:mixin-not-present-error)
  ;; Protocol
  (:export
   #:convert))
