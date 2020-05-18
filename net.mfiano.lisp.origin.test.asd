(asdf:defsystem #:net.mfiano.lisp.origin.test
  :description "Tests for origin."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :depends-on (#:net.mfiano.lisp.origin
               #:parachute)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (o c)
                         (uiop:symbol-call
                          '#:parachute '#:test '#:net.mfiano.lisp.origin.test))
  :components
  ((:file "package")
   (:file "vec2")
   (:file "vec3")
   (:file "vec4")
   (:file "mat2")
   (:file "mat3")
   (:file "mat4")
   (:file "quat")))
