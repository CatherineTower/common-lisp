(asdf:defsystem #:mfiano.graphics.image
  :description "A simple color library."
  :author ("Michael Fiano <mail@mfiano.net>"
           "Catherine Tower <catherine@towernet.dev>")
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/image"
  :encoding :utf-8
  :depends-on (#:graph
               #:lparallel
               #:mfiano.math.origin
               #:mfiano.misc.utils)
  :in-order-to ((asdf:test-op (asdf:test-op #:mfiano.graphics.image.test)))
  :pathname "src"
  :serial t
  :components
  ((:module "base"
    :components
    ((:file "package")
     (:file "conditions")
     (:file "context")))
   (:module "color"
    :components
    ((:file "package")
     (:file "constants")
     (:file "protocol")
     (:file "mixin-storage")
     (:file "mixin-alpha")
     (:file "mixin-rgb")
     (:file "color")
     (:file "models")
     (:file "spaces")
     (:file "pool")
     (:file "constructors")
     (:file "illuminant")
     (:file "chromatic-adaptation")
     (:file "gamma")
     (:file "difference")
     (:file "space-utils")
     (:file "convert")))
   (:module "image"
    :components
    ((:file "package")
     (:file "image")
     (:file "unorganized")
     (:file "types")))
   (:file "package")))
