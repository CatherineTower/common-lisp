(in-package #:cl-user)

(defpackage #:%mfiano.graphics.image.base
  (:local-nicknames
   (#:lp #:lparallel)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; Context
  (:export
   #:*context*
   #:*parallel-p*
   #:*worker-pools*
   #:chromatic-adaptation-transforms
   #:chromatic-adaptation-transform-lock
   #:color-models
   #:color-pools
   #:color-pools
   #:color-space-data
   #:color-space-graph
   #:color-spaces
   #:cone-responses
   #:illuminants
   #:rgb-transforms
   #:rgb-transform-lock
   #:with-threads)
  ;; Conditions
  (:export
   #:color-error))
