(asdf:defsystem #:mfiano.graphics.convolution-kernel
  :description "An implementation of a kernel useful for convolution-like cellular transformations across a grid."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://github.com/mfiano/common-lisp/tree/master/graphics/convolution-kernel"
  :version "0.1.0"
  :encoding :utf-8
  :depends-on (#:mfiano.graphics.tile-grid
               #:mfiano.misc.utils)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "convolution-kernel")))
