(asdf:defsystem #:mfiano.graphics.tile-grid
  :description "A simple tile grid implementation."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/tile-grid"
  :version "0.1.0"
  :encoding :utf-8
  :depends-on (#:mfiano.misc.utils)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "tile-grid")))
