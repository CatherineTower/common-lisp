(in-package #:cl-user)

;;;; 3-dimensional "hybrid" multifractal fractal noise generator

(defpackage #:%mfiano.graphics.cricket.generators.hybrid-multifractal-3d
  (:local-nicknames
   (#:gen #:%mfiano.graphics.cricket.generators)
   (#:int #:%mfiano.graphics.cricket.internal)
   (#:rng #:mfiano.misc.rng)
   (#:u #:mfiano.misc.utils))
  (:use #:cl))

(in-package #:%mfiano.graphics.cricket.generators.hybrid-multifractal-3d)

(defstruct (gen:hybrid-multifractal-3d
            (:include int:sampler)
            (:conc-name "")
            (:predicate nil)
            (:copier nil))
  (sources (vector) :type simple-vector)
  (scale 1.0 :type u:f32)
  (octaves 4 :type (integer 1 32))
  (frequency 1.0 :type u:f32)
  (lacunarity 2.0 :type u:f32)
  (persistence 0.25 :type u:f32))

(defun get-scale-factor (octaves persistence)
  (loop :with persistence = persistence
        :with result = persistence
        :for i :from 1 :below octaves
        :for amplitude = persistence :then (* amplitude persistence)
        :for weight = result :then (max weight 1)
        :for sample = amplitude
        :do (setf weight (* weight sample))
            (incf result weight)
        :finally (return (float result 1f0))))

(defun gen:hybrid-multifractal-3d (&key seed (generator #'gen:open-simplex2s-3d) (octaves 4)
                                     (frequency 1.0) (lacunarity 2.0) (persistence 0.25))
  "Construct a sampler that, when sampled, outputs the application of multiple octaves of a
3-dimensional hybrid multifractal noise, using the supplied `generator` function to construct each
octave's sampler.

`seed`: A string used to seed the random number generator for this sampler, or NIL. If a seed is not
supplied, one will be generated automatically which will negatively affect the reproducibility of
the noise (optional, default: NIL).

`generator`: a function object pointing to one of the built-in 3-dimensional generators that is used
to construct a different sampler, each with a different seed, for each octave (optional, default
`#'open-simplex2s-3d`).

`octaves`: An integer between 1 and 32, denoting the number of octaves to apply (optional, default:
4).

`frequency`: The frequency of the first octave's signal (optional, default: 1.0).

`lacunarity`: A multiplier that determines how quickly the frequency increases for successive
octaves (optional, default: 2.0).

`persistence`: A multiplier that determines how quickly the amplitude diminishes for successive
octaves (optional, default 0.25)."
  (unless (typep octaves '(integer 1 32))
    (error 'int:invalid-fractal-octave-count :sampler-type 'hybrid-multifractal-3d :value octaves))
  (unless (realp frequency)
    (error 'int:invalid-real-argument
           :sampler-type 'hybrid-multifractal-3d
           :argument :frequency
           :value frequency))
  (unless (realp lacunarity)
    (error 'int:invalid-real-argument
           :sampler-type 'hybrid-multifractal-3d
           :argument :lacunarity
           :value lacunarity))
  (unless (realp persistence)
    (error 'int:invalid-real-argument
           :sampler-type 'hybrid-multifractal-3d
           :argument :persistence
           :value persistence))
  (let ((rng (int::make-rng seed)))
    (make-hybrid-multifractal-3d :rng rng
                                 :sources (int::make-fractal-sources generator rng octaves)
                                 :scale (get-scale-factor octaves persistence)
                                 :octaves octaves
                                 :frequency (float frequency 1f0)
                                 :lacunarity (float lacunarity 1f0)
                                 :persistence (float persistence 1f0))))

(defmethod int:sample ((sampler gen:hybrid-multifractal-3d) x &optional (y 0d0) (z 0d0) (w 0d0))
  (declare (ignore w))
  (loop :with sources = (sources sampler)
        :with frequency = (frequency sampler)
        :with lacunarity = (lacunarity sampler)
        :with persistence = (persistence sampler)
        :with fx = (* x frequency)
        :with fy = (* y frequency)
        :with fz = (* z frequency)
        :with result = (* (int:sample (aref sources 0) fx fy fz) persistence)
        :for i :from 1 :below (octaves sampler)
        :for amplitude = persistence :then (* amplitude persistence)
        :for weight = result :then (max weight 1)
        :for lx = (* fx lacunarity)
        :for ly = (* fy lacunarity)
        :for lz = (* fz lacunarity)
        :for sample = (* (int:sample (aref sources i) lx ly lz) amplitude)
        :do (setf weight (* weight sample))
            (incf result weight)
        :finally (return (/ result (scale sampler)))))
