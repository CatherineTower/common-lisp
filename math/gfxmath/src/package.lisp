(in-package #:cl-user)

(defpackage #:mfiano.math.gfxmath
  (:local-nicknames
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:shadow
   #:+
   #:-
   #:*
   #:/
   #:=
   #:<
   #:<=
   #:>
   #:>=
   #:abs
   #:acos
   #:asin
   #:atan
   #:ceiling
   #:conjugate
   #:cos
   #:expt
   #:floor
   #:max
   #:min
   #:mod
   #:round
   #:sin
   #:sqrt
   #:tan
   #:trace
   #:vector)
  (:export
   #:+m2-id+
   #:+m2-zero+
   #:+m3-id+
   #:+m3-zero+
   #:+m4-id+
   #:+m4-zero+
   #:+q-id+
   #:+v2+x+
   #:+v2-x+
   #:+v2+y+
   #:+v2-y+
   #:+v2-ones+
   #:+v2-zero+
   #:+v3+x+
   #:+v3-x+
   #:+v3+y+
   #:+v3-y+
   #:+v3+z+
   #:+v3-z+
   #:+v3-ones+
   #:+v3-zero+
   #:+v4+x+
   #:+v4-x+
   #:+v4+y+
   #:+v4-y+
   #:+v4+z+
   #:+v4-z+
   #:+v4+w+
   #:+v4-w+
   #:+v4-ones+
   #:+v4-zero+
   #:mat
   #:mat/from-mat
   #:mat/from-vecs
   #:mat/id
   #:mat/random
   #:mat/rotation
   #:math-object
   #:math-object?
   #:matrix
   #:matrix?
   #:mref
   #:quat
   #:quat/from-axis-angle
   #:quat/from-mat
   #:quat/from-velocity
   #:quat/id
   #:quat/oriented
   #:ref
   #:vec
   #:vec/from-vec
   #:vec/random
   #:vec/velocity
   #:vec/zero
   #:vector
   #:vector?
   #:w
   #:with-matrix
   #:with-quaternion
   #:with-vector
   #:x
   #:y
   #:z))