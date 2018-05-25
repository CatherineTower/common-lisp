(in-package :umbra.hashing)

;;; Blum Blum Shub
;;; Marc Olano
;;; http://www.cs.umbc.edu/~olano/papers/mNoise.pdf

(defun-gpu blum-blum-shub/coord-prepare ((x :vec4))
  (- x (* (floor (* x (/ 61.0))) 61.0)))

(defun-gpu blum-blum-shub/permute-and-resolve ((x :vec4))
  (fract (* x x (/ 61.0))))

(defun-gpu blum-blum-shub/permute ((x :vec4))
  (* (blum-blum-shub/permute-and-resolve x) 61.0))

(defun-gpu blum-blum-shub ((grid-cell :vec2))
  (let* ((hash-coord (blum-blum-shub/coord-prepare (vec4 grid-cell (1+ grid-cell))))
         (hash (blum-blum-shub/permute (* (.xzxz hash-coord) 7.0))))
    (blum-blum-shub/permute-and-resolve (+ hash (.yyww hash-coord)))))

(defun-gpu blum-blum-shub/hq ((grid-cell :vec2))
  (let* ((hash-coord (blum-blum-shub/coord-prepare (vec4 grid-cell (1+ grid-cell))))
         (hash (blum-blum-shub/permute (* (.xzxz hash-coord) 7.0))))
    (blum-blum-shub/permute-and-resolve
     (+ (blum-blum-shub/permute (+ hash (.yyww hash-coord)))
        (.xzxz hash-coord)))))

(defun-gpu blum-blum-shub ((grid-cell :vec3))
  (decf (.xyz grid-cell) (* (floor (* (.xyz grid-cell) (/ 60.0))) 60.0))
  (let* ((grid-cell-inc1 (* (step grid-cell (vec3 58.5)) (1+ grid-cell)))
         (p (blum-blum-shub/permute
             (+ (* (blum-blum-shub/permute
                    (.xyxy (vec2 (.x grid-cell) (.x grid-cell-inc1))))
                   1.0)
                (.xxyy (vec2 (.y grid-cell) (.y grid-cell-inc1))))))
         (low-z (blum-blum-shub/permute-and-resolve (+ p (.z grid-cell))))
         (high-z (blum-blum-shub/permute-and-resolve (+ p (.z grid-cell-inc1)))))
    (values low-z high-z)))

;;; Permutation polynomial
;;; Stefan Gustavson and Ian McEwan
;;; http://github.com/ashima/webgl-noise
;;; http://www.itn.liu.se/~stegu/GLSL-cellular

(defun-gpu permutation-polynomial/coord-prepare ((x :vec3))
  (- x (* (floor (* x (/ 289.0))) 289.0)))

(defun-gpu permutation-polynomial/coord-prepare ((x :vec4))
  (- x (* (floor (* x (/ 289.0))) 289.0)))

(defun-gpu permutation-polynomial/permute ((x :vec4))
  (* (fract (* x (+ (* (/ 34.0 289.0) x) (/ 289.0)))) 289.0))

(defun-gpu permutation-polynomial/resolve ((x :vec4))
  (fract (* x (/ 7.0 288.0))))

(defun-gpu permutation-polynomial ((grid-cell :vec2))
  (let ((hash-coord (permutation-polynomial/coord-prepare (vec4 grid-cell (1+ grid-cell)))))
    (permutation-polynomial/resolve
     (permutation-polynomial/permute
      (+ (permutation-polynomial/permute (.xzxz hash-coord))
         (.yyww hash-coord))))))

(defun-gpu permutation-polynomial ((grid-cell :vec3))
  (let* ((grid-cell (permutation-polynomial/coord-prepare grid-cell))
         (grid-cell-inc1 (* (step grid-cell (vec3 287.5)) (1+ grid-cell)))
         (x (.xyxy (vec2 (.x grid-cell) (.x grid-cell-inc1))))
         (y (.xxyy (vec2 (.y grid-cell) (.y grid-cell-inc1))))
         (high-z (+ (permutation-polynomial/permute (+ (permutation-polynomial/permute x) y))))
         (low-z (permutation-polynomial/resolve
                 (permutation-polynomial/permute (+ high-z (.z grid-cell))))))
    (setf high-z (permutation-polynomial/resolve
                  (permutation-polynomial/permute (+ high-z (.z grid-cell-inc1)))))
    (values low-z high-z)))

;;; FAST32
;;; Brian Sharpe
;;; https://briansharpe.wordpress.com/2011/11/15/a-fast-and-simple-32bit-floating-point-hash-function/

(defun-gpu fast32 ((grid-cell :vec2))
  (let ((p (vec4 grid-cell (1+ grid-cell))))
    (setf p (- p (* (floor (* p (/ 71.0))) 71.0)))
    (incf p (vec4 26 161 26 161))
    (multf p p)
    (fract (* (.xzxz p) (.yyww p) (/ 951.135664)))))

(defun-gpu fast32 ((grid-cell :vec3))
  (decf grid-cell (* (floor (* grid-cell (/ 69.0))) 69.0))
  (let* ((grid-cell-inc1 (* (step grid-cell (vec3 67.5)) (1+ grid-cell)))
         (p (+ (vec4 (.xy grid-cell) (.xy grid-cell-inc1))
               (vec4 50 161 50 161)))
         (high-z (vec4 0)))
    (multf p p)
    (setf p (* (.xzxz p) (.yyww p))
          (.xy high-z) (/ (+ 635.298681 (* (vec2 (.z grid-cell) (.z grid-cell-inc1))  48.600388))))
    (values (fract (* p (.x high-z)))
            (fract (* p (.y high-z))))))

;;; FAST32_2
;;; Brian Sharpe
;;; https://github.com/BrianSharpe/GPU-Noise-Lib/blob/master/gpu_noise_lib.glsl

(defun-gpu fast32-2 ((grid-cell :vec2))
  (let ((p (vec4 grid-cell (1+ grid-cell))))
    (setf p (+ (* (- p (* (floor (* p (/ 69.0))) 69.0))
                  (.xyxy (vec2 2.009842 1.372549)))
               (.xyxy (vec2 403.839172 377.242706))))
    (multf p p)
    (fract (* (.xzxz p) (.yyww p) (/ 32745.708984)))))

(defun-gpu fast32-2 ((grid-cell :vec3))
  (decf grid-cell (* (floor (* grid-cell (/ 69.0))) 69.0))
  (let ((offset (vec3 55.882355 63.167774 52.941177))
        (scale (vec3 0.235142 0.205890 0.216449))
        (grid-cell-inc1 (* (step grid-cell (vec3 67.5)) (1+ grid-cell)))
        (x (vec4 0)))
    (setf grid-cell (+ (* grid-cell scale) offset)
          grid-cell-inc1 (+ (* grid-cell-inc1 scale) offset))
    (multf grid-cell grid-cell)
    (multf grid-cell-inc1 grid-cell-inc1)
    (setf x (* (vec4 (.x grid-cell) (.x grid-cell-inc1) (.x grid-cell) (.x grid-cell-inc1))
               (vec4 (.yy grid-cell) (.yy grid-cell-inc1))))
    (values (fract (* x (.z grid-cell) (/ 69412.070313)))
            (fract (* x (.z grid-cell-inc1) (/ 69412.070313))))))

(defun-gpu fast32-2 ((grid-cell :vec4))
  (decf grid-cell (* (floor (* grid-cell (/ 69.0))) 69.0))
  (let ((offset (vec4 16.841230 18.774548 16.873274 13.664607))
        (scale (vec4 0.102007 0.114473 0.139651 0.084550))
        (grid-cell-inc1 (* (step grid-cell (vec4 67.5)) (1+ grid-cell)))
        (x (vec4 0))
        (z (vec4 0)))
    (setf grid-cell (+ (* grid-cell scale) offset)
          grid-cell-inc1 (+ (* grid-cell-inc1 scale) offset))
    (multf grid-cell grid-cell)
    (multf grid-cell-inc1 grid-cell-inc1)
    (setf x (* (vec4 (.x grid-cell) (.x grid-cell-inc1) (.x grid-cell) (.x grid-cell-inc1))
               (vec4 (.yy grid-cell) (.yy grid-cell-inc1)))
          z (* (vec4 (.z grid-cell) (.z grid-cell-inc1) (.z grid-cell) (.z grid-cell-inc1))
               (vec4 (.ww grid-cell) (.ww grid-cell-inc1))
               (/ 47165.636719)))
    (values (fract (* x (.x z)))
            (fract (* x (.y z)))
            (fract (* x (.z z)))
            (fract (* x (.w z))))))
