(in-package #:cl-user)

(defpackage #:mfiano.math.origin.dvec4
  (:local-nicknames
   (#:com #:mfiano.math.origin.common)
   (#:const #:mfiano.math.origin.constants)
   (#:dv2 #:mfiano.math.origin.dvec2)
   (#:dv3 #:mfiano.math.origin.dvec3)
   (#:u #:mfiano.misc.utils)
   (#:v4 #:mfiano.math.origin.vec4))
  (:use #:cl)
  (:shadow
   #:=
   #:+
   #:-
   #:*
   #:/
   #:random
   #:length
   #:round
   #:abs
   #:<
   #:<=
   #:>
   #:>=
   #:min
   #:max
   #:expt
   #:sqrt
   #:floor
   #:ceiling
   #:mod
   #:sin
   #:cos
   #:tan
   #:asin
   #:acos
   #:atan)
  (:export
   #:vec
   #:x
   #:y
   #:z
   #:w
   #:with-components
   #:+zero+
   #:+ones+
   #:zero
   #:zero!
   #:zero-p
   #:ones!
   #:ones
   #:uniform!
   #:uniform
   #:random!
   #:random
   #:copy!
   #:copy
   #:sign!
   #:sign
   #:fract!
   #:fract
   #:clamp!
   #:clamp
   #:clamp-range!
   #:clamp-range
   #:=
   #:+!
   #:+
   #:-!
   #:-
   #:*!
   #:*
   #:/!
   #:/
   #:scale!
   #:scale
   #:invert!
   #:invert
   #:dot
   #:length-squared
   #:length
   #:normalize!
   #:normalize
   #:round!
   #:round
   #:abs!
   #:abs
   #:negate!
   #:negate
   #:angle
   #:direction=
   #:parallel-p
   #:lerp!
   #:lerp
   #:<
   #:<=
   #:>
   #:>=
   #:min!
   #:min
   #:max!
   #:max
   #:radians!
   #:radians
   #:degrees!
   #:degrees
   #:expt!
   #:expt
   #:sqrt!
   #:sqrt
   #:floor!
   #:floor
   #:ceiling!
   #:ceiling
   #:mod!
   #:mod
   #:sin!
   #:sin
   #:cos!
   #:cos
   #:tan!
   #:tan
   #:asin!
   #:asin
   #:acos!
   #:acos
   #:atan!
   #:atan))

(in-package #:mfiano.math.origin.dvec4)

(deftype vec () '(u:f64a 4))

(defmacro with-components (((prefix vec) &rest rest) &body body)
  (u:once-only (vec)
    `(symbol-macrolet
         ((,prefix ,vec)
          (,(com:make-accessor-symbol prefix "X") (aref ,vec 0))
          (,(com:make-accessor-symbol prefix "Y") (aref ,vec 1))
          (,(com:make-accessor-symbol prefix "Z") (aref ,vec 2))
          (,(com:make-accessor-symbol prefix "W") (aref ,vec 3)))
       ,(if rest
            `(with-components ,rest ,@body)
            `(progn ,@body)))))

;;; Constructor

(u:fn-> vec (u:f64 u:f64 u:f64 u:f64) vec)
(declaim (inline vec))
(u:eval-always
  (defun vec (x y z w)
    (declare (optimize speed))
    (let ((vec (u:make-f64-array 4)))
      (setf (aref vec 0) x
            (aref vec 1) y
            (aref vec 2) z
            (aref vec 3) w)
      vec)))

;;; Accessors

(u:fn-> x (vec) u:f64)
(declaim (inline x))
(defun x (vec)
  "Read the 'X' component of vector VEC."
  (aref vec 0))

(u:fn-> (setf x) (u:f64 vec) u:f64)
(declaim (inline (setf x)))
(defun (setf x) (value vec)
  "Write VALUE to the 'X' component of vector VEC."
  (setf (aref vec 0) value))

(u:fn-> y (vec) u:f64)
(declaim (inline y))
(defun y (vec)
  "Read the 'Y' component of vector VEC."
  (aref vec 1))

(u:fn-> (setf y) (u:f64 vec) u:f64)
(declaim (inline (setf y)))
(defun (setf y) (value vec)
  "Write VALUE to the 'Y' component of vector VEC."
  (setf (aref vec 1) value))

(u:fn-> z (vec) u:f64)
(declaim (inline z))
(defun z (vec)
  "Read the 'Z' component of vector VEC."
  (aref vec 2))

(u:fn-> (setf z) (u:f64 vec) u:f64)
(declaim (inline (setf z)))
(defun (setf z) (value vec)
  "Write VALUE to the 'Z' component of vector VEC."
  (setf (aref vec 2) value))

(u:fn-> w (vec) u:f64)
(declaim (inline w))
(defun w (vec)
  "Read the 'W' component of vector VEC."
  (aref vec 3))

(u:fn-> (setf w) (u:f64 vec) u:f64)
(declaim (inline (setf w)))
(defun (setf w) (value vec)
  "Write VALUE to the 'W' component of vector VEC."
  (setf (aref vec 3) value))

;;; Constants

(u:define-constant +zero+ (vec 0d0 0d0 0d0 0d0)
  :test #'equalp
  :documentation "Constant representing a 4D zero vector.")

(u:define-constant +ones+ (vec 1d0 1d0 1d0 1d0)
  :test #'equalp
  :documentation "Constant representing a 4D vector with each component being 1.")
