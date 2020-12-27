(asdf:defsystem #:origin
  :description "A native Lisp graphics math library with an emphasis on performance and correctness."
  :author "Michael Fiano <mail@mfiano.net>"
  :license "MIT"
  :homepage "https://mfiano.net/projects/origin"
  :source-control (:git "https://git.mfiano.net/mfiano/origin")
  :bug-tracker "https://git.mfiano.net/mfiano/origin/issues"
  :encoding :utf-8
  :depends-on (#:golden-utils
               #:specialization-store)
  :pathname "src"
  :serial t
  :in-order-to ((asdf:test-op (asdf:test-op #:origin.test)))
  :components
  ((:file "common/package")
   (:file "common/util")
   (:file "common/constants")
   (:file "types/vec2")
   (:file "types/vec3")
   (:file "types/vec4")
   (:file "types/dvec2")
   (:file "types/dvec3")
   (:file "types/dvec4")
   (:file "types/mat2")
   (:file "types/mat3")
   (:file "types/mat4")
   (:file "types/dmat2")
   (:file "types/dmat3")
   (:file "types/dmat4")
   (:file "types/quat")
   (:file "types/dquat")
   (:file "operations/vec2")
   (:file "operations/vec3")
   (:file "operations/vec4")
   (:file "operations/dvec2")
   (:file "operations/dvec3")
   (:file "operations/dvec4")
   (:file "operations/mat2")
   (:file "operations/mat3")
   (:file "operations/mat4")
   (:file "operations/dmat2")
   (:file "operations/dmat3")
   (:file "operations/dmat4")
   (:file "operations/quat")
   (:file "operations/dquat")
   (:file "shaping/shaping")
   (:file "geometry/shapes/point2d")
   (:file "geometry/shapes/line2d")
   (:file "geometry/shapes/circle")
   (:file "geometry/shapes/rect")
   (:file "geometry/shapes/oriented-rect")
   (:file "geometry/shapes/set2d")
   (:file "geometry/shapes/point3d")
   (:file "geometry/shapes/line3d")
   (:file "geometry/shapes/ray")
   (:file "geometry/shapes/sphere")
   (:file "geometry/shapes/plane")
   (:file "geometry/shapes/triangle")
   (:file "geometry/shapes/aabb")
   (:file "geometry/shapes/obb")
   (:file "geometry/shapes/set3d")
   (:file "geometry/package")
   (:file "geometry/bounds")
   (:file "geometry/closest-point")
   (:file "geometry/intersection")
   (:file "geometry/raycast")))
