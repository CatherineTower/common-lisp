(asdf:defsystem #:mfiano.graphics.tools.color.test
  :description "Tests for mfiano.graphics.tools.color."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/color"
  :depends-on (#:mfiano.graphics.tools.color
               #:mfiano.misc.utils
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (op c)
                         (uiop:symbol-call '#:mfiano.graphics.tools.color.test '#:run-tests c))
  :components
  ((:file "package")
   (:test-file "test")))
