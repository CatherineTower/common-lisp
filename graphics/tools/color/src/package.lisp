(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.color
  (:local-nicknames
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; models
  (:export
   #:alpha8
   #:alpha16
   #:gray8
   #:gray16
   #:gray-alpha8
   #:gray-alpha16
   #:indexed
   #:rgb8
   #:rgb16
   #:rgba8
   #:rgba16
   #:rgba8-pma
   #:rgba16-pma)
  ;; operations
  (:export
   #:convert
   #:make-palette))
