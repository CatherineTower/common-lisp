(in-package #:box.math.test)

(setf *default-test-function* #'equalp)

(plan 82)

(diag "accessors")
(let ((q (q:make 1 2 3 4)))
  (is (q:w q) 1)
  (is (q:x q) 2)
  (is (q:y q) 3)
  (is (q:z q) 4)
  (psetf (q:w q) 10.0 (q:x q) 20.0 (q:y q) 30.0 (q:z q) 40.0)
  (is (q:w q) 10)
  (is (q:x q) 20)
  (is (q:y q) 30)
  (is (q:z q) 40))

(diag "identity")
(let ((q (q:id))
      (r (q:make 1 0 0 0)))
  (is q r)
  (is q:+id+ r))

(diag "equality")
(let ((q1 (q:make 0.25889468 -0.4580922 0.6231675 0.34003425))
      (q2 (q:make 1e-8 1e-8 1e-8 1e-8)))
  (ok (q:= q1 q1))
  (ok (q:~ (q:+ q1 q2) q1))
  (ok (q:~ q2 (q:zero))))

(diag "copy")
(let ((q (q:make 0.34003425 -0.4920528 0.8754709 0.6535034))
      (o (q:zero)))
  (is (q:copy! o q) q)
  (is o q)
  (is (q:copy q) q)
  (isnt q (q:copy q) :test #'eq))

(diag "addition")
(let ((q1 (q:make -0.11586404 -0.47056317 0.23266816 -0.6098385))
      (q2 (q:make -0.81111765 0.11399269 -0.24647212 -0.812474))
      (r (q:make -0.9269817 -0.35657048 -0.013803959 -1.4223125))
      (o (q:zero)))
  (is (q:+! o q1 q2) r)
  (is o r)
  (is (q:+ q1 q2) r))

(diag "subtraction")
(let ((q1 (q:make 0.1688292 0.5137224 0.83796954 -0.9853494))
      (q2 (q:make -0.3770373 0.19171429 -0.8571534 0.4451759))
      (r (q:make 0.5458665 0.32200813 1.695123 -1.4305253))
      (o (q:zero)))
  (is (q:-! o q1 q2) r)
  (is o r)
  (is (q:- q1 q2) r))

(diag "multiplication")
(let ((q1 (q:make 1 2 3 4))
      (q2 (q:make 10 20 30 40))
      (q3 q:+id+)
      (r (q:make -280 40 60 80))
      (rot-x (q:rotate q:+id+ (v3:make (/ pi 3) 0 0)))
      (rot-y (q:rotate q:+id+ (v3:make 0 (/ pi 4) 0)))
      (rot-xy (q:rotate q:+id+ (v3:make (/ pi 3) (/ pi 4) 0)))
      (o (q:zero)))
  (is (q:*! o q1 q2) r)
  (is o r)
  (is (q:* q1 q3) q1)
  (is (q:* q3 q1) q1)
  (is (q:* q1 q2) (q:* q2 q1))
  (is (q:* rot-x rot-y) rot-xy)
  (isnt (q:* rot-x rot-y) (q:* rot-y rot-x)))

(diag "scalar product")
(let ((q (q:make 0.25889468 -0.4580922 0.6231675 0.34003425))
      (r (q:make -0.12738985 0.22540556 -0.30663133 -0.1673148))
      (o (q:zero)))
  (is (q:scale! o q -0.4920528) r)
  (is o r)
  (is (q:scale q -0.4920528) r))

(diag "cross product")
(let ((q1 (q:make 0.8660254 0.5 0 0))
      (q2 (q:make 0.8660254 0 0.5 0))
      (r (q:make 0.75 0 0.4330127 0.25))
      (o (q:zero)))
  (is (q:cross! o q1 q2) r)
  (is o r)
  (is (q:cross q1 q2) r))

(diag "conjugate")
(let ((q (q:make 0.8754709 0.6535034 -0.11586404 -0.47056317))
      (r (q:make 0.8754709 -0.6535034 0.11586404 0.47056317))
      (o (q:zero)))
  (is (q:conjugate! o q) r)
  (is o r)
  (is (q:conjugate q) r))

(diag "magnitude")
(is (q:magnitude q:+id+) 1)
(is (q:magnitude (q:make 0.23266816 -0.6098385 -0.81111765 0.11399269)) 1.0473508)

(diag "normalize")
(let ((q (q:make -0.24647212 -0.812474 0.9715252 0.8300271))
      (r (q:make -0.16065533 -0.52958643 0.6332591 0.5410279))
      (o (q:zero)))
  (is (q:normalize! o q) r)
  (is o r)
  (is (q:normalize q) r)
  (is (q:normalize (q:make 2 0 0 0)) q:+id+))

(diag "negate")
(let ((q (q:make 0.9858451 0.85955405 0.8707795 -0.36954784))
      (r (q:make -0.9858451 -0.85955405 -0.8707795 0.36954784))
      (o (q:zero)))
  (is (q:negate! o q) r)
  (is o r)
  (is (q:negate q) r))

(diag "dot product")
(let ((q1 (q:make -0.55014205 0.66294193 -0.44094658 0.1688292))
      (q2 (q:make 0.5137224 0.83796954 -0.9853494 -0.3770373)))
  (is (q:dot q1 q2) 0.64373636))

(diag "inverse")
(let ((q (q:make 0.19171429 -0.8571534 0.4451759 0.39651704))
      (r (q:make 0.17012934 0.76064724 -0.39505392 -0.35187355))
      (o (q:zero)))
  (is (q:inverse! o q) r)
  (is o r)
  (is (q:inverse q) r))

(diag "rotate")
(let ((oqx (q:id))
      (oqy (q:id))
      (oqz (q:id))
      (rqx (q:make 0.86602545 0.5 0 0))
      (rqy (q:make 0.86602545 0 0.5 0))
      (rqz (q:make 0.86602545 0 0 0.5))
      (vx (v3:make (/ pi 3) 0 0))
      (vy (v3:make 0 (/ pi 3) 0))
      (vz (v3:make 0 0 (/ pi 3))))
  (ok (q:~ (q:rotate! oqx q:+id+ vx) rqx))
  (ok (q:~ (q:rotate! oqy q:+id+ vy) rqy))
  (ok (q:~ (q:rotate! oqz q:+id+ vz) rqz))
  (ok (q:~ oqx rqx))
  (ok (q:~ oqy rqy))
  (ok (q:~ oqz rqz))
  (ok (q:~ (q:rotate q:+id+ vx) rqx))
  (ok (q:~ (q:rotate q:+id+ vy) rqy))
  (ok (q:~ (q:rotate q:+id+ vz) rqz)))

(diag "vec3 conversion")
(let* ((q (q:make 0.3628688 0.9540863 0.017128706 0.32979298))
       (r (v3:make (q:x q) (q:y q) (q:z q)))
       (o (v3:zero)))
  (is (q:to-vec3! o q) r)
  (is o r)
  (is (q:to-vec3 q) r))
(let* ((v (v3:make 0.2571392 0.19932675 -0.025900126))
       (r (q:make 0 (v3:x v) (v3:y v) (v3:z v)))
       (o (q:zero)))
  (is (q:from-vec3! o v) r)
  (is o r)
  (is (q:from-vec3 v) r))

(diag "vec4 conversion")
(let* ((q (q:make 0.3628688 0.9540863 0.017128706 0.32979298))
       (r (v4:make (q:w q) (q:x q) (q:y q) (q:z q)))
       (o (v4:zero)))
  (is (q:to-vec4! o q) r)
  (is o r)
  (is (q:to-vec4 q) r))
(let* ((v (v4:make 0.2571392 0.19932675 -0.025900126 0.8267517))
       (r (q:make (v4:x v) (v4:y v) (v4:z v) (v4:w v)))
       (o (q:zero)))
  (is (q:from-vec4! o v) r)
  (is o r)
  (is (q:from-vec4 v) r))

(diag "matrix conversion")
(let ((q (q:rotate q:+id+ (v3:make (/ pi 3) 0 0)))
      (qo (q:zero))
      (r (m4:make 1 0 0 0 0 0.5 -0.86602545 0 0 0.86602545 0.5 0 0 0 0 1))
      (mo (m4:id)))
  (ok (m4:~ (q:to-mat4! mo q) r))
  (ok (m4:~ mo r))
  (ok (m4:~ (q:to-mat4 q) r))
  (ok (q:~ (q:from-mat4! qo r) q))
  (ok (q:~ qo q))
  (ok (q:~ (q:from-mat4 r) q)))

(diag "spherical linear interpolation")
(let ((q1 (q:make -0.15230274 0.7359729 -0.27456188 -0.28505945))
      (q2 (q:make 0.594954 0.030960321 -0.037411213 -0.02747035))
      (r (q:make -0.5157237 0.4865686 -0.16367096 -0.17777666))
      (o (q:zero)))
  (is (q:slerp! o q1 q2 0.5) r)
  (is o r)
  (is (q:slerp q1 q2 0.5) r))

(finalize)
