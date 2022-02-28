(in-package #:mfiano.math.origin.geometry)

(u:fn-> raycast-sphere (ray:ray sphere:sphere) (or u:f32 null))
(defun raycast-sphere (ray sphere)
  (declare (optimize speed))
  (let* ((e (v3:- (sphere:origin sphere) (ray:origin ray)))
         (radius-squared (expt (sphere:radius sphere) 2))
         (e-squared (v3:length-squared e))
         (a (v3:dot e (ray:direction ray)))
         (b (- e-squared (* a a)))
         (f (sqrt (abs (- radius-squared b)))))
    (cond
      ((minusp (- radius-squared b))
       nil)
      ((< e-squared radius-squared)
       (+ a f))
      (t
       (- a f)))))

(u:fn-> raycast-aabb (ray:ray aabb:aabb) (or u:f32 null))
(defun raycast-aabb (ray aabb)
  (declare (optimize speed))
  (v3:with-components ((min- (aabb:min aabb))
                       (max- (aabb:max aabb))
                       (o (ray:origin ray))
                       (d (ray:direction ray)))
    (let* ((dx (if (com:= dx 0f0) 1f-7 dx))
           (dy (if (com:= dy 0f0) 1f-7 dy))
           (dz (if (com:= dz 0f0) 1f-7 dz))
           (t1 (/ (- min-x ox) dx))
           (t2 (/ (- max-x ox) dx))
           (t3 (/ (- min-y oy) dy))
           (t4 (/ (- max-y oy) dy))
           (t5 (/ (- min-z oz) dz))
           (t6 (/ (- max-z oz) dz))
           (t-min (max (max (min t1 t2) (min t3 t4)) (min t5 t6)))
           (t-max (min (min (max t1 t2) (max t3 t4)) (max t5 t6))))
      (cond
        ((or (minusp t-max)
             (> t-min t-max))
         nil)
        ((minusp t-min)
         t-max)
        (t
         t-min)))))
