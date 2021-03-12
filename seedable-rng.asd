(asdf:defsystem #:seedable-rng
  :description "A seedable random number generator."
  :author ("Michael Fiano <mail@mfiano.net>")
  :license "MIT"
  :homepage "https://git.mfiano.net/mfiano/seedable-rng"
  :encoding :utf-8
  :depends-on (#:cl-pcg
               #:golden-utils
               #:ironclad)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "dictionary")
   (:file "generator")
   (:file "conditions")))
