(in-package #:cl-user)

(defpackage #:mfiano.math.origin.mat4
  (:local-nicknames
   (#:com #:mfiano.math.origin.common)
   (#:m2 #:mfiano.math.origin.mat2)
   (#:m3 #:mfiano.math.origin.mat3)
   (#:ss #:specialization-store)
   (#:u #:mfiano.misc.utils)
   (#:v3 #:mfiano.math.origin.vec3)
   (#:v4 #:mfiano.math.origin.vec4))
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
   #:rotation-to-mat3!
   #:rotation-to-mat3
   #:normalize-rotation!
   #:normalize-rotation
   #:rotation-axis-to-vec3!
   #:rotation-axis-to-vec3
   #:rotation-axis-from-vec3!
   #:rotation-axis-from-vec3
   #:rotation-x-from-angle!
   #:rotation-x-from-angle
   #:rotation-y-from-angle!
   #:rotation-y-from-angle!
   #:rotation-z-from-angle
   #:rotation-z-from-angle
   #:rotate!
   #:rotate
   #:get-scale!
   #:get-scale
   #:set-scale!
   #:set-scale
   #:scale!
   #:scale
   #:*v4!
   #:*v4
   #:transpose!
   #:transpose
   #:orthogonal-p
   #:orthonormalize!
   #:orthonormalize
   #:trace
   #:diagonal-p
   #:main-diagonal!
   #:main-diagonal
   #:anti-diagonal!
   #:anti-diagonal
   #:set-diagonal!
   #:set-diagonal
   #:determinant
   #:invert-orthogonal!
   #:invert-orthogonal
   #:invert!
   #:invert
   #:look-at!
   #:look-at
   #:ortho!
   #:ortho
   #:perspective!
   #:perspective))

(in-package #:mfiano.math.origin.mat4)

(deftype mat () '(u:f32a 16))

(defmacro with-components (((prefix matrix) &rest rest) &body body)
  (u:once-only (matrix)
    `(symbol-macrolet
         ((,prefix ,matrix)
          (,(com:make-accessor-symbol prefix "00") (aref ,matrix 0))
          (,(com:make-accessor-symbol prefix "10") (aref ,matrix 1))
          (,(com:make-accessor-symbol prefix "20") (aref ,matrix 2))
          (,(com:make-accessor-symbol prefix "30") (aref ,matrix 3))
          (,(com:make-accessor-symbol prefix "01") (aref ,matrix 4))
          (,(com:make-accessor-symbol prefix "11") (aref ,matrix 5))
          (,(com:make-accessor-symbol prefix "21") (aref ,matrix 6))
          (,(com:make-accessor-symbol prefix "31") (aref ,matrix 7))
          (,(com:make-accessor-symbol prefix "02") (aref ,matrix 8))
          (,(com:make-accessor-symbol prefix "12") (aref ,matrix 9))
          (,(com:make-accessor-symbol prefix "22") (aref ,matrix 10))
          (,(com:make-accessor-symbol prefix "32") (aref ,matrix 11))
          (,(com:make-accessor-symbol prefix "03") (aref ,matrix 12))
          (,(com:make-accessor-symbol prefix "13") (aref ,matrix 13))
          (,(com:make-accessor-symbol prefix "23") (aref ,matrix 14))
          (,(com:make-accessor-symbol prefix "33") (aref ,matrix 15)))
       ,(if rest
            `(with-components ,rest ,@body)
            `(progn ,@body)))))

(defun pretty-print (matrix &optional (stream *standard-output*))
  (with-components ((m matrix))
    (format stream "[~,6f, ~,6f, ~,6f, ~,6f~% ~
                     ~,6f, ~,6f, ~,6f, ~,6f~% ~
                     ~,6f, ~,6f, ~,6f, ~,6f~% ~
                     ~,6f, ~,6f, ~,6f, ~,6f]"
            m00 m01 m02 m03 m10 m11 m12 m13 m20 m21 m22 m23 m30 m31 m32 m33)))

;;; Constructors

(u:fn-> %mat (u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32 u:f32
                    u:f32 u:f32)
        mat)
(declaim (inline %mat))
(u:eval-always
  (defun %mat (m00 m10 m20 m30 m01 m11 m21 m31 m02 m12 m22 m32 m03 m13 m23 m33)
    (declare (optimize speed))
    (let ((mat (u:make-f32-array 16)))
      (setf (aref mat 0) m00 (aref mat 1) m10 (aref mat 2) m20 (aref mat 3) m30
            (aref mat 4) m01 (aref mat 5) m11 (aref mat 6) m21 (aref mat 7) m31
            (aref mat 8) m02 (aref mat 9) m12 (aref mat 10) m22 (aref mat 11) m32
            (aref mat 12) m03 (aref mat 13) m13 (aref mat 14) m23 (aref mat 15) m33)
      mat)))

(ss:defstore mat (&rest args))

(ss:defspecialization (mat :inline t) () mat
  (%mat 0f0 0f0 0f0 0f0
        0f0 0f0 0f0 0f0
        0f0 0f0 0f0 0f0
        0f0 0f0 0f0 0f0))

(ss:defspecialization (mat :inline t) ((x real)) mat
  (%mat (float x 1f0) 0f0 0f0 0f0
        0f0 (float x 1f0) 0f0 0f0
        0f0 0f0 (float x 1f0) 0f0
        0f0 0f0 0f0 (float x 1f0)))

(ss:defspecialization (mat :inline t) ((mat m2:mat)) mat
  (%mat (aref mat 0) (aref mat 1) 0f0 0f0
        (aref mat 2) (aref mat 3) 0f0 0f0
        0f0 0f0 1f0 0f0
        0f0 0f0 0f0 1f0))

(ss:defspecialization (mat :inline t) ((mat m3:mat)) mat
  (%mat (aref mat 0) (aref mat 1) (aref mat 2) 0f0
        (aref mat 3) (aref mat 4) (aref mat 5) 0f0
        (aref mat 6) (aref mat 7) (aref mat 8) 0f0
        0f0 0f0 0f0 1f0))

(ss:defspecialization (mat :inline t) ((mat mat)) mat
  (%mat (aref mat 0) (aref mat 1) (aref mat 2) (aref mat 3)
        (aref mat 4) (aref mat 5) (aref mat 6) (aref mat 7)
        (aref mat 8) (aref mat 9) (aref mat 10) (aref mat 11)
        (aref mat 12) (aref mat 13) (aref mat 14) (aref mat 15)))

(ss:defspecialization (mat :inline t)
    ((vec1 v4:vec) (vec2 v4:vec) (vec3 v4:vec) (vec4 v4:vec))
    mat
  (%mat (aref vec1 0) (aref vec1 1) (aref vec1 2) (aref vec1 3)
        (aref vec2 0) (aref vec2 1) (aref vec2 2) (aref vec2 3)
        (aref vec3 0) (aref vec3 1) (aref vec3 2) (aref vec3 3)
        (aref vec4 0) (aref vec4 1) (aref vec4 2) (aref vec4 3)))

(ss:defspecialization (mat :inline t) ((a real) (b real) (c real) (d real)
                                       (e real) (f real) (g real) (h real)
                                       (i real) (j real) (k real) (l real)
                                       (m real) (n real) (o real) (p real))
    mat
  (%mat (float a 1f0) (float b 1f0) (float c 1f0) (float d 1f0)
        (float e 1f0) (float f 1f0) (float g 1f0) (float h 1f0)
        (float i 1f0) (float j 1f0) (float k 1f0) (float l 1f0)
        (float m 1f0) (float n 1f0) (float o 1f0) (float p 1f0)))

(ss:defspecialization (mat :inline t) ((mat (u:f32a 16))) mat
  (%mat (float (aref mat 0) 1f0)
        (float (aref mat 1) 1f0)
        (float (aref mat 2) 1f0)
        (float (aref mat 3) 1f0)
        (float (aref mat 4) 1f0)
        (float (aref mat 5) 1f0)
        (float (aref mat 6) 1f0)
        (float (aref mat 7) 1f0)
        (float (aref mat 8) 1f0)
        (float (aref mat 9) 1f0)
        (float (aref mat 10) 1f0)
        (float (aref mat 11) 1f0)
        (float (aref mat 12) 1f0)
        (float (aref mat 13) 1f0)
        (float (aref mat 14) 1f0)
        (float (aref mat 15) 1f0)))

;;; Constants

(u:define-constant +zero+
    (%mat 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0)
  :test #'equalp)

(u:define-constant +id+
    (%mat 1f0 0f0 0f0 0f0 0f0 1f0 0f0 0f0 0f0 0f0 1f0 0f0 0f0 0f0 0f0 1f0)
  :test #'equalp)
