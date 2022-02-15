(in-package #:cl-user)

(uiop:define-package #:mfiano.graphics.tools.image.dev
  (:mix-reexport
   #:mfiano.graphics.tools.image.base
   #:mfiano.graphics.tools.image.color
   #:mfiano.graphics.tools.image)
  (:use #:cl))

(defpackage #:mfiano.graphics.tools.image.user
  (:local-nicknames
   (#:img #:mfiano.graphics.tools.image.dev))
  (:use #:cl))

(in-package #:mfiano.graphics.tools.image.user)

(defvar *context* (img:make-context :worker-count 2))
