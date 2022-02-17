(in-package #:cl-user)

(defpackage #:%mfiano.graphics.tools.image.base
  (:local-nicknames
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; Context
  (:export
   #:*context*
   #:*default-context*
   #:chromatic-adaptation-transforms
   #:color-spaces
   #:cone-responses
   #:context
   #:illuminants
   #:make-context
   #:rgb-transforms
   #:with-context)
  ;; Worker state
  (:export
   #:*worker-state*
   #:color-pools)
  ;; Conditions
  (:export
   #:color-error)
  ;; Protocol
  (:export
   #:convert))
