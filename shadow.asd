(asdf:defsystem #:shadow
  :description "A lightweight system to help with defining and managing OpenGL shader programs."
  :author "Michael Fiano <mail@michaelfiano.com>"
  :maintainer "Michael Fiano <mail@michaelfiano.com>"
  :license "MIT"
  :homepage "https://www.michaelfiano.com/projects/shadow"
  :source-control (:git "git@github.com:mfiano/shadow.git")
  :bug-tracker "https://github.com/mfiano/shadow/issues"
  :version "1.0.0"
  :encoding :utf-8
  :long-description #.(uiop:read-file-string (uiop/pathname:subpathname *load-pathname* "README.md"))
  :depends-on (#:static-vectors
               #:glsl-packing
               #:varjo
               #:cl-opengl
               #:golden-utils)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "common")
   (:file "shadow")
   (:file "function")
   (:file "program")
   (:file "packing")
   (:file "attributes")
   (:file "uniforms")
   (:file "layout")
   (:file "blocks")
   (:file "buffers")))
