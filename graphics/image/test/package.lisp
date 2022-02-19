(in-package #:cl-user)

(defpackage #:mfiano.graphics.image.test
  (:local-nicknames
   (#:c #:%mfiano.graphics.image.color)
   (#:i #:mfiano.graphics.image)
   (#:u #:mfiano.misc.utils)
   (#:v2 #:mfiano.math.origin.dvec2)
   (#:v3 #:mfiano.math.origin.dvec3)
   (#:v4 #:mfiano.math.origin.dvec4))
  (:use #:cl
        #:prove))

(in-package #:mfiano.graphics.image.test)

(setf *enable-colors* nil)

;; HACK: Prove is using ASDF in a deprecated way causing an annoying but harmless warning message in
;; the middle of tests, so wrap test calling to hide the annoyance for now.
(defun run-tests (object)
  (handler-bind ((asdf/operate:recursive-operate #'muffle-warning))
    (run object)))
