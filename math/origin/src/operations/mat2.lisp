(in-package #:mfiano.math.origin.mat2)

(u:fn-> = (mat mat &key (:rel u:f32) (:abs u:f32)) boolean)
(declaim (inline =))
(defun = (mat1 mat2 &key (rel 1f-7) (abs rel))
  (com:cwcmp 4 (mat1 mat2) (com:= mat1 mat2 rel abs)))

(u:fn-> zero! (mat) mat)
(declaim (inline zero!))
(defun zero! (mat)
  (declare (optimize speed))
  (com:cwset 4 mat nil 0f0)
  mat)

(u:fn-> zero () mat)
(declaim (inline zero))
(defun zero ()
  (declare (optimize speed))
  (%mat 0f0 0f0 0f0 0f0))

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
    (psetf m00 1f0 m01 0f0 m10 0f0 m11 1f0))
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
    (com:cwset 4 out nil (cl:+ min (cl:random diff))))
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
  (com:cwset 4 out mat mat)
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
  (com:cwset 4 out (mat min max) (u:clamp mat min max))
  out)

(u:fn-> clamp (mat mat mat) mat)
(declaim (inline clamp))
(defun clamp (mat min max)
  "Construct a fresh matrix that has the components of matrix MAT bounded by the
  components of matrices MIN and MAX."
  (declare (optimize speed))
  (clamp! (zero) mat min max))

(u:fn-> clamp-range! (mat mat u:f32 u:f32) mat)
(declaim (inline clamp-range!))
(defun clamp-range! (out mat min max)
  (declare (optimize speed))
  (com:cwset 4 out mat (u:clamp mat min max))
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
  (com:cwset 4 out (mat1 mat2) (cl:+ mat1 mat2))
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
  (com:cwset 4 out (mat1 mat2) (cl:- mat1 mat2))
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
    (psetf o00 (cl:+ (cl:* a00 b00) (cl:* a01 b10))
           o10 (cl:+ (cl:* a10 b00) (cl:* a11 b10))
           o01 (cl:+ (cl:* a00 b01) (cl:* a01 b11))
           o11 (cl:+ (cl:* a10 b01) (cl:* a11 b11))))
  out)

(u:fn-> * (mat mat) mat)
(declaim (inline *))
(defun * (mat1 mat2)
  (declare (optimize speed))
  (*! (zero) mat1 mat2))

(u:fn-> get-column! (v2:vec mat (integer 0 1)) v2:vec)
(declaim (inline get-column!))
(defun get-column! (out mat index)
  (declare (optimize speed))
  (with-components ((m mat))
    (v2:with-components ((o out))
      (ecase index
        (0 (psetf ox m00 oy m10))
        (1 (psetf ox m01 oy m11)))))
  out)

(u:fn-> get-column (mat (integer 0 1)) v2:vec)
(declaim (inline get-column))
(defun get-column (mat index)
  (declare (optimize speed))
  (get-column! (v2:zero) mat index))

(u:fn-> set-column! (mat mat v2:vec (integer 0 1)) mat)
(declaim (inline set-column!))
(defun set-column! (out mat vec index)
  (declare (optimize speed))
  (with-components ((o out))
    (v2:with-components ((v vec))
      (copy! out mat)
      (ecase index
        (0 (psetf o00 vx o10 vy))
        (1 (psetf o01 vx o11 vy)))))
  out)

(u:fn-> set-column (mat v2:vec (integer 0 1)) mat)
(declaim (inline set-column))
(defun set-column (mat vec index)
  (declare (optimize speed))
  (set-column! (id) mat vec index))

(u:fn-> rotation-axis-to-vec2! (v2:vec mat keyword) v2:vec)
(declaim (inline rotation-axis-to-vec2!))
(defun rotation-axis-to-vec2! (out mat axis)
  (declare (optimize speed))
  (v2:with-components ((v out))
    (with-components ((m mat))
      (ecase axis
        (:x (psetf vx m00 vy m10))
        (:y (psetf vx m01 vy m11)))))
  out)

(u:fn-> rotation-axis-to-vec2 (mat keyword) v2:vec)
(declaim (inline rotation-axis-to-vec2))
(defun rotation-axis-to-vec2 (mat axis)
  (declare (optimize speed))
  (rotation-axis-to-vec2! (v2:zero) mat axis))

(u:fn-> rotation-axis-from-vec2! (mat v2:vec keyword) mat)
(declaim (inline rotation-axis-from-vec2!))
(defun rotation-axis-from-vec2! (out vec axis)
  (declare (optimize speed))
  (with-components ((o out))
    (v2:with-components ((v vec))
      (ecase axis
        (:x (psetf o00 vx o10 vy))
        (:y (psetf o01 vx o11 vy)))))
  out)

(u:fn-> rotation-axis-from-vec2 (mat v2:vec keyword) mat)
(declaim (inline rotation-axis-from-vec2))
(defun rotation-axis-from-vec2 (mat vec axis)
  (declare (optimize speed))
  (rotation-axis-from-vec2! (copy mat) vec axis))

(u:fn-> rotation-from-angle! (mat u:f32) mat)
(declaim (inline rotation-from-angle!))
(defun rotation-from-angle! (out angle)
  (declare (optimize speed))
  (let ((s (sin angle))
        (c (cos angle)))
    (with-components ((o out))
      (psetf o00 c
             o10 s
             o01 (cl:- s)
             o11 c))
    out))

(u:fn-> rotation-from-angle (u:f32) mat)
(declaim (inline rotation-from-angle))
(defun rotation-from-angle (angle)
  (declare (optimize speed))
  (rotation-from-angle! (mat) angle))

(u:fn-> rotate! (mat mat u:f32 &key (:space keyword)) mat)
(declaim (inline rotate!))
(defun rotate! (out mat angle &key (space :local))
  (declare (optimize speed))
  (let ((r (rotation-from-angle angle)))
    (declare (dynamic-extent r))
    (copy! out mat)
    (ecase space
      (:local (*! out out r))
      (:world (*! out r out))))
  out)

(u:fn-> rotate (mat u:f32) mat)
(declaim (inline rotate))
(defun rotate (mat angle)
  (declare (optimize speed))
  (rotate! (id) mat angle))

(u:fn-> get-scale! (v2:vec mat) v2:vec)
(declaim (inline get-scale!))
(defun get-scale! (out mat)
  (declare (optimize speed))
  (v2:with-components ((o out))
    (psetf ox (v2:length (rotation-axis-to-vec2 mat :x))
           oy (v2:length (rotation-axis-to-vec2 mat :y))))
  out)

(u:fn-> get-scale (mat) v2:vec)
(declaim (inline get-scale))
(defun get-scale (mat)
  (declare (optimize speed))
  (get-scale! (v2:zero) mat))

(u:fn-> set-scale! (mat mat v2:vec) mat)
(declaim (inline set-scale!))
(defun set-scale! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out))
    (v2:with-components ((v vec))
      (copy! out mat)
      (psetf o00 vx o11 vy)))
  out)

(u:fn-> set-scale (mat v2:vec) mat)
(declaim (inline set-scale))
(defun set-scale (mat vec)
  (declare (optimize speed))
  (set-scale! (copy mat) mat vec))

(u:fn-> scale! (mat mat v2:vec) mat)
(declaim (inline scale!))
(defun scale! (out mat vec)
  (declare (optimize speed))
  (*! out (set-scale (id) vec) mat))

(u:fn-> scale (mat v2:vec) mat)
(declaim (inline scale))
(defun scale (mat vec)
  (declare (optimize speed))
  (scale! (id) mat vec))

(u:fn-> *v2! (v2:vec mat v2:vec) v2:vec)
(declaim (inline *v2!))
(defun *v2! (out mat vec)
  (declare (optimize speed))
  (v2:with-components ((v vec) (o out))
    (with-components ((m mat))
      (psetf ox (cl:+ (cl:* m00 vx) (cl:* m01 vy))
             oy (cl:+ (cl:* m10 vx) (cl:* m11 vy)))))
  out)

(u:fn-> *v2 (mat v2:vec) v2:vec)
(declaim (inline *v2))
(defun *v2 (mat vec)
  (declare (optimize speed))
  (*v2! (v2:zero) mat vec))

(u:fn-> transpose! (mat mat) mat)
(declaim (inline transpose!))
(defun transpose! (out mat)
  (declare (optimize speed))
  (with-components ((o (copy! out mat)))
    (rotatef o01 o10))
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

(u:fn-> trace (mat) u:f32)
(declaim (inline trace))
(defun trace (mat)
  (with-components ((m mat))
    (cl:+ m00 m11)))

(u:fn-> diagonal-p (mat) boolean)
(declaim (inline diagonal-p))
(defun diagonal-p (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (cl:= 0f0 m10 m01)))

(u:fn-> main-diagonal! (v2:vec mat) v2:vec)
(declaim (inline main-diagonal!))
(defun main-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v2:with-components ((v out))
      (psetf vx m00 vy m11)))
  out)

(u:fn-> main-diagonal (mat) v2:vec)
(declaim (inline main-diagonal))
(defun main-diagonal (mat)
  (declare (optimize speed))
  (main-diagonal! (v2:zero) mat))

(u:fn-> anti-diagonal! (v2:vec mat) v2:vec)
(declaim (inline anti-diagonal!))
(defun anti-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v2:with-components ((v out))
      (psetf vx m01 vy m10)))
  out)

(u:fn-> anti-diagonal (mat) v2:vec)
(declaim (inline anti-diagonal))
(defun anti-diagonal (mat)
  (declare (optimize speed))
  (anti-diagonal! (v2:zero) mat))

(u:fn-> set-diagonal! (mat mat v2:vec) mat)
(declaim (inline set-diagonal!))
(defun set-diagonal! (out mat vec)
  (declare (optimize speed))
  (set-scale! out mat vec))

(u:fn-> set-diagonal (mat v2:vec) mat)
(declaim (inline set-diagonal))
(defun set-diagonal (mat vec)
  (declare (optimize speed))
  (set-scale! (copy mat) mat vec))
