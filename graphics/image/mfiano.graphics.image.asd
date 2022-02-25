(asdf:defsystem #:mfiano.graphics.image
  :description "A simple color library."
  :author ("Michael Fiano <mail@mfiano.net>"
           "Catherine Tower <catherine@towernet.dev>")
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/image"
  :encoding :utf-8
  :depends-on (#:lparallel
               #:mfiano.math.origin
               #:mfiano.misc.utils)
  :in-order-to ((asdf:test-op (asdf:test-op #:mfiano.graphics.image.test)))
  :pathname "src"
  :serial t
  :components
  ((:module "base"
    :components
    ((:file "package")
     (:file "protocol")
     (:file "conditions")
     (:file "context")))
   (:module "color"
    :components
    ((:file "package")
     (:file "constants")
     (:file "storage")
     (:file "alpha")
     (:file "illuminants")
     (:file "chromatic-adaptation")
     (:file "spaces")
     (:file "model")
     (:file "pool")
     (:file "xyz")
     (:file "xyy")
     (:file "lab")
     (:file "lchab")
     (:file "lchuv")
     (:file "luv")
     (:file "rgb")
     (:file "convert")))
   (:module "image"
    :components
    ((:file "package")
     (:file "image")
     (:file "unorganized")
     (:file "types")))
   (:file "package")))
