(asdf:defsystem #:mfiano.graphics.cricket.test
  :description "Tests for mfiano.graphics.cricket."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/cricket"
  :depends-on (#:mfiano.file-formats.png
               #:mfiano.graphics.cricket
               #:mfiano.misc.utils
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (op c) (uiop:symbol-call '#:mfiano.graphics.cricket.test '#:run-tests c))
  :components
  ((:file "package")
   (:file "common")
   (:test-file "test")))
