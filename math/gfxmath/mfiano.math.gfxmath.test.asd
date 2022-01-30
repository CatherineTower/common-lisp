(asdf:defsystem #:mfiano.math.gfxmath.test
  :description "Unit tests for mfiano.math.gfxmath."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/math/gfxmath"
  :depends-on (#:mfiano.math.gfxmath
               #:mfiano.misc.utils
               #:prove)
  :defsystem-depends-on (#:prove-asdf)
  :perform (asdf:test-op (op c) (uiop:symbol-call '#:mfiano.math.gfxmath.test '#:run-tests c))
  :pathname "test"
  :serial t
  :components
  ((:file "package")
   (:file "common")
   (:test-file "vector")
   (:test-file "matrix")
   (:test-file "quaternion")))
