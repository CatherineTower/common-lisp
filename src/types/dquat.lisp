(in-package #:cl-user)

(defpackage #:net.mfiano.lisp.origin.dquat
  (:local-nicknames
   (#:com #:net.mfiano.lisp.origin.common)
   (#:dm3 #:net.mfiano.lisp.origin.dmat3)
   (#:dm4 #:net.mfiano.lisp.origin.dmat4)
   (#:dv3 #:net.mfiano.lisp.origin.dvec3)
   (#:dv4 #:net.mfiano.lisp.origin.dvec4)
   (#:q #:net.mfiano.lisp.origin.quat)
   (#:ss #:specialization-store)
   (#:u #:net.mfiano.lisp.golden-utils))
  (:use #:cl)
  (:shadow
   #:=
   #:+
   #:-
   #:*
   #:conjugate
   #:length
   #:random)
  (:export
   #:quat
   #:with-components
   #:with-elements
   #:w
   #:x
   #:y
   #:z
   #:+id+
   #:id
   #:id!
   #:id-p
   #:=
   #:random!
   #:random
   #:copy!
   #:copy
   #:+!
   #:+
   #:-!
   #:-
   #:*!
   #:*
   #:scale!
   #:scale
   #:conjugate!
   #:conjugate
   #:cross!
   #:cross
   #:length-squared
   #:length
   #:normalize!
   #:normalize
   #:negate!
   #:negate
   #:dot
   #:inverse!
   #:inverse
   #:rotate-euler!
   #:rotate-euler
   #:rotate!
   #:rotate
   #:to-euler!
   #:to-euler
   #:to-mat3!
   #:to-mat3
   #:to-mat4!
   #:to-mat4
   #:from-mat3!
   #:from-mat3
   #:from-mat4!
   #:from-mat4
   #:slerp!
   #:slerp
   #:from-axis-angle!
   #:from-axis-angle
   #:orient!
   #:orient
   #:from-velocity!
   #:from-velocity))

(in-package #:net.mfiano.lisp.origin.dquat)

(deftype quat () '(simple-array u:f64 (4)))

(defmacro with-components (((prefix quat) &rest rest) &body body)
  (u:once-only (quat)
    `(symbol-macrolet
         ((,prefix ,quat)
          (,(com:make-accessor-symbol prefix "W") (aref ,quat 0))
          (,(com:make-accessor-symbol prefix "X") (aref ,quat 1))
          (,(com:make-accessor-symbol prefix "Y") (aref ,quat 2))
          (,(com:make-accessor-symbol prefix "Z") (aref ,quat 3)))
       ,(if rest
            `(with-components ,rest ,@body)
            `(progn ,@body)))))

(defmacro with-elements (((prefix w x y z) &rest rest) &body body)
  (let ((%w (com:make-accessor-symbol prefix "W"))
        (%x (com:make-accessor-symbol prefix "X"))
        (%y (com:make-accessor-symbol prefix "Y"))
        (%z (com:make-accessor-symbol prefix "Z")))
    `(let ((,%w ,w) (,%x ,x) (,%y ,y) (,%z ,z))
       (declare (ignorable ,%w ,%x ,%y ,%z))
       ,(if rest
            `(with-elements ,rest ,@body)
            `(progn ,@body)))))
