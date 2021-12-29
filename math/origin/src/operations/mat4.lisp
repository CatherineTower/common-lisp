(in-package #:mfiano.math.origin.mat4)

(u:fn-> = (mat mat &key (:rel u:f32) (:abs u:f32)) boolean)
(declaim (inline =))
(defun = (mat1 mat2 &key (rel 1e-7) (abs rel))
  (com:cwcmp 16 (mat1 mat2) (com:= mat1 mat2 rel abs)))

(u:fn-> zero! (mat) mat)
(declaim (inline zero!))
(defun zero! (mat)
  (declare (optimize speed))
  (com:cwset 16 mat nil 0.0)
  mat)

(u:fn-> zero () mat)
(declaim (inline zero))
(defun zero ()
  (declare (optimize speed))
  (%mat 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0))

(u:fn-> zero-p (mat) boolean)
(declaim (inline zero-p))
(defun zero-p (mat)
  (declare (optimize speed))
  (= mat +zero+))

(u:fn-> id! (mat) mat)
(declaim (inline id!))
(defun id! (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (psetf m00 1.0 m01 0.0 m02 0.0 m03 0.0
           m10 0.0 m11 1.0 m12 0.0 m13 0.0
           m20 0.0 m21 0.0 m22 1.0 m23 0.0
           m30 0.0 m31 0.0 m32 0.0 m33 1.0))
  mat)

(u:fn-> id () mat)
(declaim (inline id))
(defun id ()
  (declare (optimize speed))
  (id! (zero)))

(u:fn-> id-p (mat) boolean)
(declaim (inline id-p))
(defun id-p (mat)
  (declare (optimize speed))
  (= mat +id+))

(u:fn-> random! (mat u:f32 u:f32) mat)
(declaim (inline random!))
(defun random! (out min max)
  (declare (optimize speed))
  (let ((diff (cl:- max min)))
    (com:cwset 16 out nil (cl:+ min (cl:random diff))))
  out)

(u:fn-> random (u:f32 u:f32) mat)
(declaim (inline random))
(defun random (min max)
  (declare (optimize speed))
  (random! (zero) min max))

(u:fn-> copy! (mat mat) mat)
(declaim (inline copy!))
(defun copy! (out mat)
  (declare (optimize speed))
  (com:cwset 16 out mat mat)
  out)

(u:fn-> copy (mat) mat)
(declaim (inline copy))
(defun copy (mat)
  (declare (optimize speed))
  (copy! (zero) mat))

(u:fn-> clamp-range! (mat mat u:f32 u:f32) mat)
(declaim (inline clamp-range!))
(defun clamp-range! (out mat min max)
  (declare (optimize speed))
  (com:cwset 16 out mat (u:clamp mat min max))
  out)

(u:fn-> clamp-range (mat u:f32 u:f32) mat)
(declaim (inline clamp-range))
(defun clamp-range (mat min max)
  (declare (optimize speed))
  (clamp-range! (zero) mat min max))

(u:fn-> +! (mat mat mat) mat)
(declaim (inline +!))
(defun +! (out mat1 mat2)
  (declare (optimize speed))
  (com:cwset 16 out (mat1 mat2) (cl:+ mat1 mat2))
  out)

(u:fn-> + (mat mat) mat)
(declaim (inline +))
(defun + (mat1 mat2)
  (declare (optimize speed))
  (+! (zero) mat1 mat2))

(u:fn-> -! (mat mat mat) mat)
(declaim (inline -!))
(defun -! (out mat1 mat2)
  (declare (optimize speed))
  (com:cwset 16 out (mat1 mat2) (cl:- mat1 mat2))
  out)

(u:fn-> - (mat mat) mat)
(declaim (inline -))
(defun - (mat1 mat2)
  (declare (optimize speed))
  (-! (zero) mat1 mat2))

(u:fn-> *! (mat mat mat) mat)
(declaim (inline *!))
(defun *! (out mat1 mat2)
  (declare (optimize speed))
  (with-components ((o out) (a mat1) (b mat2))
    (psetf o00 (cl:+ (cl:* a00 b00) (cl:* a01 b10) (cl:* a02 b20) (cl:* a03 b30))
           o10 (cl:+ (cl:* a10 b00) (cl:* a11 b10) (cl:* a12 b20) (cl:* a13 b30))
           o20 (cl:+ (cl:* a20 b00) (cl:* a21 b10) (cl:* a22 b20) (cl:* a23 b30))
           o30 (cl:+ (cl:* a30 b00) (cl:* a31 b10) (cl:* a32 b20) (cl:* a33 b30))
           o01 (cl:+ (cl:* a00 b01) (cl:* a01 b11) (cl:* a02 b21) (cl:* a03 b31))
           o11 (cl:+ (cl:* a10 b01) (cl:* a11 b11) (cl:* a12 b21) (cl:* a13 b31))
           o21 (cl:+ (cl:* a20 b01) (cl:* a21 b11) (cl:* a22 b21) (cl:* a23 b31))
           o31 (cl:+ (cl:* a30 b01) (cl:* a31 b11) (cl:* a32 b21) (cl:* a33 b31))
           o02 (cl:+ (cl:* a00 b02) (cl:* a01 b12) (cl:* a02 b22) (cl:* a03 b32))
           o12 (cl:+ (cl:* a10 b02) (cl:* a11 b12) (cl:* a12 b22) (cl:* a13 b32))
           o22 (cl:+ (cl:* a20 b02) (cl:* a21 b12) (cl:* a22 b22) (cl:* a23 b32))
           o32 (cl:+ (cl:* a30 b02) (cl:* a31 b12) (cl:* a32 b22) (cl:* a33 b32))
           o03 (cl:+ (cl:* a00 b03) (cl:* a01 b13) (cl:* a02 b23) (cl:* a03 b33))
           o13 (cl:+ (cl:* a10 b03) (cl:* a11 b13) (cl:* a12 b23) (cl:* a13 b33))
           o23 (cl:+ (cl:* a20 b03) (cl:* a21 b13) (cl:* a22 b23) (cl:* a23 b33))
           o33 (cl:+ (cl:* a30 b03) (cl:* a31 b13) (cl:* a32 b23) (cl:* a33 b33))))
  out)

(u:fn-> * (mat mat) mat)
(declaim (inline *))
(defun * (mat1 mat2)
  (declare (optimize speed))
  (*! (zero) mat1 mat2))

(u:fn-> copy-rotation! (mat mat) mat)
(declaim (inline copy-rotation!))
(defun copy-rotation! (out mat)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (psetf o00 m00 o01 m01 o02 m02
           o10 m10 o11 m11 o12 m12
           o20 m20 o21 m21 o22 m22))
  out)

(u:fn-> copy-rotation (mat) mat)
(declaim (inline copy-rotation))
(defun copy-rotation (mat)
  (declare (optimize speed))
  (copy-rotation! (id) mat))

(u:fn-> rotation-to-mat3! (m3:mat mat) m3:mat)
(declaim (inline rotation-to-mat3!))
(defun rotation-to-mat3! (out mat)
  (declare (optimize speed))
  (m3:with-components ((o out))
    (with-components ((m mat))
      (psetf o00 m00 o01 m01 o02 m02
             o10 m10 o11 m11 o12 m12
             o20 m20 o21 m21 o22 m22)))
  out)

(u:fn-> rotation-to-mat3 (mat) m3:mat)
(declaim (inline rotation-to-mat3))
(defun rotation-to-mat3 (mat)
  (declare (optimize speed))
  (rotation-to-mat3! (m3:id) mat))

(u:fn-> rotation-axis-to-vec3! (v3:vec mat keyword) v3:vec)
(declaim (inline rotation-axis-to-vec3!))
(defun rotation-axis-to-vec3! (out mat axis)
  (declare (optimize speed))
  (v3:with-components ((v out))
    (with-components ((m mat))
      (ecase axis
        (:x (psetf vx m00 vy m10 vz m20))
        (:y (psetf vx m01 vy m11 vz m21))
        (:z (psetf vx m02 vy m12 vz m22)))))
  out)

(u:fn-> rotation-axis-to-vec3 (mat keyword) v3:vec)
(declaim (inline rotation-axis-to-vec3))
(defun rotation-axis-to-vec3 (mat axis)
  (declare (optimize speed))
  (rotation-axis-to-vec3! (v3:zero) mat axis))

(u:fn-> rotation-axis-from-vec3! (mat v3:vec keyword) mat)
(declaim (inline rotation-axis-from-vec3!))
(defun rotation-axis-from-vec3! (out vec axis)
  (declare (optimize speed))
  (with-components ((o out))
    (v3:with-components ((v vec))
      (ecase axis
        (:x (psetf o00 vx o10 vy o20 vz))
        (:y (psetf o01 vx o11 vy o21 vz))
        (:z (psetf o02 vx o12 vy o22 vz)))))
  out)

(u:fn-> rotation-axis-from-vec3 (mat v3:vec keyword) mat)
(declaim (inline rotation-axis-from-vec3))
(defun rotation-axis-from-vec3 (mat vec axis)
  (declare (optimize speed))
  (rotation-axis-from-vec3! (copy mat) vec axis))

(u:fn-> rotation-x-from-angle! (mat u:f32) mat)
(declaim (inline rotation-x-from-angle!))
(defun rotation-x-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 1.0
             o10 0.0
             o20 0.0
             o30 0.0
             o01 0.0
             o11 c
             o21 s
             o31 0.0
             o02 0.0
             o12 (cl:- s)
             o22 c
             o32 0.0
             o03 0.0
             o13 0.0
             o23 0.0
             o33 1.0))
    out))

(u:fn-> rotation-x-from-angle (u:f32) mat)
(declaim (inline rotation-x-from-angle))
(defun rotation-x-from-angle (angle)
  (declare (optimize speed))
  (rotation-x-from-angle! (mat) angle))

(u:fn-> rotation-y-from-angle! (mat u:f32) mat)
(declaim (inline rotation-y-from-angle!))
(defun rotation-y-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 c
             o10 0.0
             o20 (cl:- s)
             o30 0.0
             o01 0.0
             o11 1.0
             o21 0.0
             o31 0.0
             o02 s
             o12 0.0
             o22 c
             o32 0.0
             o03 0.0
             o13 0.0
             o23 0.0
             o33 1.0))
    out))

(u:fn-> rotation-y-from-angle (u:f32) mat)
(declaim (inline rotation-y-from-angle))
(defun rotation-y-from-angle (angle)
  (declare (optimize speed))
  (rotation-y-from-angle! (mat) angle))

(u:fn-> rotation-z-from-angle! (mat u:f32) mat)
(declaim (inline rotation-z-from-angle!))
(defun rotation-z-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 c
             o10 s
             o20 0.0
             o30 0.0
             o01 (cl:- s)
             o11 c
             o21 0.0
             o31 0.0
             o02 0.0
             o12 0.0
             o22 1.0
             o32 0.0
             o03 0.0
             o13 0.0
             o23 0.0
             o33 1.0))
    out))

(u:fn-> rotation-z-from-angle (u:f32) mat)
(declaim (inline rotation-z-from-angle))
(defun rotation-z-from-angle (angle)
  (declare (optimize speed))
  (rotation-z-from-angle! (mat) angle))

(u:fn-> normalize-rotation! (mat mat) mat)
(declaim (inline normalize-rotation!))
(defun normalize-rotation! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (let ((x (v3::%vec m00 m10 m20))
          (y (v3::%vec m01 m11 m21))
          (z (v3::%vec m02 m12 m22)))
      (declare (dynamic-extent x y z))
      (v3:normalize! x x)
      (v3:normalize! y y)
      (v3:normalize! z z)
      (rotation-axis-from-vec3! out x :x)
      (rotation-axis-from-vec3! out y :y)
      (rotation-axis-from-vec3! out z :z)))
  out)

(u:fn-> normalize-rotation (mat) mat)
(declaim (inline normalize-rotation))
(defun normalize-rotation (mat)
  (declare (optimize speed))
  (normalize-rotation! (copy mat) mat))

(u:fn-> get-column! (v4:vec mat (integer 0 3)) v4:vec)
(declaim (inline get-column!))
(defun get-column! (out mat index)
  (declare (optimize speed))
  (with-components ((m mat))
    (v4:with-components ((o out))
      (ecase index
        (0 (psetf ox m00 oy m10 oz m20 ow m30))
        (1 (psetf ox m01 oy m11 oz m21 ow m31))
        (2 (psetf ox m02 oy m12 oz m22 ow m32))
        (3 (psetf ox m03 oy m13 oz m23 ow m33)))))
  out)

(u:fn-> get-column (mat (integer 0 3)) v4:vec)
(declaim (inline get-column))
(defun get-column (mat index)
  (declare (optimize speed))
  (get-column! (v4:zero) mat index))

(u:fn-> set-column! (mat mat v4:vec (integer 0 3)) mat)
(declaim (inline set-column!))
(defun set-column! (out mat vec index)
  (declare (optimize speed))
  (with-components ((o out))
    (v4:with-components ((v vec))
      (copy! out mat)
      (ecase index
        (0 (psetf o00 vx o10 vy o20 vz o30 vw))
        (1 (psetf o01 vx o11 vy o21 vz o31 vw))
        (2 (psetf o02 vx o12 vy o22 vz o32 vw))
        (3 (psetf o03 vx o13 vy o23 vz o33 vw)))))
  out)

(u:fn-> set-column (mat v4:vec (integer 0 3)) mat)
(declaim (inline set-column))
(defun set-column (mat vec index)
  (declare (optimize speed))
  (set-column! (id) mat vec index))

(u:fn-> get-translation! (v3:vec mat) v3:vec)
(declaim (inline get-translation!))
(defun get-translation! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v3:with-components ((o out))
      (psetf ox m03 oy m13 oz m23)))
  out)

(u:fn-> get-translation (mat) v3:vec)
(declaim (inline get-translation))
(defun get-translation (mat)
  (declare (optimize speed))
  (get-translation! (v3:zero) mat))

(u:fn-> set-translation! (mat mat v3:vec) mat)
(declaim (inline set-translation!))
(defun set-translation! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v3:with-components ((v vec))
      (copy-rotation! out mat)
      (psetf o03 vx o13 vy o23 vz o33 m33)))
  out)

(u:fn-> set-translation (mat v3:vec) mat)
(declaim (inline set-translation))
(defun set-translation (mat vec)
  (declare (optimize speed))
  (set-translation! (copy mat) mat vec))

(u:fn-> translate! (mat mat v3:vec) mat)
(declaim (inline translate!))
(defun translate! (out mat vec)
  "Compute a translation matrix with identity rotation T from VEC, returning the matrix
multiplication of MAT * T."
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v3:with-components ((v vec))
      (psetf o00 m00
             o01 m01
             o02 m02
             o03 (cl:+ (cl:* m00 vx) (cl:* m01 vy) (cl:* m02 vz) m03)
             o10 m10
             o11 m11
             o12 m12
             o13 (cl:+ (cl:* m10 vx) (cl:* m11 vy) (cl:* m12 vz) m13)
             o20 m20
             o21 m21
             o22 m22
             o23 (cl:+ (cl:* m20 vx) (cl:* m21 vy) (cl:* m22 vz) m23)
             o30 m30
             o31 m31
             o32 m32
             o33 (cl:+ (cl:* m30 vx) (cl:* m31 vy) (cl:* m32 vz) m33))))
  out)

(u:fn-> translate (mat v3:vec) mat)
(declaim (inline translate))
(defun translate (mat vec)
  (declare (optimize speed))
  (translate! (id) mat vec))

(u:fn-> rotate! (mat mat v3:vec &key (:space keyword)) mat)
(defun rotate! (out mat vec &key (space :local))
  (declare (optimize speed))
  (v3:with-components ((v vec))
    (let ((x (rotation-x-from-angle vx))
          (y (rotation-y-from-angle vy))
          (z (rotation-z-from-angle vz)))
      (declare (dynamic-extent x y z))
      (copy! out mat)
      (ecase space
        (:local
         (*! out out x)
         (*! out out z)
         (*! out out y))
        (:world
         (*! out x out)
         (*! out z out)
         (*! out y out)))))
  out)

(u:fn-> rotate (mat v3:vec) mat)
(declaim (inline rotate))
(defun rotate (mat vec)
  (declare (optimize speed))
  (rotate! (id) mat vec))

(u:fn-> get-scale! (v3:vec mat) v3:vec)
(declaim (inline get-scale!))
(defun get-scale! (out mat)
  (declare (optimize speed))
  (v3:with-components ((o out))
    (psetf ox (v3:length (rotation-axis-to-vec3 mat :x))
           oy (v3:length (rotation-axis-to-vec3 mat :y))
           oz (v3:length (rotation-axis-to-vec3 mat :z))))
  out)

(u:fn-> get-scale (mat) v3:vec)
(declaim (inline get-scale))
(defun get-scale (mat)
  (declare (optimize speed))
  (get-scale! (v3:zero) mat))

(u:fn-> set-scale! (mat mat v3:vec) mat)
(declaim (inline set-scale!))
(defun set-scale! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out))
    (v3:with-components ((v vec))
      (copy! out mat)
      (psetf o00 vx o11 vy o22 vz)))
  out)

(u:fn-> set-scale (mat v3:vec) mat)
(declaim (inline set-scale))
(defun set-scale (mat vec)
  (declare (optimize speed))
  (set-scale! (copy mat) mat vec))

(u:fn-> scale! (mat mat v3:vec) mat)
(declaim (inline scale!))
(defun scale! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v3:with-components ((v vec))
      (psetf o00 (cl:* m00 vx)
             o01 (cl:* m01 vx)
             o02 (cl:* m02 vx)
             o03 (cl:* m03 vx)
             o10 (cl:* m10 vy)
             o11 (cl:* m11 vy)
             o12 (cl:* m12 vy)
             o13 (cl:* m13 vy)
             o20 (cl:* m20 vz)
             o21 (cl:* m21 vz)
             o22 (cl:* m22 vz)
             o23 (cl:* m23 vz)
             o30 m30
             o31 m31
             o32 m32
             o33 m33)))
  out)

(u:fn-> scale (mat v3:vec) mat)
(declaim (inline scale))
(defun scale (mat vec)
  (declare (optimize speed))
  (scale! (id) mat vec))

(u:fn-> *v4! (v4:vec mat v4:vec) v4:vec)
(declaim (inline *v4!))
(defun *v4! (out mat vec)
  (declare (optimize speed))
  (v4:with-components ((v vec) (o out))
    (with-components ((m mat))
      (psetf ox (cl:+ (cl:* m00 vx) (cl:* m01 vy) (cl:* m02 vz) (cl:* m03 vw))
             oy (cl:+ (cl:* m10 vx) (cl:* m11 vy) (cl:* m12 vz) (cl:* m13 vw))
             oz (cl:+ (cl:* m20 vx) (cl:* m21 vy) (cl:* m22 vz) (cl:* m23 vw))
             ow (cl:+ (cl:* m30 vx) (cl:* m31 vy) (cl:* m32 vz) (cl:* m33 vw)))))
  out)

(u:fn-> *v4 (mat v4:vec) v4:vec)
(declaim (inline *v4))
(defun *v4 (mat vec)
  (declare (optimize speed))
  (*v4! (v4:zero) mat vec))

(u:fn-> transpose! (mat mat) mat)
(declaim (inline transpose!))
(defun transpose! (out mat)
  (declare (optimize speed))
  (with-components ((o (copy! out mat)))
    (rotatef o01 o10)
    (rotatef o02 o20)
    (rotatef o03 o30)
    (rotatef o12 o21)
    (rotatef o13 o31)
    (rotatef o23 o32))
  out)

(u:fn-> transpose (mat) mat)
(declaim (inline transpose))
(defun transpose (mat)
  (declare (optimize speed))
  (transpose! (id) mat))

(u:fn-> orthogonal-p (mat) boolean)
(declaim (inline orthogonal-p))
(defun orthogonal-p (mat)
  (declare (optimize speed))
  (= (* mat (transpose mat)) +id+))

(u:fn-> orthonormalize! (mat mat) mat)
(defun orthonormalize! (out mat)
  (declare (optimize speed))
  (let* ((x (rotation-axis-to-vec3 mat :x))
         (y (rotation-axis-to-vec3 mat :y))
         (z (rotation-axis-to-vec3 mat :z)))
    (v3:normalize! x x)
    (v3:normalize! y (v3:- y (v3:scale x (v3:dot y x))))
    (v3:cross! z x y)
    (rotation-axis-from-vec3! out x :x)
    (rotation-axis-from-vec3! out y :y)
    (rotation-axis-from-vec3! out z :z))
  out)

(u:fn-> orthonormalize (mat) mat)
(declaim (inline orthonormalize))
(defun orthonormalize (mat)
  (declare (optimize speed))
  (orthonormalize! (id) mat))

(u:fn-> trace (mat) u:f32)
(declaim (inline trace))
(defun trace (mat)
  (with-components ((m mat))
    (cl:+ m00 m11 m22 m33)))

(u:fn-> diagonal-p (mat) boolean)
(declaim (inline diagonal-p))
(defun diagonal-p (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (cl:= 0.0 m10 m20 m30 m01 m21 m31 m02 m12 m32 m03 m13 m23)))

(u:fn-> main-diagonal! (v4:vec mat) v4:vec)
(declaim (inline main-diagonal!))
(defun main-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v4:with-components ((v out))
      (psetf vx m00 vy m11 vz m22 vw m33)))
  out)

(u:fn-> main-diagonal (mat) v4:vec)
(declaim (inline main-diagonal))
(defun main-diagonal (mat)
  (declare (optimize speed))
  (main-diagonal! (v4:zero) mat))

(u:fn-> anti-diagonal! (v4:vec mat) v4:vec)
(declaim (inline anti-diagonal!))
(defun anti-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v4:with-components ((v out))
      (psetf vx m03 vy m12 vz m21 vw m30)))
  out)

(u:fn-> anti-diagonal (mat) v4:vec)
(declaim (inline anti-diagonal))
(defun anti-diagonal (mat)
  (declare (optimize speed))
  (anti-diagonal! (v4:zero) mat))

(u:fn-> determinant (mat) u:f32)
(declaim (inline determinant))
(defun determinant (mat)
  (with-components ((m mat))
    (cl:- (cl:+ (cl:* m00 m11 m22 m33) (cl:* m00 m12 m23 m31)
                (cl:* m00 m13 m21 m32) (cl:* m01 m10 m23 m32)
                (cl:* m01 m12 m20 m33) (cl:* m01 m13 m22 m30)
                (cl:* m02 m10 m21 m33) (cl:* m02 m11 m23 m30)
                (cl:* m02 m13 m20 m31) (cl:* m03 m10 m22 m31)
                (cl:* m03 m11 m20 m32) (cl:* m03 m12 m21 m30))
          (cl:* m00 m11 m23 m32) (cl:* m00 m12 m21 m33) (cl:* m00 m13 m22 m31)
          (cl:* m01 m10 m22 m33) (cl:* m01 m12 m23 m30) (cl:* m01 m13 m20 m32)
          (cl:* m02 m10 m23 m31) (cl:* m02 m11 m20 m33) (cl:* m02 m13 m21 m30)
          (cl:* m03 m10 m21 m32) (cl:* m03 m11 m22 m30) (cl:* m03 m12 m20 m31))))

(u:fn-> invert-orthogonal! (mat mat) mat)
(declaim (inline invert-orthogonal!))
(defun invert-orthogonal! (out mat)
  (declare (optimize speed))
  (copy! out mat)
  (with-components ((o out))
    (rotatef o10 o01)
    (rotatef o20 o02)
    (rotatef o21 o12)
    (psetf o03 (cl:+ (cl:* o00 (cl:- o03)) (cl:* o01 (cl:- o13)) (cl:* o02 (cl:- o23)))
           o13 (cl:+ (cl:* o10 (cl:- o03)) (cl:* o11 (cl:- o13)) (cl:* o12 (cl:- o23)))
           o23 (cl:+ (cl:* o20 (cl:- o03)) (cl:* o21 (cl:- o13)) (cl:* o22 (cl:- o23)))))
  out)

(u:fn-> invert-orthogonal (mat) mat)
(declaim (inline invert-orthogonal))
(defun invert-orthogonal (mat)
  (declare (optimize speed))
  (invert-orthogonal! (id) mat))

(u:fn-> invert! (mat mat) (values mat boolean))
(defun invert! (out mat)
  (let ((determinant (determinant mat)))
    (when (com:= determinant 0.0 1e-15 1e-15)
      (return-from invert! (values mat nil)))
    (with-components ((o out) (m mat))
      (psetf o00 (/ (cl:- (cl:+ (cl:* m11 m22 m33) (cl:* m12 m23 m31) (cl:* m13 m21 m32))
                          (cl:* m11 m23 m32) (cl:* m12 m21 m33) (cl:* m13 m22 m31))
                    determinant)
             o01 (/ (cl:- (cl:+ (cl:* m01 m23 m32) (cl:* m02 m21 m33) (cl:* m03 m22 m31))
                          (cl:* m01 m22 m33) (cl:* m02 m23 m31) (cl:* m03 m21 m32))
                    determinant)
             o02 (/ (cl:- (cl:+ (cl:* m01 m12 m33) (cl:* m02 m13 m31) (cl:* m03 m11 m32))
                          (cl:* m01 m13 m32) (cl:* m02 m11 m33) (cl:* m03 m12 m31))
                    determinant)
             o03 (/ (cl:- (cl:+ (cl:* m01 m13 m22) (cl:* m02 m11 m23) (cl:* m03 m12 m21))
                          (cl:* m01 m12 m23) (cl:* m02 m13 m21) (cl:* m03 m11 m22))
                    determinant)
             o10 (/ (cl:- (cl:+ (cl:* m10 m23 m32) (cl:* m12 m20 m33) (cl:* m13 m22 m30))
                          (cl:* m10 m22 m33) (cl:* m12 m23 m30) (cl:* m13 m20 m32))
                    determinant)
             o11 (/ (cl:- (cl:+ (cl:* m00 m22 m33) (cl:* m02 m23 m30) (cl:* m03 m20 m32))
                          (cl:* m00 m23 m32) (cl:* m02 m20 m33) (cl:* m03 m22 m30))
                    determinant)
             o12 (/ (cl:- (cl:+ (cl:* m00 m13 m32) (cl:* m02 m10 m33) (cl:* m03 m12 m30))
                          (cl:* m00 m12 m33) (cl:* m02 m13 m30) (cl:* m03 m10 m32))
                    determinant)
             o13 (/ (cl:- (cl:+ (cl:* m00 m12 m23) (cl:* m02 m13 m20) (cl:* m03 m10 m22))
                          (cl:* m00 m13 m22) (cl:* m02 m10 m23) (cl:* m03 m12 m20))
                    determinant)
             o20 (/ (cl:- (cl:+ (cl:* m10 m21 m33) (cl:* m11 m23 m30) (cl:* m13 m20 m31))
                          (cl:* m10 m23 m31) (cl:* m11 m20 m33) (cl:* m13 m21 m30))
                    determinant)
             o21 (/ (cl:- (cl:+ (cl:* m00 m23 m31) (cl:* m01 m20 m33) (cl:* m03 m21 m30))
                          (cl:* m00 m21 m33) (cl:* m01 m23 m30) (cl:* m03 m20 m31))
                    determinant)
             o22 (/ (cl:- (cl:+ (cl:* m00 m11 m33) (cl:* m01 m13 m30) (cl:* m03 m10 m31))
                          (cl:* m00 m13 m31) (cl:* m01 m10 m33) (cl:* m03 m11 m30))
                    determinant)
             o23 (/ (cl:- (cl:+ (cl:* m00 m13 m21) (cl:* m01 m10 m23) (cl:* m03 m11 m20))
                          (cl:* m00 m11 m23) (cl:* m01 m13 m20) (cl:* m03 m10 m21))
                    determinant)
             o30 (/ (cl:- (cl:+ (cl:* m10 m22 m31) (cl:* m11 m20 m32) (cl:* m12 m21 m30))
                          (cl:* m10 m21 m32) (cl:* m11 m22 m30) (cl:* m12 m20 m31))
                    determinant)
             o31 (/ (cl:- (cl:+ (cl:* m00 m21 m32) (cl:* m01 m22 m30) (cl:* m02 m20 m31))
                          (cl:* m00 m22 m31) (cl:* m01 m20 m32) (cl:* m02 m21 m30))
                    determinant)
             o32 (/ (cl:- (cl:+ (cl:* m00 m12 m31) (cl:* m01 m10 m32) (cl:* m02 m11 m30))
                          (cl:* m00 m11 m32) (cl:* m01 m12 m30) (cl:* m02 m10 m31))
                    determinant)
             o33 (/ (cl:- (cl:+ (cl:* m00 m11 m22) (cl:* m01 m12 m20) (cl:* m02 m10 m21))
                          (cl:* m00 m12 m21) (cl:* m01 m10 m22) (cl:* m02 m11 m20))
                    determinant))))
  (values out t))

(u:fn-> invert (mat) mat)
(declaim (inline invert))
(defun invert (mat)
  (declare (optimize speed))
  (invert! (id) mat))

(u:fn-> look-at! (mat v3:vec v3:vec v3:vec) mat)
(defun look-at! (out eye target up)
  (declare (optimize speed))
  (with-components ((o out))
    (let* ((z (v3:- target eye))
           (x (v3:cross z up))
           (y (v3:cross x z)))
      (declare (dynamic-extent x y z))
      (v3:with-components ((x x) (y y) (z z))
        (v3:normalize! x x)
        (v3:normalize! y y)
        (v3:normalize! z z)
        (setf o00 xx
              o01 xy
              o02 xz
              o03 (cl:- (v3:dot x eye))
              o10 yx
              o11 yy
              o12 yz
              o13 (cl:- (v3:dot y eye))
              o20 (cl:- zx)
              o21 (cl:- zy)
              o22 (cl:- zz)
              o23 (v3:dot z eye)
              o30 0.0
              o31 0.0
              o32 0.0
              o33 1.0))))
  out)

(u:fn-> look-at (v3:vec v3:vec v3:vec) mat)
(declaim (inline look-at))
(defun look-at (eye target up)
  (declare (optimize speed))
  (look-at! (id) eye target up))

(u:fn-> ortho! (mat u:f32 u:f32 u:f32 u:f32 u:f32 u:f32) mat)
(defun ortho! (out left right bottom top near far)
  (declare (optimize speed))
  (let ((right-left (cl:- right left))
        (top-bottom (cl:- top bottom))
        (far-near (cl:- far near)))
    (with-components ((m (id! out)))
      (psetf m00 (/ 2.0 right-left)
             m03 (cl:- (/ (cl:+ right left) right-left))
             m11 (/ 2.0 top-bottom)
             m13 (cl:- (/ (cl:+ top bottom) top-bottom))
             m22 (/ -2.0 far-near)
             m23 (cl:- (/ (cl:+ far near) far-near))))
    out))

(u:fn-> ortho (u:f32 u:f32 u:f32 u:f32 u:f32 u:f32) mat)
(declaim (inline ortho))
(defun ortho (left right bottom top near far)
  (declare (optimize speed))
  (ortho! (id) left right bottom top near far))

(u:fn-> perspective! (mat u:f32 u:f32 u:f32 u:f32) mat)
(defun perspective! (out fov aspect near far)
  (declare (optimize speed))
  (let ((f (/ (tan (/ fov 2.0))))
        (z (cl:- near far)))
    (with-components ((m (zero! out)))
      (psetf m00 (cl:* f (cl:/ aspect))
             m11 f
             m22 (/ (cl:+ near far) z)
             m23 (/ (cl:* 2 near far) z)
             m32 -1.0)))
  out)

(u:fn-> perspective (u:f32 u:f32 u:f32 u:f32) mat)
(declaim (inline perspective))
(defun perspective (fov aspect near far)
  (declare (optimize speed))
  (perspective! (id) fov aspect near far))
