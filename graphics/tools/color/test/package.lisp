(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.color.test
  (:local-nicknames
   (#:c #:mfiano.graphics.tools.color)
   (#:u #:mfiano.misc.utils))
  (:use #:cl
        #:prove))

(in-package #:mfiano.graphics.tools.color.test)

(setf *enable-colors* nil)

;; HACK: Prove is using ASDF in a deprecated way causing an annoying but harmless warning message in
;; the middle of tests, so wrap test calling to hide the annoyance for now.
(defun run-tests (object)
  (handler-bind ((asdf/operate:recursive-operate #'muffle-warning))
    (run object)))
