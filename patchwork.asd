(asdf:defsystem #:patchwork
  :description "A spritesheet packer for games."
  :author "Michael Fiano <mail@michaelfiano.com>"
  :maintainer "Michael Fiano <mail@michaelfiano.com>"
  :license "MIT"
  :homepage "https://www.michaelfiano.com/projects/patchwork"
  :source-control (:git "https://github.com/mfiano/patchwork.git")
  :bug-tracker "https://github.com/mfiano/patchwork/issues"
  :encoding :utf-8
  :depends-on (#:binpack
               #:opticl
               #:pngload
               #:uiop)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "packer")
   (:file "unpacker")))
