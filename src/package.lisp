(in-package #:cl-user)

(defpackage #:%syntex.internal
  (:use #:cl)
  ;; Conditions
  (:export
   #:file-not-found
   #:invalid-dimension
   #:invalid-harrison-candidate-count
   #:invalid-harrison-rounds
   #:invalid-kernel-size
   #:invalid-seed
   #:syntex-error))

(defpackage #:%syntex.image
  (:local-nicknames
   (#:png #:pngload)
   (#:u #:golden-utils))
  (:use #:cl)
  (:export))

(defpackage #:%syntex.harrison
  (:local-nicknames
   (#:int #:%syntex.internal)
   (#:lp #:lparallel)
   (#:img #:%syntex.image)
   (#:rng #:seedable-rng)
   (#:u #:golden-utils))
  (:use #:cl)
  (:export
   #:harrison))

(defpackage #:%syntex.wfc
  (:local-nicknames
   (#:img #:%syntex.image)
   (#:u #:golden-utils))
  (:use #:cl)
  (:export))

(uiop:define-package #:syntex
  (:use #:cl)
  (:reexport #:%syntex.harrison))
