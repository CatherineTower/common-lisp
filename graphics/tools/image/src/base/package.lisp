(in-package #:cl-user)

(defpackage #:%mfiano.graphics.tools.image.base
  (:local-nicknames
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; Context
  (:export
   #:*context*
   #:*worker-pools*
   #:chromatic-adaptation-transforms
   #:color-spaces
   #:cone-responses
   #:illuminants
   #:rgb-transforms
   #:with-threads)
  ;; Conditions
  (:export
   #:color-error)
  ;; Protocol
  (:export
   #:convert))
