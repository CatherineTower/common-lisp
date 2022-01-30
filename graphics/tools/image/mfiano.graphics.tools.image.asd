(asdf:defsystem #:mfiano.graphics.tools.image
  :description "A simple color library."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/image"
  :encoding :utf-8
  :depends-on (#:cl-cpus
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
   (:module "color"
    :components
    ((:file "color")
     (:file "spaces")
     (:file "models")
     (:file "conversions")))
   (:module "image"
    :components
    ((:file "image")
     (:file "unorganized")
     (:file "types")))))
