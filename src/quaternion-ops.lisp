(in-package :gamebox-math)

(eval-when (:compile-toplevel :load-toplevel)
  (defun* quat-identity! ((quat quat)) (:result quat :abbrev qid!)
    (with-quat (q quat)
      (psetf qw 1.0 qx 0.0 qy 0.0 qz 0.0))
    quat)

  (defun* quat-identity () (:result quat :abbrev qid)
    (quat-identity! (quat)))

  (define-constant +identity-quaternion+ (quat-identity) :test #'equalp)
  (define-constant +qid+ (quat-identity) :test #'equalp))

(defun* quat= ((quat1 quat) (quat2 quat)) (:result boolean :abbrev q=)
  (with-quats ((q1 quat1) (q2 quat2))
    (and (= q1w q2w)
         (= q1x q2x)
         (= q1y q2y)
         (= q1z q2z))))

(defun* quat~ ((quat1 quat) (quat2 quat) &key ((tolerance single-float) +epsilon+)) (:result boolean :abbrev q~)
  (with-quats ((q1 quat1) (q2 quat2))
    (and (< (abs (- q1w q2w)) tolerance)
         (< (abs (- q1x q2x)) tolerance)
         (< (abs (- q1y q2y)) tolerance)
         (< (abs (- q1z q2z)) tolerance))))

(defun* quat-copy! ((out-quat quat) (quat quat)) (:result quat :abbrev qcp!)
  (with-quats ((o out-quat) (q quat))
    (psetf ow qw ox qx oy qy oz qz))
  out-quat)

(defun* quat-copy ((quat quat)) (:result quat :abbrev qcp)
  (quat-copy! (quat) quat))

(defun* quat+! ((out-quat quat) (quat1 quat) (quat2 quat)) (:result quat :abbrev q+!)
  (with-quats ((o out-quat) (q1 quat1) (q2 quat2))
    (psetf ow (+ q1w q2w)
           ox (+ q1x q2x)
           oy (+ q1y q2y)
           oz (+ q1z q2z)))
  out-quat)

(defun* quat+ ((quat1 quat) (quat2 quat)) (:result quat :abbrev q+)
  (quat+! (quat) quat1 quat2))

(defun* quat-! ((out-quat quat) (quat1 quat) (quat2 quat)) (:result quat :abbrev q-!)
  (with-quats ((o out-quat) (q1 quat1) (q2 quat2))
    (psetf ow (- q1w q2w)
           ox (- q1x q2x)
           oy (- q1y q2y)
           oz (- q1z q2z)))
  out-quat)

(defun* quat- ((quat1 quat) (quat2 quat)) (:result quat :abbrev q-)
  (quat-! (quat) quat1 quat2))

(defun* quat*! ((out-quat quat) (quat1 quat) (quat2 quat)) (:result quat :abbrev q*!)
  (with-quats ((o out-quat) (q1 quat1) (q2 quat2))
    (psetf ow (- (* q1w q2w) (* q1x q2x) (* q1y q2y) (* q1z q2z))
           ox (- (+ (* q1w q2x) (* q1x q2w) (* q1y q2z)) (* q1z q2y))
           oy (- (+ (* q1w q2y) (* q1y q2w) (* q1z q2x)) (* q1x q2z))
           oz (- (+ (* q1w q2z) (* q1z q2w) (* q1x q2y)) (* q1y q2x))))
  out-quat)

(defun* quat* ((quat1 quat) (quat2 quat)) (:result quat :abbrev q*)
  (quat*! (quat) quat1 quat2))

(defun* quat-scale! ((out-quat quat) (quat quat) (scalar single-float)) (:result quat :abbrev qscale!)
  (with-quats ((o out-quat) (q quat))
    (psetf ow (* qw scalar)
           ox (* qx scalar)
           oy (* qy scalar)
           oz (* qz scalar)))
  out-quat)

(defun* quat-scale ((quat quat) (scalar single-float)) (:result quat :abbrev qscale)
  (quat-scale! (quat) quat scalar))

(defun* quat-cross! ((out-quat quat) (quat1 quat) (quat2 quat)) (:result quat :abbrev qcross!)
  (quat-scale!
   out-quat
   (quat+ (quat* quat2 (quat-conjugate quat1))
          (quat* quat1 quat2))
   0.5))

(defun* quat-cross ((quat1 quat) (quat2 quat)) (:result quat :abbrev qcross)
  (quat-cross! (quat) quat1 quat2))

(defun* quat-conjugate! ((out-quat quat) (quat quat)) (:result quat :abbrev qconj!)
  (with-quats ((o out-quat) (q quat))
    (psetf ow qw
           ox (- qx)
           oy (- qy)
           oz (- qz)))
  out-quat)

(defun* quat-conjugate ((quat quat)) (:result quat :abbrev qconj)
  (quat-conjugate! (quat) quat))

(defun* quat-magnitude-squared ((quat quat)) (:result single-float :abbrev qmagsq)
  (with-quat (q quat)
    (+ (* qw qw) (* qx qx) (* qy qy) (* qz qz))))

(defun* quat-magnitude ((quat quat)) (:result single-float :abbrev qmag)
  (sqrt (quat-magnitude-squared quat)))

(defun* quat-normalize! ((out-quat quat) (quat quat)) (:result quat :abbrev qnormalize!)
  (let ((magnitude (quat-magnitude quat)))
    (unless (zerop magnitude)
      (quat-scale! out-quat quat (/ magnitude))))
  out-quat)

(defun* quat-normalize ((quat quat)) (:result quat :abbrev qnormalize)
  (quat-normalize! (quat) quat))

(defun* quat-negate! ((out-quat quat) (quat quat)) (:result quat :abbrev qneg!)
  (quat-scale! out-quat quat -1.0))

(defun* quat-negate ((quat quat)) (:result quat :abbrev qneg)
  (quat-negate! (quat) quat))

(defun* quat-dot ((quat1 quat) (quat2 quat)) (:result single-float :abbrev qdot)
  (with-quats ((q1 quat1) (q2 quat2))
    (+ (* q1w q2w)
       (* q1x q2x)
       (* q1y q2y)
       (* q1z q2z))))

(defun* quat-inverse! ((out-quat quat) (quat quat)) (:result quat :abbrev qinv!)
  (quat-conjugate! out-quat quat)
  (quat-scale! out-quat out-quat (/ (quat-magnitude-squared quat)))
  out-quat)

(defun* quat-inverse ((quat quat)) (:result quat :abbrev qinv)
  (quat-inverse! (quat) quat))

(defun* quat-rotate! ((out-quat quat) (quat quat) (vec vec)) (:result quat :abbrev qrot!)
  (with-quats ((o out-quat) (q (qcp quat)))
    (with-vectors ((v (vscale vec 0.5))
                   (c (vec (cos vx) (cos vy) (cos vz)))
                   (s (vec (sin vx) (sin vy) (sin vz))))
      (psetf ow (- (* cx cy cz) (* sx sy sz))
             ox (+ (* sx cy cz) (* cx sy sz))
             oy (- (* cx sy cz) (* sx cy sz))
             oz (+ (* sx sy cz) (* cx cy sz)))
      (quat*! out-quat out-quat q))
    out-quat))

(defun* quat-rotate ((quat quat) (vec vec)) (:result quat :abbrev qrot)
  (quat-rotate! (quat) quat vec))

(defun* quat-to-vec! ((out-vec vec) (quat quat)) (:result vec :abbrev q->v!)
  (with-vector (v out-vec)
    (with-quat (q quat)
      (setf vx qx vy qy vz qz)))
  out-vec)

(defun* quat-to-vec ((quat quat)) (:result vec :abbrev q->v)
  (quat-to-vec! (vec) quat))

(defun* quat-from-vec! ((out-quat quat) (vec vec)) (:result quat :abbrev v->q!)
  (with-quat (q out-quat)
    (with-vector (v vec)
      (setf qw 1.0 qx vx qy vy qz vz)))
  out-quat)

(defun* quat-from-vec ((vec vec)) (:result quat :abbrev v->q)
  (quat-from-vec! (quat) vec))

(defun* quat-to-matrix! ((out-matrix matrix) (quat quat)) (:result matrix :abbrev q->m!)
  (with-matrix (o out-matrix)
    (with-quat (q quat)
      (let* ((s (/ 2 (quat-magnitude-squared quat)))
             (xs (* qx s))
             (ys (* qy s))
             (zs (* qz s))
             (xx (* qx xs))
             (xy (* qx ys))
             (xz (* qx zs))
             (yy (* qy ys))
             (yz (* qy zs))
             (zz (* qz zs))
             (wx (* qw xs))
             (wy (* qw ys))
             (wz (* qw zs)))
        (psetf o00 (- 1 (+ yy zz))
               o01 (- xy wz)
               o02 (+ xz wy)
               o03 0.0
               o10 (+ xy wz)
               o11 (- 1 (+ xx zz))
               o12 (- yz wx)
               o13 0.0
               o20 (- xz wy)
               o21 (+ yz wx)
               o22 (- 1 (+ xx yy))
               o23 0.0
               o30 0.0
               o31 0.0
               o32 0.0
               o33 1.0))))
  out-matrix)

(defun* quat-to-matrix ((quat quat)) (:result matrix :abbrev q->m)
  (quat-to-matrix! (matrix-identity) quat))

(defun* quat-from-matrix! ((out-quat quat) (matrix matrix)) (:result quat :abbrev m->q!)
  (with-quat (q out-quat)
    (with-matrix (m matrix)
      (let ((trace (matrix-trace matrix))
            (col1 (1+ (- m00 m11 m22)))
            (col2 (1+ (- m11 m00 m22)))
            (col3 (1+ (- m22 m00 m11)))
            (s 0.0))
        (cond
          ((plusp trace)
           (setf s (/ 0.5 (sqrt trace))
                 qw (/ 0.25 s)
                 qx (* (- m21 m12) s)
                 qy (* (- m02 m20) s)
                 qz (* (- m10 m01) s)))
          ((and (>= col1 col2) (>= col1 col3))
           (setf s (/ 0.5 (sqrt col1))
                 qw (* (- m21 m12) s)
                 qx (/ 0.25 s)
                 qy (* (+ m10 m01) s)
                 qz (* (+ m02 m20) s)))
          ((and (>= col2 col1) (>= col2 col3))
           (setf s (/ 0.5 (sqrt col2))
                 qw (* (- m02 m20) s)
                 qx (* (+ m01 m10) s)
                 qy (/ 0.25 s)
                 qz (* (+ m12 m21) s)))
          (t
           (setf s (/ 0.5 (sqrt col3))
                 qw (* (- m10 m01) s)
                 qx (* (+ m02 m20) s)
                 qy (* (+ m12 m21) s)
                 qz (/ 0.25 s)))))))
  out-quat)

(defun* quat-from-matrix ((matrix matrix)) (:result quat :abbrev m->q)
  (quat-from-matrix! (quat) matrix))

(defun* quat-slerp! ((out-quat quat) (quat1 quat) (quat2 quat) (coeff single-float)) (:result quat :abbrev qslerp!)
  (with-quats ((o out-quat) (q1 (quat-normalize quat1)) (q2 (quat-normalize quat2)))
    (let ((dot (quat-dot q1 q2))
          (q2 q2))
      (when (minusp dot)
        (quat-negate! q2 q2)
        (setf dot (- dot)))
      (if (> (abs dot) 0.9995)
          (psetf ow (lerp coeff q1w q2w)
                 ox (lerp coeff q1x q2x)
                 oy (lerp coeff q1y q2y)
                 oz (lerp coeff q1z q2z))
          (let* ((angle (acos (clamp dot 0 1)))
                 (sin-angle (sin angle))
                 (scale1 (/ (sin (* angle (- 1 coeff))) sin-angle))
                 (scale2 (/ (sin (* coeff angle)) sin-angle)))
            (psetf ow (+ (* q1w scale1) (* q2w scale2))
                   ox (+ (* q1x scale1) (* q2x scale2))
                   oy (+ (* q1y scale1) (* q2y scale2))
                   oz (+ (* q1z scale1) (* q2z scale2)))))))
  (quat-normalize! out-quat out-quat)
  out-quat)

(defun* quat-slerp ((quat1 quat) (quat2 quat) (coeff single-float)) (:result quat :abbrev qslerp)
  (quat-slerp! (quat) quat1 quat2 coeff))
