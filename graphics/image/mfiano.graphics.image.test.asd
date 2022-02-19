(asdf:defsystem #:mfiano.graphics.image.test
  :description "Tests for mfiano.graphics.image."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/image"
  :depends-on (#:mfiano.graphics.image
               #:mfiano.math.origin
               #:mfiano.misc.utils
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (op c) (uiop:symbol-call '#:mfiano.graphics.image.test '#:run-tests c))
  :components
  ((:file "package")
   (:file "utils")
   (:test-file "color-convert")))
