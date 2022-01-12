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
   (:file "utils")
   (:file "types")
   (:file "constructors")
   (:file "decompose")
   (:file "convert")))
