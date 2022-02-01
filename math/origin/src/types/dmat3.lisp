(in-package #:cl-user)

(defpackage #:mfiano.math.origin.dmat3
  (:local-nicknames
   (#:com #:mfiano.math.origin.common)
   (#:dm2 #:mfiano.math.origin.dmat2)
   (#:dv2 #:mfiano.math.origin.dvec2)
   (#:dv3 #:mfiano.math.origin.dvec3)
   (#:m3 #:mfiano.math.origin.mat3)
   (#:ss #:specialization-store)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:shadow
   #:=
   #:+
   #:-
   #:*
   #:random
   #:trace)
  (:export
   #:mat
   #:with-components
   #:pretty-print
   #:+zero+
   #:+id+
   #:zero
   #:zero!
   #:zero-p
   #:id
   #:id!
   #:id-p
   #:=
   #:random!
   #:random
   #:copy!
   #:copy
   #:clamp!
   #:clamp
   #:clamp-range!
   #:clamp-range
   #:+!
   #:+
   #:-!
   #:-
   #:*!
   #:*
   #:get-column!
   #:get-column
   #:set-column!
   #:set-column
   #:get-translation!
   #:get-translation
   #:set-translation!
   #:set-translation
   #:translate!
   #:translate
   #:copy-rotation!
   #:copy-rotation
   #:rotation-to-mat2!
   #:rotation-to-mat2
   #:normalize-rotation!
   #:normalize-rotation
   #:rotation-axis-to-vec2!
   #:rotation-axis-to-vec2
   #:rotation-axis-from-vec2!
   #:rotation-axis-from-vec2
   #:rotation-x-from-angle!
   #:rotation-x-from-angle
   #:rotation-y-from-angle!
   #:rotation-y-from-angle
   #:rotation-z-from-angle!
   #:rotation-z-from-angle
   #:rotate!
   #:rotate
   #:get-scale!
   #:get-scale
   #:set-scale!
   #:set-scale
   #:scale!
   #:scale
   #:*v3!
   #:*v3
   #:transpose!
   #:transpose
   #:orthogonal-p
   #:trace
   #:diagonal-p
   #:main-diagonal!
   #:main-diagonal
   #:anti-diagonal!
   #:anti-diagonal
   #:set-diagonal!
   #:set-diagonal
   #:determinant
   #:invert!
   #:invert))

(in-package #:mfiano.math.origin.dmat3)

(deftype mat () '(u:f64a 9))

(defmacro with-components (((prefix matrix) &rest rest) &body body)
  (u:once-only (matrix)
    `(symbol-macrolet
         ((,prefix ,matrix)
          (,(com:make-accessor-symbol prefix "00") (aref ,matrix 0))
          (,(com:make-accessor-symbol prefix "10") (aref ,matrix 1))
          (,(com:make-accessor-symbol prefix "20") (aref ,matrix 2))
          (,(com:make-accessor-symbol prefix "01") (aref ,matrix 3))
          (,(com:make-accessor-symbol prefix "11") (aref ,matrix 4))
          (,(com:make-accessor-symbol prefix "21") (aref ,matrix 5))
          (,(com:make-accessor-symbol prefix "02") (aref ,matrix 6))
          (,(com:make-accessor-symbol prefix "12") (aref ,matrix 7))
          (,(com:make-accessor-symbol prefix "22") (aref ,matrix 8)))
       ,(if rest
            `(with-components ,rest ,@body)
            `(progn ,@body)))))

(defun pretty-print (matrix &optional (stream *standard-output*))
  (with-components ((m matrix))
    (format stream "[~,6f, ~,6f, ~,6f~% ~,6f, ~,6f, ~,6f~% ~,6f, ~,6f, ~,6f]"
            m00 m01 m02 m10 m11 m12 m20 m21 m22)))

;;; Constructors

(u:fn-> %mat (u:f64 u:f64 u:f64 u:f64 u:f64 u:f64 u:f64 u:f64 u:f64) mat)
(declaim (inline %mat))
(u:eval-always
  (defun %mat (m00 m10 m20 m01 m11 m21 m02 m12 m22)
    (declare (optimize speed))
    (let ((mat (u:make-f64-array 9)))
      (setf (aref mat 0) m00
            (aref mat 1) m10
            (aref mat 2) m20
            (aref mat 3) m01
            (aref mat 4) m11
            (aref mat 5) m21
            (aref mat 6) m02
            (aref mat 7) m12
            (aref mat 8) m22)
      mat)))

(ss:defstore mat (&rest args))

(ss:defspecialization (mat :inline t) () mat
  (%mat 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0))

(ss:defspecialization (mat :inline t) ((x real)) mat
  (%mat (float x 1d0) 0d0 0d0 0d0 (float x 1d0) 0d0 0d0 0d0 (float x 1d0)))

(ss:defspecialization (mat :inline t) ((mat dm2:mat)) mat
  (%mat (aref mat 0) (aref mat 1) 0d0 (aref mat 2) (aref mat 3) 0d0 0d0 0d0 1d0))

(ss:defspecialization (mat :inline t) ((mat mat)) mat
  (%mat (aref mat 0) (aref mat 1) (aref mat 2)
        (aref mat 3) (aref mat 4) (aref mat 5)
        (aref mat 6) (aref mat 7) (aref mat 8)))

(ss:defspecialization (mat :inline t) ((mat (u:f64a 16))) mat
  (%mat (aref mat 0) (aref mat 4) (aref mat 8)
        (aref mat 1) (aref mat 5) (aref mat 9)
        (aref mat 2) (aref mat 6) (aref mat 10)))

(ss:defspecialization (mat :inline t) ((vec1 dv3:vec) (vec2 dv3:vec) (vec3 dv3:vec)) mat
  (%mat (aref vec1 0) (aref vec1 1) (aref vec1 2)
        (aref vec2 0) (aref vec2 1) (aref vec2 2)
        (aref vec3 0) (aref vec3 1) (aref vec3 2)))

(ss:defspecialization (mat :inline t) ((a real) (b real) (c real)
                                       (d real) (e real) (f real)
                                       (g real) (h real) (i real))
    mat
  (%mat (float a 1d0) (float b 1d0) (float c 1d0)
        (float d 1d0) (float e 1d0) (float f 1d0)
        (float g 1d0) (float h 1d0) (float i 1d0)))

(ss:defspecialization (mat :inline t) ((mat m3:mat)) mat
  (%mat (float (aref mat 0) 1d0)
        (float (aref mat 1) 1d0)
        (float (aref mat 2) 1d0)
        (float (aref mat 3) 1d0)
        (float (aref mat 4) 1d0)
        (float (aref mat 5) 1d0)
        (float (aref mat 6) 1d0)
        (float (aref mat 7) 1d0)
        (float (aref mat 8) 1d0)))

;;; Constants

(u:define-constant +zero+ (%mat 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0) :test #'equalp)

(u:define-constant +id+ (%mat 1d0 0d0 0d0 0d0 1d0 0d0 0d0 0d0 1d0) :test #'equalp)
