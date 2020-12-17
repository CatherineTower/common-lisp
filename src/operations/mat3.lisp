(in-package #:net.mfiano.lisp.origin.mat3)

;;; constructors

(u:fn-> %mat (&rest u:f32) mat)
(declaim (inline %mat))
(u:eval-always
  (defun %mat (&rest args)
    (declare (optimize speed))
    (make-array 9 :element-type 'single-float :initial-contents args)))

(ss:defstore mat (&rest args))

(ss:defspecialization (mat :inline t) () mat
  (%mat 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0))

(ss:defspecialization (mat :inline t) ((x real)) mat
  (%mat (float x 1f0) 0f0 0f0
        0f0 (float x 1f0) 0f0
        0f0 0f0 (float x 1f0)))

(ss:defspecialization (mat :inline t) ((mat m2:mat)) mat
  (m2:with-components ((m mat))
    (%mat m00 m10 0f0 m01 m11 0f0 0f0 0f0 1f0)))

(ss:defspecialization (mat :inline t) ((mat mat)) mat
  (with-components ((m mat))
    (%mat m00 m10 m20 m01 m11 m21 m02 m12 m22)))

(ss:defspecialization (mat :inline t) ((mat net.mfiano.lisp.origin.mat4:mat))
    mat
  (net.mfiano.lisp.origin.mat4:with-components ((m mat))
    (%mat m00 m01 m02 m10 m11 m12 m20 m21 m22)))

(ss:defspecialization (mat :inline t) ((a v3:vec) (b v3:vec) (c v3:vec)) mat
  (v3:with-components ((a a) (b b) (c c))
    (%mat ax ay az bx by bz cx cy cz)))

(ss:defspecialization (mat :inline t) ((a real) (b real) (c real)
                                       (d real) (e real) (f real)
                                       (g real) (h real) (i real))
    mat
  (%mat (float a 1f0) (float b 1f0) (float c 1f0)
        (float d 1f0) (float e 1f0) (float f 1f0)
        (float g 1f0) (float h 1f0) (float i 1f0)))

(ss:defspecialization (mat :inline t) ((mat net.mfiano.lisp.origin.dmat3:mat))
    mat
  (net.mfiano.lisp.origin.dmat3:with-components ((m mat))
    (%mat (float m00 1f0) (float m10 1f0) (float m20 1f0)
          (float m01 1f0) (float m11 1f0) (float m21 1f0)
          (float m02 1f0) (float m12 1f0) (float m22 1f0))))

;;; constants

(u:define-constant +zero+ (%mat 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0 0f0)
  :test #'equalp)

(u:define-constant +id+ (%mat 1f0 0f0 0f0 0f0 1f0 0f0 0f0 0f0 1f0) :test #'equalp)

;;; operators

(u:fn-> = (mat mat &key (:rel u:f32) (:abs u:f32)) boolean)
(declaim (inline =))
(defun = (mat1 mat2 &key (rel 1e-7) (abs rel))
  (com:cwcmp 9 (mat1 mat2) (com:= mat1 mat2 rel abs)))

(u:fn-> zero! (mat) mat)
(declaim (inline zero!))
(defun zero! (mat)
  (declare (optimize speed))
  (com:cwset 9 mat nil 0f0)
  mat)

(u:fn-> zero () mat)
(declaim (inline zero))
(defun zero ()
  (declare (optimize speed))
  (%mat 0f0 0f0 0f0
        0f0 0f0 0f0
        0f0 0f0 0f0))

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
    (psetf m00 1f0 m01 0f0 m02 0f0
           m10 0f0 m11 1f0 m12 0f0
           m20 0f0 m21 0f0 m22 1f0))
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
    (com:cwset 9 out nil (cl:+ min (cl:random diff))))
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
  (com:cwset 9 out mat mat)
  out)

(u:fn-> copy (mat) mat)
(declaim (inline copy))
(defun copy (mat)
  (declare (optimize speed))
  (copy! (zero) mat))

(u:fn-> clamp! (mat mat u:f32 u:f32) mat)
(declaim (inline clamp!))
(defun clamp! (out mat min max)
  (declare (optimize speed))
  (com:cwset 9 out mat (u:clamp mat min max))
  out)

(u:fn-> clamp (mat u:f32 u:f32) mat)
(declaim (inline clamp))
(defun clamp (mat min max)
  (declare (optimize speed))
  (clamp! (zero) mat min max))

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

(defmacro %* (o00 o01 o02 o10 o11 o12 o20 o21 o22
              a00 a01 a02 a10 a11 a12 a20 a21 a22
              b00 b01 b02 b10 b11 b12 b20 b21 b22)
  `(psetf ,o00 (cl:+ (cl:* ,a00 ,b00) (cl:* ,a01 ,b10) (cl:* ,a02 ,b20))
          ,o10 (cl:+ (cl:* ,a10 ,b00) (cl:* ,a11 ,b10) (cl:* ,a12 ,b20))
          ,o20 (cl:+ (cl:* ,a20 ,b00) (cl:* ,a21 ,b10) (cl:* ,a22 ,b20))
          ,o01 (cl:+ (cl:* ,a00 ,b01) (cl:* ,a01 ,b11) (cl:* ,a02 ,b21))
          ,o11 (cl:+ (cl:* ,a10 ,b01) (cl:* ,a11 ,b11) (cl:* ,a12 ,b21))
          ,o21 (cl:+ (cl:* ,a20 ,b01) (cl:* ,a21 ,b11) (cl:* ,a22 ,b21))
          ,o02 (cl:+ (cl:* ,a00 ,b02) (cl:* ,a01 ,b12) (cl:* ,a02 ,b22))
          ,o12 (cl:+ (cl:* ,a10 ,b02) (cl:* ,a11 ,b12) (cl:* ,a12 ,b22))
          ,o22 (cl:+ (cl:* ,a20 ,b02) (cl:* ,a21 ,b12) (cl:* ,a22 ,b22))))

(u:fn-> *! (mat mat mat) mat)
(declaim (inline *!))
(defun *! (out mat1 mat2)
  (declare (optimize speed))
  (with-components ((o out) (a mat1) (b mat2))
    (%* o00 o01 o02 o10 o11 o12 o20 o21 o22
        a00 a01 a02 a10 a11 a12 a20 a21 a22
        b00 b01 b02 b10 b11 b12 b20 b21 b22))
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

(u:fn-> rotation-to-mat2! (m2:mat mat) m2:mat)
(declaim (inline rotation-to-mat2!))
(defun rotation-to-mat2! (out mat)
  (declare (optimize speed))
  (m2:with-components ((o out))
    (with-components ((m mat))
      (psetf o00 m00 o01 m01
             o10 m10 o11 m11)))
  out)

(u:fn-> rotation-to-mat2 (mat) m2:mat)
(declaim (inline rotation-to-mat2))
(defun rotation-to-mat2 (mat)
  (declare (optimize speed))
  (rotation-to-mat2! (m2:id) mat))

(u:fn-> normalize-rotation! (mat mat) mat)
(declaim (inline normalize-rotation!))
(defun normalize-rotation! (out mat)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v2::%normalize o00 o10 m00 m10)
    (v2::%normalize o01 o11 m01 m11)
    (v2::%normalize o02 o12 m02 m12))
  out)

(u:fn-> normalize-rotation (mat) mat)
(declaim (inline normalize-rotation))
(defun normalize-rotation (mat)
  (declare (optimize speed))
  (normalize-rotation! (copy mat) mat))

(u:fn-> get-column! (v3:vec mat (integer 0 2)) v3:vec)
(declaim (inline get-column!))
(defun get-column! (out mat index)
  (declare (optimize speed))
  (with-components ((m mat))
    (v3:with-components ((o out))
      (ecase index
        (0 (psetf ox m00 oy m10 oz m20))
        (1 (psetf ox m01 oy m11 oz m21))
        (2 (psetf ox m02 oy m12 oz m22)))))
  out)

(u:fn-> get-column (mat (integer 0 2)) v3:vec)
(declaim (inline get-column))
(defun get-column (mat index)
  (declare (optimize speed))
  (get-column! (v3:zero) mat index))

(u:fn-> set-column! (mat mat v3:vec (integer 0 2)) mat)
(declaim (inline set-column!))
(defun set-column! (out mat vec index)
  (declare (optimize speed))
  (with-components ((o out))
    (v3:with-components ((v vec))
      (copy! out mat)
      (ecase index
        (0 (psetf o00 vx o10 vy o20 vz))
        (1 (psetf o01 vx o11 vy o21 vz))
        (2 (psetf o02 vx o12 vy o22 vz)))))
  out)

(u:fn-> set-column (mat v3:vec (integer 0 2)) mat)
(declaim (inline set-column))
(defun set-column (mat vec index)
  (declare (optimize speed))
  (set-column! (id) mat vec index))

(u:fn-> get-translation! (v2:vec mat) v2:vec)
(declaim (inline get-translation!))
(defun get-translation! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v2:with-components ((o out))
      (psetf ox m02 oy m12)))
  out)

(u:fn-> get-translation (mat) v2:vec)
(declaim (inline get-translation))
(defun get-translation (mat)
  (declare (optimize speed))
  (get-translation! (v2:zero) mat))

(u:fn-> set-translation! (mat mat v2:vec) mat)
(declaim (inline set-translation!))
(defun set-translation! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v2:with-components ((v vec))
      (copy-rotation! out mat)
      (psetf o02 vx o12 vy o22 m22)))
  out)

(u:fn-> set-translation (mat v2:vec) mat)
(declaim (inline set-translation))
(defun set-translation (mat vec)
  (declare (optimize speed))
  (set-translation! (copy mat) mat vec))

(u:fn-> translate! (mat mat v2:vec) mat)
(declaim (inline translate!))
(defun translate! (out mat vec)
  (declare (optimize speed))
  (with-components ((o out) (m mat))
    (v2:with-components ((v vec))
      (copy! out mat)
      (psetf o00 (cl:+ m00 (cl:* m20 vx))
             o01 (cl:+ m01 (cl:* m21 vx))
             o02 (cl:+ m02 (cl:* m22 vx))
             o10 (cl:+ m10 (cl:* m20 vy))
             o11 (cl:+ m11 (cl:* m21 vy))
             o12 (cl:+ m12 (cl:* m22 vy))
             o20 m20
             o21 m21
             o22 m22)))
  out)

(u:fn-> translate (mat v2:vec) mat)
(declaim (inline translate))
(defun translate (mat vec)
  (declare (optimize speed))
  (translate! (id) mat vec))

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

(u:fn-> rotate! (mat mat u:f32 &key (:space keyword)) mat)
(declaim (inline rotate!))
(defun rotate! (out mat angle &key (space :local))
  (m2:with-elements ((m 1f0 0f0 0f0 1f0))
    (with-components ((o out))
      (let ((s (sin angle))
            (c (cos angle)))
        (copy! out mat)
        (psetf m00 c m01 (cl:- s) m10 s m11 c)
        (ecase space
          (:local (m2::%* o00 o01 o10 o11 o00 o01 o10 o11 m00 m01 m10 m11))
          (:world (m2::%* o00 o01 o10 o11 m00 m01 m10 m11 o00 o01 o10 o11))))))
  out)

(u:fn-> rotate (mat u:f32) mat)
(declaim (inline rotate))
(defun rotate (mat vec)
  (declare (optimize speed))
  (rotate! (id) mat vec))

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
  (with-components ((o out) (m mat))
    (v2:with-components ((v vec))
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

(u:fn-> scale (mat v2:vec) mat)
(declaim (inline scale))
(defun scale (mat vec)
  (declare (optimize speed))
  (scale! (id) mat vec))

(u:fn-> *v3! (v3:vec mat v3:vec) v3:vec)
(declaim (inline *v3!))
(defun *v3! (out mat vec)
  (declare (optimize speed))
  (v3:with-components ((v vec) (o out))
    (with-components ((m mat))
      (psetf ox (cl:+ (cl:* m00 vx) (cl:* m01 vy) (cl:* m02 vz))
             oy (cl:+ (cl:* m10 vx) (cl:* m11 vy) (cl:* m12 vz))
             oz (cl:+ (cl:* m20 vx) (cl:* m21 vy) (cl:* m22 vz)))))
  out)

(u:fn-> *v3 (mat v3:vec) v3:vec)
(declaim (inline *v3))
(defun *v3 (mat vec)
  (declare (optimize speed))
  (*v3! (v3:zero) mat vec))

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

(defmacro %trace (m00 m11 m22)
  `(cl:+ ,m00 ,m11 ,m22))

(u:fn-> trace (mat) u:f32)
(declaim (inline trace))
(defun trace (mat)
  (with-components ((m mat))
    (%trace m00 m11 m22)))

(u:fn-> diagonal-p (mat) boolean)
(declaim (inline diagonal-p))
(defun diagonal-p (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (cl:= 0f0 m10 m20 m01 m21 m02 m12)))

(u:fn-> main-diagonal! (v3:vec mat) v3:vec)
(declaim (inline main-diagonal!))
(defun main-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v3:with-components ((v out))
      (psetf vx m00 vy m11 vz m22)))
  out)

(u:fn-> main-diagonal (mat) v3:vec)
(declaim (inline main-diagonal))
(defun main-diagonal (mat)
  (declare (optimize speed))
  (main-diagonal! (v3:zero) mat))

(u:fn-> anti-diagonal! (v3:vec mat) v3:vec)
(declaim (inline anti-diagonal!))
(defun anti-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (v3:with-components ((v out))
      (psetf vx m02 vy m11 vz m20)))
  out)

(u:fn-> anti-diagonal (mat) v3:vec)
(declaim (inline anti-diagonal))
(defun anti-diagonal (mat)
  (declare (optimize speed))
  (anti-diagonal! (v3:zero) mat))
