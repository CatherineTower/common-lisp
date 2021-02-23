(in-package #:cl-user)

(defpackage #:%coherent-noise.modifiers.invert
  (:local-nicknames
   (#:int #:%coherent-noise.internal)
   (#:mod #:%coherent-noise.modifiers)
   (#:u #:golden-utils))
  (:use #:cl))

(in-package #:%coherent-noise.modifiers.invert)

(defstruct (mod:invert
            (:include int:sampler)
            (:conc-name "")
            (:predicate nil)
            (:copier nil))
  (source nil :type int:sampler))

(defun mod:invert (source)
  (unless (typep source 'int:sampler)
    (error 'int:invalid-sampler-argument
           :sampler-type 'invert
           :argument 'source
           :value source))
  (make-invert :rng (int::sampler-rng source) :source source))

(defmethod int:sample ((sampler mod:invert) x &optional (y 0d0) (z 0d0) (w 0d0))
  (declare (optimize speed))
  (- (the u:f32 (int:sample (source sampler) x y z w))))
