(in-package #:mfiano.graphics.tools.image)

(defvar *standard-illuminant-chromaticity-coordinates*
  '((:a (0.44757 0.40745))
    (:b (0.34842 0.35161))
    (:c (0.31006 0.31616))
    (:d50 (0.34567 0.3585))
    (:d55 (0.33242 0.34743))
    (:d65 (0.31271 0.32902))
    (:d75 (0.29902 0.31485))
    (:d93 (0.28315 0.29711))
    (:e (1/3 1/3))
    (:f1 (0.3131 0.33727))
    (:f2 (0.37208 0.37529))
    (:f3 (0.4091 0.3943))
    (:f4 (0.44018 0.40329))
    (:f5 (0.31379 0.34531))
    (:f6 (0.3779 0.38835))
    (:f7 (0.31292 0.32933))
    (:f8 (0.34588 0.35875))
    (:f9 (0.37417 0.37281))
    (:f10 (0.34609 0.35986))
    (:f11 (0.38052 0.37713))
    (:f12 (0.43695 0.40441))
    (:led-b1 (0.4560 0.4078))
    (:led-b2 (0.4357 0.4012))
    (:led-b3 (0.3756 0.3723))))

;; Get a vector in XYZ space representing the white point of the given standard illuminant,
;; normalized with a luminance (Y) value of 1 and a standard observer field of view of 2 degrees.
(defgeneric get-white-point (standard-illuminant))

(macrolet ((generate-white-point-methods ()
             `(progn
                ,@(loop :for (name (x y)) :in *standard-illuminant-chromaticity-coordinates*
                        :collect `(defmethod get-white-point ((standard-illuminant (eql ,name)))
                                    (load-time-value (v3:vec ,(/ x y) 1 ,(/ (- 1 x y) y))))))))
  (generate-white-point-methods))
