(asdf:defsystem #:mfiano.graphics.tools.image
  :description "A simple color library."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/image"
  :encoding :utf-8
  :depends-on (#:cl-cpus
               #:closer-mop
               #:lparallel
               #:mfiano.math.gfxmath
               #:mfiano.misc.utils)
  :in-order-to ((asdf:test-op (asdf:test-op #:mfiano.graphics.tools.image.test)))
  :pathname "src"
  :serial t
  :components
  ((:module "base"
    :components
    ((:file "package")
     (:file "conditions")
     (:file "worker-state")
     (:file "context")
     (:file "mixin")
     (:file "protocol")))
   (:module "color"
    :components
    ((:file "package")
     (:file "protocol")
     (:file "storage")
     (:file "alpha")
     (:file "illuminants")
     (:file "chromatic-adaptation")
     (:file "models")
     (:file "spaces")
     (:file "rgb")
     (:file "luv")
     (:file "constructors")
     (:file "conversion")
     (:file "definitions")))
   (:module "image"
    :components
    ((:file "package")
     (:file "image")
     (:file "unorganized")
     (:file "types")))
   (:module "dev"
    :components
    ((:file "dev")))))
