(in-package #:cl-user)

(defpackage #:%coherent-noise.generators.fbm-4d
  (:local-nicknames
   (#:gen #:%coherent-noise.generators)
   (#:int #:%coherent-noise.internal)
   (#:rng #:seedable-rng)
   (#:u #:golden-utils))
  (:use #:cl))

(in-package #:%coherent-noise.generators.fbm-4d)

(defstruct (gen:fbm-4d
            (:include int:sampler)
            (:conc-name "")
            (:predicate nil)
            (:copier nil))
  (sources (vector) :type simple-vector)
  (scale 1.0 :type u:f32)
  (octaves 4 :type (integer 1 32))
  (frequency 1.0 :type u:f32)
  (lacunarity 2.0 :type u:f32)
  (persistence 0.5 :type u:f32))

(defun get-scale-factor (octaves persistence)
  (loop :for i :below octaves
        :sum (expt persistence i) :into result
        :finally (return (float result 1f0))))

(defun gen:fbm-4d (&key seed (generator #'gen:perlin-4d) (octaves 4) (frequency 1.0)
                     (lacunarity 2.0) (persistence 0.5))
  (unless (typep octaves '(integer 1 32))
    (error 'int:invalid-fractal-octave-count :sampler-type 'fbm-4d :value octaves))
  (unless (realp frequency)
    (error 'int:invalid-real-argument :sampler-type 'fbm-4d :argument :frequency :value frequency))
  (unless (realp lacunarity)
    (error 'int:invalid-real-argument
           :sampler-type 'fbm-4d
           :argument :lacunarity
           :value lacunarity))
  (unless (realp persistence)
    (error 'int:invalid-real-argument
           :sampler-type 'fbm-4d
           :argument :persistence
           :value persistence))
  (let ((rng (int::make-rng seed)))
    (make-fbm-4d :rng rng
                 :sources (int::make-fractal-sources generator rng octaves)
                 :scale (get-scale-factor octaves persistence)
                 :octaves octaves
                 :frequency (float frequency 1f0)
                 :lacunarity (float lacunarity 1f0)
                 :persistence (float persistence 1f0))))

(defmethod int:sample ((sampler gen:fbm-4d) x &optional (y 0d0) (z 0d0) (w 0d0))
  (loop :with sources = (sources sampler)
        :with frequency = (frequency sampler)
        :with lacunarity = (lacunarity sampler)
        :with persistence = (persistence sampler)
        :for i :below (octaves sampler)
        :for amplitude = 1.0 :then (* amplitude persistence)
        :for fx = (* x frequency) :then (* fx lacunarity)
        :for fy = (* y frequency) :then (* fy lacunarity)
        :for fz = (* z frequency) :then (* fz lacunarity)
        :for fw = (* w frequency) :then (* fw lacunarity)
        :for sample = (int:sample (aref sources i) fx fy fz fw)
        :sum (* sample amplitude) :into result
        :finally (return (/ result (scale sampler)))))
