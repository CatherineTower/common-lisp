(in-package #:mfiano.math.origin.dmat3)

(u:fn-> = (mat mat &key (:rel u:f64) (:abs u:f64)) boolean)
(declaim (inline =))
(defun = (mat1 mat2 &key (rel 1d-7) (abs rel))
  (com:cwcmp 9 (mat1 mat2) (com:= mat1 mat2 rel abs)))

(u:fn-> zero! (mat) mat)
(declaim (inline zero!))
(defun zero! (mat)
  (declare (optimize speed))
  (com:cwset 9 mat nil 0d0)
  mat)

(u:fn-> zero () mat)
(declaim (inline zero))
(defun zero ()
  (declare (optimize speed))
  (%mat 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0 0d0))

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
    (psetf m00 1d0 m01 0d0 m02 0d0
           m10 0d0 m11 1d0 m12 0d0
           m20 0d0 m21 0d0 m22 1d0))
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

(u:fn-> random! (mat u:f64 u:f64) mat)
(declaim (inline random!))
(defun random! (out min max)
  (declare (optimize speed))
  (let ((diff (cl:- max min)))
    (com:cwset 9 out nil (cl:+ min (cl:random diff))))
  out)

(u:fn-> random (u:f64 u:f64) mat)
(declaim (inline random))
(defun random (min max)
  (declare (optimize speed))
  (random! (zero) min max))

(u:fn-> copy! (mat mat) mat)
(declaim (inline copy!))
(defun copy! (out mat)
  (declare (optimize speed))
  (com:cwset 9 out mat mat)
  out)

(u:fn-> copy (mat) mat)
(declaim (inline copy))
(defun copy (mat)
  (declare (optimize speed))
  (copy! (zero) mat))

(u:fn-> clamp! (mat mat mat mat) mat)
(declaim (inline clamp!))
(defun clamp! (out mat min max)
  "Modify matrix OUT to have its components represent the components of matrix
MAT, bounded by the components of matrices MIN and MAX."
  (declare (optimize speed))
  (com:cwset 9 out (mat min max) (u:clamp mat min max))
  out)

(u:fn-> clamp (mat mat mat) mat)
(declaim (inline clamp))
(defun clamp (mat min max)
  "Construct a fresh matrix that has the components of matrix MAT bounded by the
  components of matrices MIN and MAX."
  (declare (optimize speed))
  (clamp! (zero) mat min max))

(u:fn-> clamp-range! (mat mat u:f64 u:f64) mat)
(declaim (inline clamp-range!))
(defun clamp-range! (out mat min max)
  (declare (optimize speed))
  (com:cwset 9 out mat (u:clamp mat min max))
  out)

(u:fn-> clamp-range (mat u:f64 u:f64) mat)
(declaim (inline clamp-range))
(defun clamp-range (mat min max)
  (declare (optimize speed))
  (clamp-range! (zero) mat min max))

(u:fn-> +! (mat mat mat) mat)
(declaim (inline +!))
(defun +! (out mat1 mat2)
  (declare (optimize speed))
  (com:cwset 9 out (mat1 mat2) (cl:+ mat1 mat2))
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
  (com:cwset 9 out (mat1 mat2) (cl:- mat1 mat2))
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
    (psetf o00 (cl:+ (cl:* a00 b00) (cl:* a01 b10) (cl:* a02 b20))
           o10 (cl:+ (cl:* a10 b00) (cl:* a11 b10) (cl:* a12 b20))
           o20 (cl:+ (cl:* a20 b00) (cl:* a21 b10) (cl:* a22 b20))
           o01 (cl:+ (cl:* a00 b01) (cl:* a01 b11) (cl:* a02 b21))
           o11 (cl:+ (cl:* a10 b01) (cl:* a11 b11) (cl:* a12 b21))
           o21 (cl:+ (cl:* a20 b01) (cl:* a21 b11) (cl:* a22 b21))
           o02 (cl:+ (cl:* a00 b02) (cl:* a01 b12) (cl:* a02 b22))
           o12 (cl:+ (cl:* a10 b02) (cl:* a11 b12) (cl:* a12 b22))
           o22 (cl:+ (cl:* a20 b02) (cl:* a21 b12) (cl:* a22 b22))))
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
    (psetf o00 m00 o01 m01
           o10 m10 o11 m11))
  out)

(u:fn-> copy-rotation (mat) mat)
(declaim (inline copy-rotation))
(defun copy-rotation (mat)
  (declare (optimize speed))
  (copy-rotation! (id) mat))

(u:fn-> rotation-to-mat2! (dm2:mat mat) dm2:mat)
(declaim (inline rotation-to-mat2!))
(defun rotation-to-mat2! (out mat)
  (declare (optimize speed))
  (dm2:with-components ((o out))
    (with-components ((m mat))
      (psetf o00 m00 o01 m01
             o10 m10 o11 m11)))
  out)

(u:fn-> rotation-to-mat2 (mat) dm2:mat)
(declaim (inline rotation-to-mat2))
(defun rotation-to-mat2 (mat)
  (declare (optimize speed))
  (rotation-to-mat2! (dm2:id) mat))

(u:fn-> rotation-axis-to-vec2! (dv2:vec mat keyword) dv2:vec)
(declaim (inline rotation-axis-to-vec2!))
(defun rotation-axis-to-vec2! (out mat axis)
  (declare (optimize speed))
  (dv2:with-components ((v out))
    (with-components ((m mat))
      (ecase axis
        (:x (psetf vx m00 vy m10))
        (:y (psetf vx m01 vy m11)))))
  out)

(u:fn-> rotation-axis-to-vec2 (mat keyword) dv2:vec)
(declaim (inline rotation-axis-to-vec2))
(defun rotation-axis-to-vec2 (mat axis)
  (declare (optimize speed))
  (rotation-axis-to-vec2! (dv2:zero) mat axis))

(u:fn-> rotation-axis-from-vec2! (mat dv2:vec keyword) mat)
(declaim (inline rotation-axis-from-vec2!))
(defun rotation-axis-from-vec2! (out vec axis)
  (declare (optimize speed))
  (with-components ((o out))
    (dv2:with-components ((v vec))
      (ecase axis
        (:x (psetf o00 vx o10 vy))
        (:y (psetf o01 vx o11 vy)))))
  out)

(u:fn-> rotation-axis-from-vec2 (mat dv2:vec keyword) mat)
(declaim (inline rotation-axis-from-vec2))
(defun rotation-axis-from-vec2 (mat vec axis)
  (declare (optimize speed))
  (rotation-axis-from-vec2! (copy mat) vec axis))

(u:fn-> rotation-x-from-angle! (mat u:f64) mat)
(declaim (inline rotation-x-from-angle!))
(defun rotation-x-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 1d0
             o10 0d0
             o20 0d0
             o01 0d0
             o11 c
             o21 s
             o02 0d0
             o12 (cl:- s)
             o22 c))
    out))

(u:fn-> rotation-x-from-angle (u:f64) mat)
(declaim (inline rotation-x-from-angle))
(defun rotation-x-from-angle (angle)
  (declare (optimize speed))
  (rotation-x-from-angle! (mat) angle))

(u:fn-> rotation-y-from-angle! (mat u:f64) mat)
(declaim (inline rotation-y-from-angle!))
(defun rotation-y-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 c
             o10 0d0
             o20 (cl:- s)
             o01 0d0
             o11 1d0
             o21 0d0
             o02 s
             o12 0d0
             o22 c))
    out))

(u:fn-> rotation-y-from-angle (u:f64) mat)
(declaim (inline rotation-y-from-angle))
(defun rotation-y-from-angle (angle)
  (declare (optimize speed))
  (rotation-y-from-angle! (mat) angle))

(u:fn-> rotation-z-from-angle! (mat u:f64) mat)
(declaim (inline rotation-z-from-angle!))
(defun rotation-z-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 c
             o10 s
             o20 0d0
             o01 (cl:- s)
             o11 c
             o21 0d0
             o02 0d0
             o12 0d0
             o22 1d0))
    out))

(u:fn-> rotation-z-from-angle (u:f64) mat)
(declaim (inline rotation-z-from-angle))
(defun rotation-z-from-angle (angle)
  (declare (optimize speed))
  (rotation-z-from-angle! (mat) angle))

(u:fn-> normalize-rotation! (mat mat) mat)
(declaim (inline normalize-rotation!))
(defun normalize-rotation! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (let ((x (dv2::%vec m00 m10))
          (y (dv2::%vec m01 m11)))
      (declare (dynamic-extent x y))
      (dv2:normalize! x x)
      (dv2:normalize! y y)
      (rotation-axis-from-vec2! out x :x)
      (rotation-axis-from-vec2! out y :y)))
  out)

(u:fn-> normalize-rotation (mat) mat)
(declaim (inline normalize-rotation))
(defun normalize-rotation (mat)
  (declare (optimize speed))
  (normalize-rotation! (copy mat) mat))

(u:fn-> get-column! (dv3:vec mat (integer 0 2)) dv3:vec)
(declaim (inline get-column!))
(defun get-column! (out mat index)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv3:with-components ((o out))
      (ecase index
        (0 (psetf ox m00 oy m10 oz m20))
        (1 (psetf ox m01 oy m11 oz m21))
        (2 (psetf ox m02 oy m12 oz m22)))))
  out)

(u:fn-> get-column (mat (integer 0 2)) dv3:vec)
(declaim (inline get-column))
(defun get-column (mat index)
  (declare (optimize speed))
  (get-column! (dv3:zero) mat index))

(u:fn-> set-column! (mat mat dv3:vec (integer 0 2)) mat)
(declaim (inline set-column!))
(defun set-column! (out mat vec index)
  (declare (optimize speed))
  (with-components ((o out))
    (dv3:with-components ((v vec))
      (copy! out mat)
      (ecase index
        (0 (psetf o00 vx o10 vy o20 vz))
        (1 (psetf o01 vx o11 vy o21 vz))
        (2 (psetf o02 vx o12 vy o22 vz)))))
  out)

(u:fn-> set-column (mat dv3:vec (integer 0 2)) mat)
(declaim (inline set-column))
(defun set-column (mat vec index)
  (declare (optimize speed))
  (set-column! (id) mat vec index))

(u:fn-> get-translation! (dv2:vec mat) dv2:vec)
(declaim (inline get-translation!))
(defun get-translation! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv2:with-components ((o out))
      (psetf ox m02 oy m12)))
  out)

(u:fn-> get-translation (mat) dv2:vec)
(declaim (inline get-translation))
(defun get-translation (mat)
  (declare (optimize speed))
  (get-translation! (dv2:zero) mat))

(u:fn-> set-translation! (mat mat dv2:vec) mat)
(declaim (inline set-translation!))
(defun set-translation! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (dv2:with-components ((v vec))
      (copy-rotation! out mat)
      (psetf o02 vx o12 vy o22 m22)))
  out)

(u:fn-> set-translation (mat dv2:vec) mat)
(declaim (inline set-translation))
(defun set-translation (mat vec)
  (declare (optimize speed))
  (set-translation! (copy mat) mat vec))

(u:fn-> translate! (mat mat dv2:vec) mat)
(declaim (inline translate!))
(defun translate! (out mat vec)
  "Compute a translation matrix with identity rotation T from VEC, returning the matrix
multiplication of MAT * T."
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (dv2:with-components ((v vec))
      (psetf o00 m00
             o01 m01
             o02 (cl:+ (cl:* m00 vx) (cl:* m01 vy) m02)
             o10 m10
             o11 m11
             o12 (cl:+ (cl:* m10 vx) (cl:* m11 vy) m12)
             o20 m20
             o21 m21
             o22 (cl:+ (cl:* m20 vx) (cl:* m21 vy) m22))))
  out)

(u:fn-> translate (mat dv2:vec) mat)
(declaim (inline translate))
(defun translate (mat vec)
  (declare (optimize speed))
  (translate! (id) mat vec))

(u:fn-> rotate! (mat mat u:f64 &key (:space keyword)) mat)
(declaim (inline rotate!))
(defun rotate! (out mat angle &key (space :local))
  (declare (optimize speed))
  (let ((r (rotation-z-from-angle angle)))
    (declare (dynamic-extent r))
    (copy! out mat)
    (ecase space
      (:local (*! out out r))
      (:world (*! out r out))))
  out)

(u:fn-> rotate (mat u:f64) mat)
(declaim (inline rotate))
(defun rotate (mat angle)
  (declare (optimize speed))
  (rotate! (id) mat angle))

(u:fn-> get-scale! (dv2:vec mat) dv2:vec)
(declaim (inline get-scale!))
(defun get-scale! (out mat)
  (declare (optimize speed))
  (dv2:with-components ((o out))
    (psetf ox (dv2:length (rotation-axis-to-vec2 mat :x))
           oy (dv2:length (rotation-axis-to-vec2 mat :y))))
  out)

(u:fn-> get-scale (mat) dv2:vec)
(declaim (inline get-scale))
(defun get-scale (mat)
  (declare (optimize speed))
  (get-scale! (dv2:zero) mat))

(u:fn-> set-scale! (mat mat dv2:vec) mat)
(declaim (inline set-scale!))
(defun set-scale! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out))
    (dv2:with-components ((v vec))
      (copy! out mat)
      (psetf o00 vx o11 vy)))
  out)

(u:fn-> set-scale (mat dv2:vec) mat)
(declaim (inline set-scale))
(defun set-scale (mat vec)
  (declare (optimize speed))
  (set-scale! (copy mat) mat vec))

(u:fn-> scale! (mat mat dv2:vec) mat)
(declaim (inline scale!))
(defun scale! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (dv2:with-components ((v vec))
      (psetf o00 (cl:* m00 vx)
             o01 (cl:* m01 vx)
             o02 (cl:* m02 vx)
             o10 (cl:* m10 vy)
             o11 (cl:* m11 vy)
             o12 (cl:* m12 vy)
             o20 m20
             o21 m21
             o22 m22)))
  out)

(u:fn-> scale (mat dv2:vec) mat)
(declaim (inline scale))
(defun scale (mat vec)
  (declare (optimize speed))
  (scale! (id) mat vec))

(u:fn-> *v3! (dv3:vec mat dv3:vec) dv3:vec)
(declaim (inline *v3!))
(defun *v3! (out mat vec)
  (declare (optimize speed))
  (dv3:with-components ((v vec) (o out))
    (with-components ((m mat))
      (psetf ox (cl:+ (cl:* m00 vx) (cl:* m01 vy) (cl:* m02 vz))
             oy (cl:+ (cl:* m10 vx) (cl:* m11 vy) (cl:* m12 vz))
             oz (cl:+ (cl:* m20 vx) (cl:* m21 vy) (cl:* m22 vz)))))
  out)

(u:fn-> *v3 (mat dv3:vec) dv3:vec)
(declaim (inline *v3))
(defun *v3 (mat vec)
  (declare (optimize speed))
  (*v3! (dv3:zero) mat vec))

(u:fn-> transpose! (mat mat) mat)
(declaim (inline transpose!))
(defun transpose! (out mat)
  (declare (optimize speed))
  (with-components ((o (copy! out mat)))
    (rotatef o01 o10)
    (rotatef o02 o20)
    (rotatef o12 o21))
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

(u:fn-> trace (mat) u:f64)
(declaim (inline trace))
(defun trace (mat)
  (with-components ((m mat))
    (cl:+ m00 m11 m22)))

(u:fn-> diagonal-p (mat) boolean)
(declaim (inline diagonal-p))
(defun diagonal-p (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (cl:= 0d0 m10 m20 m01 m21 m02 m12)))

(u:fn-> main-diagonal! (dv3:vec mat) dv3:vec)
(declaim (inline main-diagonal!))
(defun main-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv3:with-components ((v out))
      (psetf vx m00 vy m11 vz m22)))
  out)

(u:fn-> main-diagonal (mat) dv3:vec)
(declaim (inline main-diagonal))
(defun main-diagonal (mat)
  (declare (optimize speed))
  (main-diagonal! (dv3:zero) mat))

(u:fn-> anti-diagonal! (dv3:vec mat) dv3:vec)
(declaim (inline anti-diagonal!))
(defun anti-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv3:with-components ((v out))
      (psetf vx m02 vy m11 vz m20)))
  out)

(u:fn-> anti-diagonal (mat) dv3:vec)
(declaim (inline anti-diagonal))
(defun anti-diagonal (mat)
  (declare (optimize speed))
  (anti-diagonal! (dv3:zero) mat))

(u:fn-> determinant (mat) u:f64)
(declaim (inline determinant))
(defun determinant (mat)
  (with-components ((m mat))
    (cl:- (cl:+ (cl:* m00 m11 m22) (cl:* m10 m21 m02) (cl:* m20 m01 m12))
          (cl:* m00 m21 m12)
          (cl:* m20 m11 m02)
          (cl:* m10 m01 m22))))

(u:fn-> invert! (mat mat) (values mat boolean))
(defun invert! (out mat)
  (macrolet ((% (a b c d)
               `(cl:/ (cl:- (cl:* ,a ,b) (cl:* ,c ,d)) det)))
    (with-components ((m mat) (o out))
      (zero! out)
      (when (id-p mat)
        (return-from invert! (id! out)))
      (let ((det (determinant mat)))
        (when (com:= det 0d0 1d-15 1d-15)
          (warn "Skipped inverting matrix because it has a determinant of zero:~%~s" mat)
          (return-from invert! (values (copy! mat out) nil)))
        (setf o00 (% m11 m22 m12 m21)
              o01 (% m02 m21 m01 m22)
              o02 (% m01 m12 m02 m11)
              o10 (% m12 m20 m10 m22)
              o11 (% m00 m22 m02 m20)
              o12 (% m02 m10 m00 m12)
              o20 (% m10 m21 m11 m20)
              o21 (% m01 m20 m00 m21)
              o22 (% m00 m11 m01 m10))
        (values out t)))))
