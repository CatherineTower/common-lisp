(in-package #:cl-user)

(uiop:define-package #:mfiano.graphics.tools.image.dev
  (:mix
   #:mfiano.graphics.tools.image.base
   #:mfiano.graphics.tools.image.color
   #:mfiano.graphics.tools.image)
  (:use #:cl))

(in-package #:mfiano.graphics.tools.image.dev)

(defvar *context* (make-context))
