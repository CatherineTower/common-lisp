(in-package :box.math.test)

(setf *default-test-function* #'equalp)

(plan 107)

(diag "accessors")
(let ((v (v3:make 1 2 3)))
  (is (v3:x v) 1)
  (is (v3:y v) 2)
  (is (v3:z v) 3)
  (psetf (v3:x v) 10.0
         (v3:y v) 20.0
         (v3:z v) 30.0)
  (is (v3:x v) 10)
  (is (v3:y v) 20)
  (is (v3:z v) 30))

(diag "copy")
(let ((v (v3:make 1 2 3))
      (o (v3:zero)))
  (is (v3:copy! o v) v)
  (is o v)
  (is (v3:copy v) v)
  (isnt v (v3:copy v) :test #'eq))

(diag "clamp")
(let ((v (v3:make -1.5185602 0.3374052 1.5218115))
      (r (v3:make -1 0.3374052 1))
      (o (v3:zero)))
  (is (v3:clamp! o v :min -1.0 :max 1.0) r)
  (is o r)
  (is (v3:clamp v :min -1.0 :max 1.0) r)
  (is (v3:clamp v) v))

(diag "stabilize")
(let ((v (v3:make 1e-8 1e-8 1e-8))
      (o (v3:zero)))
  (is (v3:stabilize! o v) v3:+zero+)
  (is o v3:+zero+)
  (is (v3:stabilize v) v3:+zero+))

(diag "zero")
(let ((v (v3:make -0.72470546 0.57963276 0.8775625)))
  (is (v3:zero! v) v3:+zero+)
  (is v v3:+zero+)
  (is (v3:zero) v3:+zero+))

(diag "list conversion")
(is (v3:to-list (v3:make 1 2 3)) '(1 2 3))
(is (v3:from-list '(1 2 3)) (v3:make 1 2 3))

(diag "equality")
(let ((v1 (v3:make 0.8598654 -0.4803753 -0.3822465))
      (v2 (v3:make 1e-8 1e-8 1e-8)))
  (ok (v3:= v1 v1))
  (ok (v3:~ (v3:+ v1 v2) v1))
  (ok (v3:~ v2 v3:+zero+)))

(diag "addition")
(let ((v1 (v3:make 0.4110496 -0.87680984 -0.62870455))
      (v2 (v3:make 0.1166687 0.42538047 0.7360425))
      (r (v3:make 0.5277183 -0.45142937 0.10733795))
      (o (v3:zero)))
  (is (v3:+! o v1 v2) r)
  (is o r)
  (is (v3:+ v1 v2) r)
  (is (v3:+ v1 v3:+zero+) v1)
  (is (v3:+ v3:+zero+ v2) v2))

(diag "subtraction")
(let ((v1 (v3:make -0.16772795 -0.7287135 -0.8905144))
      (v2 (v3:make -0.69658303 0.6168339 -0.7841997))
      (r (v3:make 0.5288551 -1.3455474 -0.10631466))
      (o (v3:zero)))
  (is (v3:-! o v1 v2) r)
  (is o r)
  (is (v3:- v1 v2) r)
  (is (v3:- v1 v3:+zero+) v1))

(diag "hadamard product")
(let ((v1 (v3:make -0.6219859 -0.80110574 -0.06880522))
      (v2 (v3:make 0.6687746 -0.21906853 0.14335585))
      (r (v3:make -0.4159684 0.17549706 -0.00986363))
      (o (v3:zero)))
  (is (v3:*! o v1 v2) r)
  (is o r)
  (is (v3:* v1 v2) r)
  (is (v3:* v1 v3:+zero+) v3:+zero+)
  (is (v3:* v3:+zero+ v2) v3:+zero+))

(diag "hadamard quotient")
(let ((v1 (v3:make 0.9498384 0.4066379 -0.72961855))
      (v2 (v3:make 0.32331443 0.17439032 -0.65894365))
      (r (v3:make 2.9378164 2.3317688 1.1072549))
      (o (v3:zero)))
  (is (v3:/! o v1 v2) r)
  (is o r)
  (is (v3:/ v1 v2) r)
  (is (v3:/ v1 v3:+zero+) v3:+zero+)
  (is (v3:/ v3:+zero+ v2) v3:+zero+))

(diag "scalar product")
(let ((v (v3:make 0.82007027 -0.53582144 0.11559081))
      (r (v3:make 0.7762602 -0.5071966 0.10941568))
      (o (v3:zero)))
  (is (v3:scale! o v 0.94657767) r)
  (is o r)
  (is (v3:scale v 0.94657767) r))

(diag "dot product")
(is (v3:dot (v3:make -0.21361923 0.39387107 0.0043354034)
            (v3:make -0.13104868 0.399935 0.62945867))
    0.1882463)
(is (v3:dot (v3:make 1 0 0) (v3:make 0 1 0)) 0)
(is (v3:dot (v3:make 1 0 0) (v3:make 0 0 1)) 0)
(is (v3:dot (v3:make 0 1 0) (v3:make 0 0 1)) 0)
(is (v3:dot (v3:make 1 0 0) (v3:make 1 0 0)) 1)
(is (v3:dot (v3:make 1 0 0) (v3:make -1 0 0)) -1)

(diag "magnitude")
(is (v3:magnitude v3:+zero+) 0)
(is (v3:magnitude (v3:make 1 0 0)) 1)
(is (v3:magnitude (v3:make 0.32979298 0.2571392 0.19932675)) 0.46326572)

(diag "normalize")
(let ((v (v3:make -0.6589291 0.23270178 -0.1047523))
      (r (v3:make -0.9325095 0.3293171 -0.14824435))
      (o (v3:zero)))
  (is (v3:normalize! o v) r)
  (is o r)
  (is (v3:normalize v) r)
  (is (v3:normalize (v3:make 2 0 0)) (v3:make 1 0 0))
  (is (v3:normalize (v3:make 0 2 0)) (v3:make 0 1 0))
  (is (v3:normalize (v3:make 0 0 2)) (v3:make 0 0 1)))

(diag "round")
(let ((v (v3:make -0.70498157 0.3615427 0.50702953))
      (r (v3:make -1 0 1))
      (o (v3:zero)))
  (is (v3:round! o v) r)
  (is o r)
  (is (v3:round v) r))

(diag "abs")
(let ((v (v3:make -0.4241562 -0.52400947 0.82413125))
      (r (v3:make 0.4241562 0.52400947 0.82413125))
      (o (v3:zero)))
  (is (v3:abs! o v) r)
  (is o r)
  (is (v3:abs v) r))

(diag "negate")
(let ((v (v3:make 0.7823446 0.95027566 -0.4147482))
      (r (v3:make -0.7823446 -0.95027566 0.4147482))
      (o (v3:zero)))
  (is (v3:negate! o v) r)
  (is o r)
  (is (v3:negate v) r))

(diag "cross product")
(let ((v1 (v3:make 1 0 0))
      (v2 (v3:make 0 1 0))
      (o (v3:zero)))
  (is (v3:cross! o v1 v2) (v3:make 0 0 1))
  (is o (v3:make 0 0 1))
  (is (v3:cross (v3:make 1 0 0) (v3:make 0 1 0)) (v3:make 0 0 1))
  (is (v3:cross (v3:make 1 0 0) (v3:make 0 0 1)) (v3:make 0 -1 0))
  (is (v3:cross (v3:make 0 1 0) (v3:make 1 0 0)) (v3:make 0 0 -1))
  (is (v3:cross (v3:make 0 1 0) (v3:make 0 0 1)) (v3:make 1 0 0))
  (is (v3:cross (v3:make 0 0 1) (v3:make 1 0 0)) (v3:make 0 1 0))
  (is (v3:cross (v3:make 0 0 1) (v3:make 0 1 0)) (v3:make -1 0 0)))

(diag "angle")
(let ((angle (v3:angle (v3:make 0 1 0) (v3:make 1 0 1))))
  (ok (<= (abs (- angle (/ pi 2))) 1e-7)))
(let ((angle (v3:angle (v3:make 1 1 0) (v3:make 1 0 1))))
  (ok (<= (abs (- angle (/ pi 3))) 1e-7)))
(let ((angle (v3:angle (v3:make 1 0 0) (v3:make 1 1 0))))
  (ok (<= (abs (- angle (/ pi 4))) 1e-7)))

(diag "zero vector predicate")
(ok (v3:zerop v3:+zero+))
(ok (v3:zerop (v3:make 0 0 0)))

(diag "direction equality")
(ok (v3:direction= (v3:make 0.0073252916 0 0) (v3:make 0.31148136 0 0)))
(ok (v3:direction= (v3:make 0 0.6982585 0) (v3:make 0 0.72258794 0)))
(ok (v3:direction= (v3:make 0 0 0.86798644) (v3:make 0 0 42384863)))

(diag "parallelity")
(ok (v3:parallelp (v3:make 0.6883507 0 0) (v3:make -0.37808847 0 0)))
(ok (v3:parallelp (v3:make 0 -0.31525326 0) (v3:make 0 0.20765233 0)))
(ok (v3:parallelp (v3:make 0 0 0.18911958) (v3:make 0 0 -0.17581582)))

(diag "linear interpolation")
(let ((v1 (v3:make 0.74485755 0.092342734 0.2982279))
      (v2 (v3:make 0.19426346 0.9881369 0.64691556))
      (r (v3:make 0.4695605 0.5402398 0.47257173))
      (o (v3:zero)))
  (is (v3:lerp! o v1 v2 0.5) r)
  (is o r)
  (is (v3:lerp v1 v2 0.5) r)
  (is (v3:lerp v1 v2 0.0) v1)
  (is (v3:lerp v1 v2 1.0) v2))

(diag "comparators")
(let ((v1 (v3:make 0.34003425 -0.4920528 0.8754709))
      (v2 (v3:make 0.6535034 -0.11586404 -0.47056317))
      (v3 (v3:make 0.9715252 0.8300271 0.9858451))
      (v4 (v3:make 1 2 3))
      (v5 (v3:make 2 3 4)))
  (ok (v3:< v2 v3))
  (ok (v3:<= v4 v4))
  (ok (v3:<= v4 v5))
  (ok (v3:> v3 v1))
  (ok (v3:>= v4 v4))
  (ok (v3:>= v5 v4)))

(diag "component-wise minimum")
(let* ((v1 (v3:make 0.98117805 0.06889212 0.32721102))
       (v2 (v3:make 0.8774886 0.25179327 0.76311684))
       (r (v3:make (v3:x v2) (v3:y v1) (v3:z v1)))
       (o (v3:zero)))
  (is (v3:min! o v1 v2) r)
  (is o r)
  (is (v3:min v1 v2) r))

(diag "component-wise maximum")
(let* ((v1 (v3:make 0.64380646 0.38965714 0.2503655))
       (v2 (v3:make 0.6341989 0.5274999 0.90044403))
       (r (v3:make (v3:x v1) (v3:y v2) (v3:z v2)))
       (o (v3:zero)))
  (is (v3:max! o v1 v2) r)
  (is o r)
  (is (v3:max v1 v2) r))

(finalize)
