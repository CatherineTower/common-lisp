(asdf:defsystem #:mfiano.graphics.tools.image
  :description "A simple color library."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/image"
  :encoding :utf-8
  :depends-on (#:cl-cpus
               #:closer-mop
               #:lparallel
               #:mfiano.math.origin
               #:mfiano.misc.utils)
  :in-order-to ((asdf:test-op (asdf:test-op #:mfiano.graphics.tools.image.test)))
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "conditions")
   (:file "worker-state")
   (:file "context")
   (:file "mixin")
   (:module "color"
    :components
    ((:file "storage")
     (:file "alpha")
     (:file "illuminants")
     (:file "chromatic-adaptation")
     (:file "spaces")
     (:file "rgb-transforms")
     (:file "tonal-response-curves")
     (:file "definitions")
     (:file "constructors")
     (:file "conversion")))
   (:module "image"
    :components
    ((:file "image")
     (:file "unorganized")
     (:file "types")))))
