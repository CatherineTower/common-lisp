(in-package :box.math.mat4)

;;; Structure

(deftype matrix () '(simple-array single-float (16)))

(defstruct (matrix (:type (vector single-float))
                   (:constructor %make (m00 m01 m02 m03
                                        m10 m11 m12 m13
                                        m20 m21 m22 m23
                                        m30 m31 m32 m33))
                   (:conc-name nil)
                   (:copier nil))
  (m00 0.0f0 :type single-float)
  (m10 0.0f0 :type single-float)
  (m20 0.0f0 :type single-float)
  (m30 0.0f0 :type single-float)
  (m01 0.0f0 :type single-float)
  (m11 0.0f0 :type single-float)
  (m21 0.0f0 :type single-float)
  (m31 0.0f0 :type single-float)
  (m02 0.0f0 :type single-float)
  (m12 0.0f0 :type single-float)
  (m22 0.0f0 :type single-float)
  (m32 0.0f0 :type single-float)
  (m03 0.0f0 :type single-float)
  (m13 0.0f0 :type single-float)
  (m23 0.0f0 :type single-float)
  (m33 0.0f0 :type single-float))

(defmacro with-components (((prefix matrix) &rest rest) &body body)
  `(with-accessors ((,prefix identity)
                    (,(%make-accessor-symbol prefix "00") m00)
                    (,(%make-accessor-symbol prefix "01") m01)
                    (,(%make-accessor-symbol prefix "02") m02)
                    (,(%make-accessor-symbol prefix "03") m03)
                    (,(%make-accessor-symbol prefix "10") m10)
                    (,(%make-accessor-symbol prefix "11") m11)
                    (,(%make-accessor-symbol prefix "12") m12)
                    (,(%make-accessor-symbol prefix "13") m13)
                    (,(%make-accessor-symbol prefix "20") m20)
                    (,(%make-accessor-symbol prefix "21") m21)
                    (,(%make-accessor-symbol prefix "22") m22)
                    (,(%make-accessor-symbol prefix "23") m23)
                    (,(%make-accessor-symbol prefix "30") m30)
                    (,(%make-accessor-symbol prefix "31") m31)
                    (,(%make-accessor-symbol prefix "32") m32)
                    (,(%make-accessor-symbol prefix "33") m33))
       ,matrix
     ,(if rest
          `(with-components ,rest ,@body)
          `(progn ,@body))))

(declaim (inline mref))
(defun* (mref -> single-float) ((matrix matrix) (row (integer 0 15)) (column (integer 0 15)))
  (aref matrix (+ row (cl:* column 4))))

(defun* (setf mref) ((value single-float) (matrix matrix) (row (integer 0 15))
                     (column (integer 0 15)))
  (:returns single-float)
  (setf (aref matrix (+ row (cl:* column 4))) value))

;;; Constants

(alexandria:define-constant +zero+
    (make-array 16 :element-type 'single-float
                   :initial-contents '(0.0f0 0.0f0 0.0f0 0.0f0
                                       0.0f0 0.0f0 0.0f0 0.0f0
                                       0.0f0 0.0f0 0.0f0 0.0f0
                                       0.0f0 0.0f0 0.0f0 0.0f0))
  :test #'equalp)

(alexandria:define-constant +id+
    (make-array 16 :element-type 'single-float
                   :initial-contents '(1.0f0 0.0f0 0.0f0 0.0f0
                                       0.0f0 1.0f0 0.0f0 0.0f0
                                       0.0f0 0.0f0 1.0f0 0.0f0
                                       0.0f0 0.0f0 0.0f0 1.0f0))
  :test #'equalp)

;;; Operations

(declaim (inline make))
(defun* (make -> matrix) ((m00 real) (m01 real) (m02 real) (m03 real) (m10 real) (m11 real)
                          (m12 real) (m13 real) (m20 real) (m21 real) (m22 real) (m23 real)
                          (m30 real) (m31 real) (m32 real) (m33 real))
  (%make (float m00 1.0f0) (float m01 1.0f0) (float m02 1.0f0) (float m03 1.0f0) (float m10 1.0f0)
         (float m11 1.0f0) (float m12 1.0f0) (float m13 1.0f0) (float m20 1.0f0) (float m21 1.0f0)
         (float m22 1.0f0) (float m23 1.0f0) (float m30 1.0f0) (float m31 1.0f0) (float m32 1.0f0)
         (float m33 1.0f0)))

(declaim (inline zero!))
(defun* (zero! -> matrix) ((matrix matrix))
  (with-components ((m matrix))
    (psetf m00 0.0f0 m01 0.0f0 m02 0.0f0 m03 0.0f0
           m10 0.0f0 m11 0.0f0 m12 0.0f0 m13 0.0f0
           m20 0.0f0 m21 0.0f0 m22 0.0f0 m23 0.0f0
           m30 0.0f0 m31 0.0f0 m32 0.0f0 m33 0.0f0))
  matrix)

(declaim (inline zero))
(defun* (zero -> matrix) ()
  (%make 0.0f0 0.0f0 0.0f0 0.0f0
         0.0f0 0.0f0 0.0f0 0.0f0
         0.0f0 0.0f0 0.0f0 0.0f0
         0.0f0 0.0f0 0.0f0 0.0f0))

(declaim (inline id!))
(defun* (id! -> matrix) ((matrix matrix))
  (with-components ((m matrix))
    (psetf m00 1.0f0 m01 0.0f0 m02 0.0f0 m03 0.0f0
           m10 0.0f0 m11 1.0f0 m12 0.0f0 m13 0.0f0
           m20 0.0f0 m21 0.0f0 m22 1.0f0 m23 0.0f0
           m30 0.0f0 m31 0.0f0 m32 0.0f0 m33 1.0f0))
  matrix)

(declaim (inline id))
(defun* (id -> matrix) ()
  (%make 1.0f0 0.0f0 0.0f0 0.0f0
         0.0f0 1.0f0 0.0f0 0.0f0
         0.0f0 0.0f0 1.0f0 0.0f0
         0.0f0 0.0f0 0.0f0 1.0f0))

(declaim (inline =))
(defun* (= -> boolean) ((matrix1 matrix) (matrix2 matrix))
  (with-components ((a matrix1) (b matrix2))
    (and (cl:= a00 b00) (cl:= a01 b01) (cl:= a02 b02) (cl:= a03 b03)
         (cl:= a10 b10) (cl:= a11 b11) (cl:= a12 b12) (cl:= a13 b13)
         (cl:= a20 b20) (cl:= a21 b21) (cl:= a22 b22) (cl:= a23 b23)
         (cl:= a30 b30) (cl:= a31 b31) (cl:= a32 b32) (cl:= a33 b33))))

(declaim (inline ~))
(defun* (~ -> boolean) ((matrix1 matrix) (matrix2 matrix) &key
                        ((tolerance single-float) +epsilon+))
  (with-components ((a matrix1) (b matrix2))
    (and (%~ a00 b00 tolerance)
         (%~ a01 b01 tolerance)
         (%~ a02 b02 tolerance)
         (%~ a03 b03 tolerance)
         (%~ a10 b10 tolerance)
         (%~ a11 b11 tolerance)
         (%~ a12 b12 tolerance)
         (%~ a13 b13 tolerance)
         (%~ a20 b20 tolerance)
         (%~ a21 b21 tolerance)
         (%~ a22 b22 tolerance)
         (%~ a23 b23 tolerance)
         (%~ a30 b30 tolerance)
         (%~ a31 b31 tolerance)
         (%~ a32 b32 tolerance)
         (%~ a33 b33 tolerance))))

(declaim (inline copy!))
(defun* (copy! -> matrix) ((out matrix) (matrix matrix))
  (with-components ((o out) (m matrix))
    (psetf o00 m00 o01 m01 o02 m02 o03 m03
           o10 m10 o11 m11 o12 m12 o13 m13
           o20 m20 o21 m21 o22 m22 o23 m23
           o30 m30 o31 m31 o32 m32 o33 m33))
  out)

(declaim (inline copy))
(defun* (copy -> matrix) ((matrix matrix))
  (copy! (zero) matrix))

(defun* (clamp! -> matrix) ((out matrix) (matrix matrix) &key
                            ((min single-float) most-negative-single-float)
                            ((max single-float) most-positive-single-float))
  (with-components ((o out) (m matrix))
    (psetf o00 (alexandria:clamp m00 min max)
           o01 (alexandria:clamp m01 min max)
           o02 (alexandria:clamp m02 min max)
           o03 (alexandria:clamp m03 min max)
           o10 (alexandria:clamp m10 min max)
           o11 (alexandria:clamp m11 min max)
           o12 (alexandria:clamp m12 min max)
           o13 (alexandria:clamp m13 min max)
           o20 (alexandria:clamp m20 min max)
           o21 (alexandria:clamp m21 min max)
           o22 (alexandria:clamp m22 min max)
           o23 (alexandria:clamp m23 min max)
           o30 (alexandria:clamp m30 min max)
           o31 (alexandria:clamp m31 min max)
           o32 (alexandria:clamp m32 min max)
           o33 (alexandria:clamp m33 min max)))
  out)

(declaim (inline clamp))
(defun* (clamp -> matrix) ((matrix matrix) &key
                           ((min single-float) most-negative-single-float)
                           ((max single-float) most-positive-single-float))
  (clamp! (zero) matrix :min min :max max))

(declaim (inline *!))
(defun* (*! -> matrix) ((out matrix) (matrix1 matrix) (matrix2 matrix))
  (with-components ((o out) (a matrix1) (b matrix2))
    (psetf o00 (+ (cl:* a00 b00) (cl:* a01 b10) (cl:* a02 b20) (cl:* a03 b30))
           o10 (+ (cl:* a10 b00) (cl:* a11 b10) (cl:* a12 b20) (cl:* a13 b30))
           o20 (+ (cl:* a20 b00) (cl:* a21 b10) (cl:* a22 b20) (cl:* a23 b30))
           o30 (+ (cl:* a30 b00) (cl:* a31 b10) (cl:* a32 b20) (cl:* a33 b30))
           o01 (+ (cl:* a00 b01) (cl:* a01 b11) (cl:* a02 b21) (cl:* a03 b31))
           o11 (+ (cl:* a10 b01) (cl:* a11 b11) (cl:* a12 b21) (cl:* a13 b31))
           o21 (+ (cl:* a20 b01) (cl:* a21 b11) (cl:* a22 b21) (cl:* a23 b31))
           o31 (+ (cl:* a30 b01) (cl:* a31 b11) (cl:* a32 b21) (cl:* a33 b31))
           o02 (+ (cl:* a00 b02) (cl:* a01 b12) (cl:* a02 b22) (cl:* a03 b32))
           o12 (+ (cl:* a10 b02) (cl:* a11 b12) (cl:* a12 b22) (cl:* a13 b32))
           o22 (+ (cl:* a20 b02) (cl:* a21 b12) (cl:* a22 b22) (cl:* a23 b32))
           o32 (+ (cl:* a30 b02) (cl:* a31 b12) (cl:* a32 b22) (cl:* a33 b32))
           o03 (+ (cl:* a00 b03) (cl:* a01 b13) (cl:* a02 b23) (cl:* a03 b33))
           o13 (+ (cl:* a10 b03) (cl:* a11 b13) (cl:* a12 b23) (cl:* a13 b33))
           o23 (+ (cl:* a20 b03) (cl:* a21 b13) (cl:* a22 b23) (cl:* a23 b33))
           o33 (+ (cl:* a30 b03) (cl:* a31 b13) (cl:* a32 b23) (cl:* a33 b33))))
  out)

(declaim (inline *))
(defun* (* -> matrix) ((matrix1 matrix) (matrix2 matrix))
  (*! (zero) matrix1 matrix2))

(declaim (inline translation-to-vec3!))
(defun* (translation-to-vec3! -> v3:vec) ((out v3:vec) (matrix matrix))
  (v3:with-components ((o out))
    (with-components ((m matrix))
      (psetf ox m03 oy m13 oz m23)))
  out)

(declaim (inline translation-to-vec3))
(defun* (translation-to-vec3 -> v3:vec) ((matrix matrix))
  (translation-to-vec3! (v3:zero) matrix))

(declaim (inline translation-from-vec3!))
(defun* (translation-from-vec3! -> matrix) ((matrix matrix) (vec v3:vec))
  (with-components ((m matrix))
    (v3:with-components ((v vec))
      (psetf m03 vx m13 vy m23 vz)))
  matrix)

(declaim (inline translation-from-vec3))
(defun* (translation-from-vec3 -> matrix) ((matrix matrix) (vec v3:vec))
  (translation-from-vec3! (copy matrix) vec))

(declaim (inline translate!))
(defun* (translate! -> matrix) ((out matrix) (matrix matrix) (vec v3:vec))
  (*! out (translation-from-vec3 (id) vec) matrix))

(declaim (inline translate))
(defun* (translate -> matrix) ((matrix matrix) (vec v3:vec))
  (translate! (id) matrix vec))

(declaim (inline copy-rotation!))
(defun* (copy-rotation! -> matrix) ((out matrix) (matrix matrix))
  (with-components ((o out) (m matrix))
    (psetf o00 m00 o01 m01 o02 m02
           o10 m10 o11 m11 o12 m12
           o20 m20 o21 m21 o22 m22))
  out)

(declaim (inline copy-rotation))
(defun* (copy-rotation -> matrix) ((matrix matrix))
  (copy-rotation! (id) matrix))

(declaim (inline rotation-axis-to-vec3!))
(defun* (rotation-axis-to-vec3! -> v3:vec) ((out v3:vec) (matrix matrix) (axis keyword))
  (v3:with-components ((v out))
    (with-components ((m matrix))
      (ecase axis
        (:x (psetf vx m00 vy m10 vz m20))
        (:y (psetf vx m01 vy m11 vz m21))
        (:z (psetf vx m02 vy m12 vz m22)))))
  out)

(declaim (inline rotation-axis-to-vec3))
(defun* (rotation-axis-to-vec3 -> v3:vec) ((matrix matrix) (axis keyword))
  (rotation-axis-to-vec3! (v3:zero) matrix axis))

(declaim (inline rotation-axis-from-vec3!))
(defun* (rotation-axis-from-vec3! -> matrix) ((matrix matrix) (vec v3:vec) (axis keyword))
  (with-components ((m matrix))
    (v3:with-components ((v vec))
      (ecase axis
        (:x (psetf m00 vx m10 vy m20 vz))
        (:y (psetf m01 vx m11 vy m21 vz))
        (:z (psetf m02 vx m12 vy m22 vz)))))
  matrix)

(declaim (inline rotation-axis-from-vec3))
(defun* (rotation-axis-from-vec3 -> matrix) ((matrix matrix) (vec v3:vec) (axis keyword))
  (rotation-axis-from-vec3! (copy matrix) vec axis))

(defun* (rotate! -> matrix) ((out matrix) (matrix matrix) (vec v3:vec))
  (macrolet ((rotate-angle (angle s c &body body)
               `(when (> (abs ,angle) +epsilon+)
                  (let ((,s (sin ,angle))
                        (,c (cos ,angle)))
                    ,@body
                    (*! out out m)))))
    (with-components ((m (id)))
      (v3:with-components ((v vec))
        (copy! out matrix)
        (rotate-angle vz s c
                      (psetf m00 c m01 (- s)
                             m10 s m11 c))
        (rotate-angle vx s c
                      (psetf m00 1.0f0 m01 0.0f0 m02 0.0f0
                             m10 0.0f0 m11 c m12 (- s)
                             m20 0.0f0 m21 s m22 c))
        (rotate-angle vy s c
                      (psetf m00 c m01 0.0f0 m02 s
                             m10 0.0f0 m11 1.0f0 m12 0.0f0
                             m20 (- s) m21 0.0f0 m22 c)))))
  out)

(declaim (inline rotate))
(defun* (rotate -> matrix) ((matrix matrix) (vec v3:vec))
  (rotate! (id) matrix vec))

(declaim (inline scale-to-vec3!))
(defun* (scale-to-vec3! -> v3:vec) ((out v3:vec) (matrix matrix))
  (v3:with-components ((o out))
    (with-components ((m matrix))
      (psetf ox m00 oy m11 oz m22)))
  out)

(declaim (inline scale-to-vec3))
(defun* (scale-to-vec3 -> v3:vec) ((matrix matrix))
  (scale-to-vec3! (v3:zero) matrix))

(declaim (inline scale-from-vec3!))
(defun* (scale-from-vec3! -> matrix) ((matrix matrix) (vec v3:vec))
  (with-components ((m matrix))
    (v3:with-components ((v vec))
      (psetf m00 vx m11 vy m22 vz)))
  matrix)

(declaim (inline scale-from-vec3))
(defun* (scale-from-vec3 -> matrix) ((matrix matrix) (vec v3:vec))
  (scale-from-vec3! (copy matrix) vec))

(declaim (inline scale!))
(defun* (scale! -> matrix) ((out matrix) (matrix matrix) (vec v3:vec))
  (*! out (scale-from-vec3 (id) vec) matrix))

(declaim (inline scale))
(defun* (scale -> matrix) ((matrix matrix) (vec v3:vec))
  (scale! (id) matrix vec))

(declaim (inline *v4!))
(defun* (*v4! -> v4:vec) ((out v4:vec) (matrix matrix) (vec v4:vec))
  (v4:with-components ((v vec) (o out))
    (with-components ((m matrix))
      (psetf ox (+ (cl:* m00 vx) (cl:* m01 vy) (cl:* m02 vz) (cl:* m03 vw))
             oy (+ (cl:* m10 vx) (cl:* m11 vy) (cl:* m12 vz) (cl:* m13 vw))
             oz (+ (cl:* m20 vx) (cl:* m21 vy) (cl:* m22 vz) (cl:* m23 vw))
             ow (+ (cl:* m30 vx) (cl:* m31 vy) (cl:* m32 vz) (cl:* m33 vw)))))
  out)

(declaim (inline *v4))
(defun* (*v4 -> v4:vec) ((matrix matrix) (vec v4:vec))
  (*v4! (v4:zero) matrix vec))

(declaim (inline transpose!))
(defun* (transpose! -> matrix) ((out matrix) (matrix matrix))
  (with-components ((o (copy! out matrix)))
    (rotatef o01 o10)
    (rotatef o02 o20)
    (rotatef o03 o30)
    (rotatef o12 o21)
    (rotatef o13 o31)
    (rotatef o23 o32))
  out)

(declaim (inline transpose))
(defun* (transpose -> matrix) ((matrix matrix))
  (transpose! (id) matrix))

(defun* (orthogonalp -> boolean) ((matrix matrix))
  (~ (* matrix (transpose matrix)) +id+))

(defun* (orthonormalize! -> matrix) ((out matrix) (matrix matrix))
  (let* ((x (rotation-axis-to-vec3 matrix :x))
         (y (rotation-axis-to-vec3 matrix :y))
         (z (rotation-axis-to-vec3 matrix :z)))
    (v3:normalize! x x)
    (v3:normalize! y (v3:- y (v3:scale x (v3:dot y x))))
    (v3:cross! z x y)
    (rotation-axis-from-vec3! out x :x)
    (rotation-axis-from-vec3! out y :y)
    (rotation-axis-from-vec3! out z :z))
  out)

(declaim (inline orthonormalize))
(defun* (orthonormalize -> matrix) ((matrix matrix))
  (orthonormalize! (id) matrix))

(declaim (inline trace))
(defun* (trace -> single-float) ((matrix matrix))
  (with-components ((m matrix))
    (+ m00 m11 m22 m33)))

(declaim (inline diagonalp))
(defun* (diagonalp -> boolean) ((matrix matrix))
  (with-components ((m matrix))
    (and (zerop m10)
         (zerop m20)
         (zerop m30)
         (zerop m01)
         (zerop m21)
         (zerop m31)
         (zerop m02)
         (zerop m12)
         (zerop m32)
         (zerop m03)
         (zerop m13)
         (zerop m23))))

(declaim (inline main-diagonal!))
(defun* (main-diagonal! -> v4:vec) ((out v4:vec) (matrix matrix))
  (with-components ((m matrix))
    (v4:with-components ((v out))
      (setf vx m00 vy m11 vz m22 vw m33)))
  out)

(declaim (inline main-diagonal))
(defun* (main-diagonal -> v4:vec) ((matrix matrix))
  (main-diagonal! (v4:zero) matrix))

(declaim (inline anti-diagonal!))
(defun* (anti-diagonal! -> v4:vec) ((out v4:vec) (matrix matrix))
  (with-components ((m matrix))
    (v4:with-components ((v out))
      (setf vx m03 vy m12 vz m21 vw m30)))
  out)

(declaim (inline anti-diagonal))
(defun* (anti-diagonal -> v4:vec) ((matrix matrix))
  (anti-diagonal! (v4:zero) matrix))

(declaim (inline determinant))
(defun* (determinant -> single-float) ((matrix matrix))
  (with-components ((m matrix))
    (- (+ (cl:* m00 m11 m22 m33) (cl:* m00 m12 m23 m31) (cl:* m00 m13 m21 m32)
          (cl:* m01 m10 m23 m32) (cl:* m01 m12 m20 m33) (cl:* m01 m13 m22 m30)
          (cl:* m02 m10 m21 m33) (cl:* m02 m11 m23 m30) (cl:* m02 m13 m20 m31)
          (cl:* m03 m10 m22 m31) (cl:* m03 m11 m20 m32) (cl:* m03 m12 m21 m30))
       (cl:* m00 m11 m23 m32) (cl:* m00 m12 m21 m33) (cl:* m00 m13 m22 m31)
       (cl:* m01 m10 m22 m33) (cl:* m01 m12 m23 m30) (cl:* m01 m13 m20 m32)
       (cl:* m02 m10 m23 m31) (cl:* m02 m11 m20 m33) (cl:* m02 m13 m21 m30)
       (cl:* m03 m10 m21 m32) (cl:* m03 m11 m22 m30) (cl:* m03 m12 m20 m31))))

(declaim (inline invert-orthogonal!))
(defun* (invert-orthogonal! -> matrix) ((out matrix) (matrix matrix))
  (copy! out matrix)
  (with-components ((o out))
    (rotatef o10 o01)
    (rotatef o20 o02)
    (rotatef o21 o12)
    (psetf o03 (+ (cl:* o00 (- o03)) (cl:* o01 (- o13)) (cl:* o02 (- o23)))
           o13 (+ (cl:* o10 (- o03)) (cl:* o11 (- o13)) (cl:* o12 (- o23)))
           o23 (+ (cl:* o20 (- o03)) (cl:* o21 (- o13)) (cl:* o22 (- o23)))))
  out)

(declaim (inline invert-orthogonal))
(defun* (invert-orthogonal -> matrix) ((matrix matrix))
  (invert-orthogonal! (id) matrix))

(defun* (invert! -> matrix) ((out matrix) (matrix matrix))
  (let ((determinant (determinant matrix)))
    (when (< (abs determinant) +epsilon+)
      (error "Cannot invert a matrix with a determinant of zero."))
    (with-components ((o out) (m matrix))
      (psetf o00 (/ (- (+ (cl:* m11 m22 m33) (cl:* m12 m23 m31) (cl:* m13 m21 m32))
                       (cl:* m11 m23 m32) (cl:* m12 m21 m33) (cl:* m13 m22 m31))
                    determinant)
             o01 (/ (- (+ (cl:* m01 m23 m32) (cl:* m02 m21 m33) (cl:* m03 m22 m31))
                       (cl:* m01 m22 m33) (cl:* m02 m23 m31) (cl:* m03 m21 m32))
                    determinant)
             o02 (/ (- (+ (cl:* m01 m12 m33) (cl:* m02 m13 m31) (cl:* m03 m11 m32))
                       (cl:* m01 m13 m32) (cl:* m02 m11 m33) (cl:* m03 m12 m31))
                    determinant)
             o03 (/ (- (+ (cl:* m01 m13 m22) (cl:* m02 m11 m23) (cl:* m03 m12 m21))
                       (cl:* m01 m12 m23) (cl:* m02 m13 m21) (cl:* m03 m11 m22))
                    determinant)
             o10 (/ (- (+ (cl:* m10 m23 m32) (cl:* m12 m20 m33) (cl:* m13 m22 m30))
                       (cl:* m10 m22 m33) (cl:* m12 m23 m30) (cl:* m13 m20 m32))
                    determinant)
             o11 (/ (- (+ (cl:* m00 m22 m33) (cl:* m02 m23 m30) (cl:* m03 m20 m32))
                       (cl:* m00 m23 m32) (cl:* m02 m20 m33) (cl:* m03 m22 m30))
                    determinant)
             o12 (/ (- (+ (cl:* m00 m13 m32) (cl:* m02 m10 m33) (cl:* m03 m12 m30))
                       (cl:* m00 m12 m33) (cl:* m02 m13 m30) (cl:* m03 m10 m32))
                    determinant)
             o13 (/ (- (+ (cl:* m00 m12 m23) (cl:* m02 m13 m20) (cl:* m03 m10 m22))
                       (cl:* m00 m13 m22) (cl:* m02 m10 m23) (cl:* m03 m12 m20))
                    determinant)
             o20 (/ (- (+ (cl:* m10 m21 m33) (cl:* m11 m23 m30) (cl:* m13 m20 m31))
                       (cl:* m10 m23 m31) (cl:* m11 m20 m33) (cl:* m13 m21 m30))
                    determinant)
             o21 (/ (- (+ (cl:* m00 m23 m31) (cl:* m01 m20 m33) (cl:* m03 m21 m30))
                       (cl:* m00 m21 m33) (cl:* m01 m23 m30) (cl:* m03 m20 m31))
                    determinant)
             o22 (/ (- (+ (cl:* m00 m11 m33) (cl:* m01 m13 m30) (cl:* m03 m10 m31))
                       (cl:* m00 m13 m31) (cl:* m01 m10 m33) (cl:* m03 m11 m30))
                    determinant)
             o23 (/ (- (+ (cl:* m00 m13 m21) (cl:* m01 m10 m23) (cl:* m03 m11 m20))
                       (cl:* m00 m11 m23) (cl:* m01 m13 m20) (cl:* m03 m10 m21))
                    determinant)
             o30 (/ (- (+ (cl:* m10 m22 m31) (cl:* m11 m20 m32) (cl:* m12 m21 m30))
                       (cl:* m10 m21 m32) (cl:* m11 m22 m30) (cl:* m12 m20 m31))
                    determinant)
             o31 (/ (- (+ (cl:* m00 m21 m32) (cl:* m01 m22 m30) (cl:* m02 m20 m31))
                       (cl:* m00 m22 m31) (cl:* m01 m20 m32) (cl:* m02 m21 m30))
                    determinant)
             o32 (/ (- (+ (cl:* m00 m12 m31) (cl:* m01 m10 m32) (cl:* m02 m11 m30))
                       (cl:* m00 m11 m32) (cl:* m01 m12 m30) (cl:* m02 m10 m31))
                    determinant)
             o33 (/ (- (+ (cl:* m00 m11 m22) (cl:* m01 m12 m20) (cl:* m02 m10 m21))
                       (cl:* m00 m12 m21) (cl:* m01 m10 m22) (cl:* m02 m11 m20))
                    determinant))))
  out)

(declaim (inline invert))
(defun* (invert -> matrix) ((matrix matrix))
  (invert! (id) matrix))

(defun* (view! -> matrix) ((out matrix) (eye v3:vec) (target v3:vec) (up v3:vec))
  (let ((f (v3:zero))
        (s (v3:zero))
        (u (v3:zero))
        (inv-eye (v3:zero))
        (translation (id)))
    (with-components ((o (id! out)))
      (v3:with-components ((f (v3:normalize! f (v3:-! f target eye)))
                           (s (v3:normalize! s (v3:cross! s f up)))
                           (u (v3:cross! u s f)))
        (psetf o00 sx o10 ux o20 (- fx)
               o01 sy o11 uy o12 (- fy)
               o02 sz o12 uz o22 (- fz))
        (translation-from-vec3! translation (v3:negate! inv-eye eye))
        (*! out out translation))))
  out)

(declaim (inline view))
(defun* (view -> matrix) ((eye v3:vec) (target v3:vec) (up v3:vec))
  (view! (id) eye target up))

(defun* (orthographic-projection! -> matrix) ((out matrix) (left real) (right real) (bottom real)
                                              (top real) (near real) (far real))
  (let ((right-left (float (- right left) 1.0f0))
        (top-bottom (float (- top bottom) 1.0f0))
        (far-near (float (- far near) 1.0f0)))
    (with-components ((m (id! out)))
      (psetf m00 (/ 2.0f0 right-left)
             m03 (- (/ (+ right left) right-left))
             m11 (/ 2.0f0 top-bottom)
             m13 (- (/ (+ top bottom) top-bottom))
             m22 (/ -2.0f0 far-near)
             m23 (- (/ (+ far near) far-near))))
    out))

(declaim (inline orthographic))
(defun* (orthographic-projection -> matrix) ((left real) (right real) (bottom real) (top real)
                                             (near real) (far real))
  (orthographic-projection! (id) left right bottom top near far))

(defun* (perspective-projection! -> matrix) ((out matrix) (fov real) (aspect real) (near real)
                                             (far real))
  (let ((f (float (/ (tan (/ fov 2))) 1.0f0))
        (z (float (- near far) 1.0f0)))
    (with-components ((m (zero! out)))
      (psetf m00 (/ f aspect)
             m11 f
             m22 (/ (+ near far) z)
             m23 (/ (cl:* 2 near far) z)
             m32 -1.0f0)))
  out)

(declaim (inline perspective-projection))
(defun* (perspective-projection -> matrix) ((fov real) (aspect real) (near real) (far real))
  (perspective-projection! (id) fov aspect near far))
