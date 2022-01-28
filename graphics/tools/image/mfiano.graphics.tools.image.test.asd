(asdf:defsystem #:mfiano.graphics.tools.image.test
  :description "Tests for mfiano.graphics.tools.image."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/image"
  :depends-on (#:mfiano.graphics.tools.image
               #:mfiano.misc.utils
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (op c)
                         (uiop:symbol-call '#:mfiano.graphics.tools.image.test '#:run-tests c))
  :components
  ((:file "package")
   (:test-file "test")))
