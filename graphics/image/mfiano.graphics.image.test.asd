(asdf:defsystem #:mfiano.graphics.image.test
  :description "Tests for mfiano.graphics.image."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/image"
  :depends-on (#:mfiano.graphics.image
               #:parachute)
  :pathname "test"
  :serial t
  :perform (asdf:test-op (op c) (uiop:symbol-call '#:mfiano.graphics.image.test '#:run))
  :components
  ((:file "package")
   (:file "report")
   (:file "utils")
   (:module "color"
    :components
    ((:file "color")
     (:module "convert"
      :components
      ((:file "xyz")
       (:file "xyy")
       (:file "lab")
       (:file "lchab")
       (:file "luv")
       (:file "lchuv")
       (:file "rgb-adobe-rgb")
       (:file "rgb-adobe-wide-gamut-rgb")
       (:file "rgb-apple-rgb")
       (:file "rgb-best-rgb")
       (:file "rgb-beta-rgb")
       (:file "rgb-bruce-rgb")
       (:file "rgb-bt2020")
       (:file "rgb-bt470-ntsc")
       (:file "rgb-bt470-pal-secam")
       (:file "rgb-cie-rgb")
       (:file "rgb-colormatch-rgb")
       (:file "rgb-dci-p3")
       (:file "rgb-dci-p3+")
       (:file "rgb-don-rgb-4")
       (:file "rgb-eci-rgb-v2")
       (:file "rgb-ekta-space-ps5")
       (:file "rgb-prophoto-rgb")
       (:file "rgb-simple-srgb")
       (:file "rgb-smpte-c-rgb")
       (:file "rgb-srgb")))))))
