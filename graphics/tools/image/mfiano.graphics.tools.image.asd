(asdf:defsystem #:mfiano.graphics.tools.image
  :description "A simple color library."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/image"
  :encoding :utf-8
  :depends-on (#:cl-cpus
               #:closer-mop
               #:global-vars
               #:lparallel
               #:mfiano.math.origin
               #:mfiano.misc.utils)
  :in-order-to ((asdf:test-op (asdf:test-op #:mfiano.graphics.tools.image.test)))
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "conditions")
   (:file "mixin")
   (:file "worker-state")
   (:file "context")
   (:module "color"
    :components
    ((:file "storage")
     (:file "alpha")
     (:file "standard-illuminants")
     (:file "chromatic-adaptation")
     (:file "tonal-response-curves")
     (:module "spaces"
      :components
      ((:file "utils")
       (:file "definitions")
       (:file "rgb")
       (:file "constructors")
       (:file "conversion")))))
   (:module "image"
    :components
    ((:file "image")
     (:file "unorganized")
     (:file "types")))))
