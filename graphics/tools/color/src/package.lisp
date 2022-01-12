(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.color
  (:local-nicknames
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; types
  (:export
   #:alpha
   #:alpha16
   #:gray
   #:gray16
   #:rgba
   #:rgba-pma
   #:rgba16
   #:rgba16-pma)
  ;; operations
  (:export
   #:convert))
