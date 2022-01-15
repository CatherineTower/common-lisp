(asdf:defsystem #:mfiano.graphics.tools.color
  :description "A simple color library."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tools/color"
  :encoding :utf-8
  :depends-on (#:mfiano.misc.utils)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "types")
   (:file "protocol")
   (:file "utils")
   (:module "models"
    :components
    ((:file "alpha8")
     (:file "alpha16")
     (:file "cmyk")
     (:file "gray8")
     (:file "gray16")
     (:file "gray-alpha8")
     (:file "gray-alpha16")
     (:file "indexed")
     (:file "rgb8")
     (:file "rgb16")
     (:file "rgba8")
     (:file "rgba8-pma")
     (:file "rgba16")
     (:file "rgba16-pma")))
   (:module "palettes"
    :components
    ((:file "3-bit-rgb")
     (:file "3-3-2-bit-rgb")
     (:file "amstrad-cpc")
     (:file "apple-ii-gr")
     (:file "apple-ii-hgr")
     (:file "cga")
     (:file "commodore-16")
     (:file "commodore-64")
     (:file "commodore-vic-20a")
     (:file "commodore-vic-20b")
     (:file "ctia")
     (:file "gtia")
     (:file "mattel-aquarius")
     (:file "open-color")
     (:file "thomson-m05")
     (:file "thomson-t07-1")
     (:file "thomson-t07-2")
     (:file "thomson-t07-3")
     (:file "tms9918")
     (:file "zx-spectrum")))))
