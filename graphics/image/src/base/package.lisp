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
   #:color-pools
   #:color-space-data
   #:color-space-graph
   #:cone-responses
   #:illuminants
   #:rgb-transforms
   #:with-threads)
  ;; Conditions
  (:export
   #:color-error))
