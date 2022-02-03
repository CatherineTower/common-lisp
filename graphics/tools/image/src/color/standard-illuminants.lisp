(in-package #:mfiano.graphics.tools.image)

(u:define-constant +standard-illuminants+
    '(:a :b :c :d50 :d55 :d65 :d75 :d93 :e :f1 :f2 :f3 :f4 :f5 :f6 :f7 :f8 :f9 :f10 :f11 :f12
      :led-b1 :led-b2 :led-b3 :led-b4 :led-b5 :led-bh1 :led-rgb1 :led-v1 :led-v2)
  :test #'equal)

(deftype standard-illuminant () `(member ,@+standard-illuminants+))

;; A hash table mapping standard illuminant names to their white point chromaticity coordinates in
;; XYZ space, normalized with Y=1.
(gv:define-global-var -standard-illuminant-white-points-
    (u:dict
     :a (v3:vec 1.098466 1 0.35582292)
     :b (v3:vec 0.9909274 1 0.85313267)
     :c (v3:vec 0.980706 1 1.1822494)
     :d50 (v3:vec 0.964212 1 0.8251883)
     :d55 (v3:vec 0.95679706 1 0.92148066)
     :d65 (v3:vec 0.95042855 1 1.0889004)
     :d75 (v3:vec 0.94972205 1 1.2263936)
     :d93 (v3:vec 0.953014 1 1.412743)
     :e (v3:vec 1 1 1)
     :f1 (v3:vec 0.9283364 1 1.0366473)
     :f2 (v3:vec 0.9914466 1 0.6731595)
     :f3 (v3:vec 1.0375348 1 0.49860507)
     :f4 (v3:vec 1.0914726 1 0.3881326)
     :f5 (v3:vec 0.90871966 1 0.98722893)
     :f6 (v3:vec 0.97309124 1 0.60190547)
     :f7 (v3:vec 0.9501716 1 1.0862966)
     :f8 (v3:vec 0.96412545 1 0.823331)
     :f9 (v3:vec 1.0036479 1 0.67868346)
     :f10 (v3:vec 0.96173507 1 0.8171234)
     :f11 (v3:vec 1.0089889 1 0.6426166)
     :f12 (v3:vec 1.0804629 1 0.3922752)
     :led-b1 (v3:vec 1.1181952 1 0.33398736)
     :led-b2 (v3:vec 1.085992 1 0.4065304)
     :led-b3 (v3:vec 1.0088638 1 0.67714214)
     :led-b4 (v3:vec 0.9771559 1 0.87835515)
     :led-b5 (v3:vec 0.96353525 1 1.1266997)
     :led-bh1 (v3:vec 1.1003443 1 0.35907534)
     :led-rgb1 (v3:vec 1.0821658 1 0.292567)
     :led-v1 (v3:vec 1.0026385 1 0.1961302)
     :led-v2 (v3:vec 1.0015894 1 0.6474171)))

(declaim (inline get-white-point))
(defun get-white-point (standard-illuminant)
  (declare (optimize speed))
  (values (u:href -standard-illuminant-white-points- standard-illuminant)))
