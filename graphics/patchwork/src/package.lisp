(in-package #:cl-user)

(defpackage #:mfiano.graphics.patchwork
  (:local-nicknames
   (#:bin #:binpack)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:make-atlas
   #:make-atlas-from-directory
   #:unpack-atlas))
