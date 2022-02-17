(asdf:defsystem #:mfiano.graphics.tools.image
  :description "A simple color library."
  :author ("Michael Fiano <mail@mfiano.net>"
           "Catherine Tower <catherine@towernet.dev>")
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
  ((:module "base"
    :components
    ((:file "package")
     (:file "protocol")
     (:file "conditions")
     (:file "worker-state")
     (:file "context")
     (:file "mixin")))
   (:module "color"
    :components
    ((:file "package")
     (:file "protocol")
     (:file "storage")
     (:file "alpha")
     (:file "illuminants")
     (:file "chromatic-adaptation")
     (:file "pool")
     (:file "color")
     (:file "types")
     (:file "definitions")
     (:file "rgb")
     (:file "luv")
     (:file "convert")))
   (:module "image"
    :components
    ((:file "package")
     (:file "image")
     (:file "unorganized")
     (:file "types")))
   (:file "package")))
