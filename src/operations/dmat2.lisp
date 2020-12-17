(in-package #:net.mfiano.lisp.origin.dmat2)

;;; constructors

(u:fn-> %mat (&rest u:f64) mat)
(declaim (inline %mat))
(u:eval-always
  (defun %mat (&rest args)
    (declare (optimize speed))
    (make-array 4 :element-type 'double-float :initial-contents args)))

(ss:defstore mat (&rest args))

(ss:defspecialization (mat :inline t) () mat
  (%mat 0d0 0d0 0d0 0d0))

(ss:defspecialization (mat :inline t) ((x real)) mat
  (%mat (float x 1d0) 0d0 0d0 (float x 1d0)))

(ss:defspecialization (mat :inline t) ((mat mat)) mat
  (with-components ((m mat))
    (%mat m00 m01 m10 m11)))

(ss:defspecialization (mat :inline t) ((mat net.mfiano.lisp.origin.dmat3:mat))
    mat
  (net.mfiano.lisp.origin.dmat3:with-components ((m mat))
    (%mat m00 m01 m10 m11)))

(ss:defspecialization (mat :inline t) ((mat net.mfiano.lisp.origin.dmat4:mat))
    mat
  (net.mfiano.lisp.origin.dmat4:with-components ((m mat))
    (%mat m00 m01 m10 m11)))

(ss:defspecialization (mat :inline t) ((a dv2:vec) (b dv2:vec)) mat
  (dv2:with-components ((a a) (b b))
    (%mat ax ay bx by)))

(ss:defspecialization (mat :inline t) ((a real) (b real) (c real) (d real)) mat
  (%mat (float a 1d0) (float b 1d0) (float c 1d0) (float d 1d0)))

(ss:defspecialization (mat :inline t) ((mat m2:mat)) mat
  (m2:with-components ((m mat))
    (%mat (float m00 1d0) (float m10 1d0) (float m01 1d0) (float m11 1d0))))

;;; constants

(u:define-constant +zero+ (%mat 0d0 0d0 0d0 0d0) :test #'equalp)

(u:define-constant +id+ (%mat 1d0 0d0 0d0 1d0) :test #'equalp)

;;; operators

(u:fn-> = (mat mat &key (:rel u:f64) (:abs u:f64)) boolean)
(declaim (inline =))
(defun = (mat1 mat2 &key (rel 1d-7) (abs rel))
  (com:cwcmp 4 (mat1 mat2) (com:= mat1 mat2 rel abs)))

(u:fn-> zero! (mat) mat)
(declaim (inline zero!))
(defun zero! (mat)
  (declare (optimize speed))
  (com:cwset 4 mat nil 0d0)
  mat)

(u:fn-> zero () mat)
(declaim (inline zero))
(defun zero ()
  (declare (optimize speed))
  (%mat 0d0 0d0
        0d0 0d0))

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
    (psetf m00 1d0 m01 0d0
           m10 0d0 m11 1d0))
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
    (com:cwset 4 out nil (cl:+ min (cl:random diff))))
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
  (com:cwset 4 out mat mat)
  out)

(u:fn-> copy (mat) mat)
(declaim (inline copy))
(defun copy (mat)
  (declare (optimize speed))
  (copy! (zero) mat))

(u:fn-> clamp! (mat mat u:f64 u:f64) mat)
(declaim (inline clamp!))
(defun clamp! (out mat min max)
  (declare (optimize speed))
  (com:cwset 4 out mat (u:clamp mat min max))
  out)

(u:fn-> clamp (mat u:f64 u:f64) mat)
(declaim (inline clamp))
(defun clamp (mat min max)
  (declare (optimize speed))
  (clamp! (zero) mat min max))

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

(defmacro %* (o00 o01 o10 o11 a00 a01 a10 a11 b00 b01 b10 b11)
  `(psetf ,o00 (cl:+ (cl:* ,a00 ,b00) (cl:* ,a01 ,b10))
          ,o10 (cl:+ (cl:* ,a10 ,b00) (cl:* ,a11 ,b10))
          ,o01 (cl:+ (cl:* ,a00 ,b01) (cl:* ,a01 ,b11))
          ,o11 (cl:+ (cl:* ,a10 ,b01) (cl:* ,a11 ,b11))))

(u:fn-> *! (mat mat mat) mat)
(declaim (inline *!))
(defun *! (out mat1 mat2)
  (declare (optimize speed))
  (with-components ((o out) (a mat1) (b mat2))
    (%* o00 o01 o10 o11 a00 a01 a10 a11 b00 b01 b10 b11))
  out)

(u:fn-> * (mat mat) mat)
(declaim (inline *))
(defun * (mat1 mat2)
  (declare (optimize speed))
  (*! (zero) mat1 mat2))

(u:fn-> get-column! (dv2:vec mat (integer 0 1)) dv2:vec)
(declaim (inline get-column!))
(defun get-column! (out mat index)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv2:with-components ((o out))
      (ecase index
        (0 (psetf ox m00 oy m10))
        (1 (psetf ox m01 oy m11)))))
  out)

(u:fn-> get-column (mat (integer 0 1)) dv2:vec)
(declaim (inline get-column))
(defun get-column (mat index)
  (declare (optimize speed))
  (get-column! (dv2:zero) mat index))

(u:fn-> set-column! (mat mat dv2:vec (integer 0 1)) mat)
(declaim (inline set-column!))
(defun set-column! (out mat vec index)
  (declare (optimize speed))
  (with-components ((o out))
    (dv2:with-components ((v vec))
      (copy! out mat)
      (ecase index
        (0 (psetf o00 vx o10 vy))
        (1 (psetf o01 vx o11 vy)))))
  out)

(u:fn-> set-column (mat dv2:vec (integer 0 1)) mat)
(declaim (inline set-column))
(defun set-column (mat vec index)
  (declare (optimize speed))
  (set-column! (id) mat vec index))

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

(u:fn-> rotate! (mat mat u:f64 &key (:space keyword)) mat)
(declaim (inline rotate!))
(defun rotate! (out mat angle &key (space :local))
  (with-components ((m (id)))
    (copy! out mat)
    (when (cl:> (abs angle) 1d-7)
      (let ((s (sin angle))
            (c (cos angle)))
        (psetf m00 c m01 (cl:- s)
               m10 s m11 c)
        (ecase space
          (:local (*! out out m))
          (:world (*! out m out))))))
  out)

(u:fn-> rotate (mat u:f64) mat)
(declaim (inline rotate))
(defun rotate (mat vec)
  (declare (optimize speed))
  (rotate! (id) mat vec))

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
  (*! out (set-scale (id) vec) mat))

(u:fn-> scale (mat dv2:vec) mat)
(declaim (inline scale))
(defun scale (mat vec)
  (declare (optimize speed))
  (scale! (id) mat vec))

(u:fn-> *v2! (dv2:vec mat dv2:vec) dv2:vec)
(declaim (inline *v2!))
(defun *v2! (out mat vec)
  (declare (optimize speed))
  (dv2:with-components ((v vec) (o out))
    (with-components ((m mat))
      (psetf ox (cl:+ (cl:* m00 vx) (cl:* m01 vy))
             oy (cl:+ (cl:* m10 vx) (cl:* m11 vy)))))
  out)

(u:fn-> *v2 (mat dv2:vec) dv2:vec)
(declaim (inline *v2))
(defun *v2 (mat vec)
  (declare (optimize speed))
  (*v2! (dv2:zero) mat vec))

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

(u:fn-> trace (mat) u:f64)
(declaim (inline trace))
(defun trace (mat)
  (with-components ((m mat))
    (cl:+ m00 m11)))

(u:fn-> diagonal-p (mat) boolean)
(declaim (inline diagonal-p))
(defun diagonal-p (mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (cl:= 0d0 m10 m01)))

(u:fn-> main-diagonal! (dv2:vec mat) dv2:vec)
(declaim (inline main-diagonal!))
(defun main-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv2:with-components ((v out))
      (psetf vx m00 vy m11)))
  out)

(u:fn-> main-diagonal (mat) dv2:vec)
(declaim (inline main-diagonal))
(defun main-diagonal (mat)
  (declare (optimize speed))
  (main-diagonal! (dv2:zero) mat))

(u:fn-> anti-diagonal! (dv2:vec mat) dv2:vec)
(declaim (inline anti-diagonal!))
(defun anti-diagonal! (out mat)
  (declare (optimize speed))
  (with-components ((m mat))
    (dv2:with-components ((v out))
      (psetf vx m01 vy m10)))
  out)

(u:fn-> anti-diagonal (mat) dv2:vec)
(declaim (inline anti-diagonal))
(defun anti-diagonal (mat)
  (declare (optimize speed))
  (anti-diagonal! (dv2:zero) mat))
