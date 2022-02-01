(in-package #:mfiano.graphics.tools.image)

;; Get a vector in XYZ space representing the white point of the given standard illuminant,
;; normalized with a luminance (Y) value of 1 and a standard observer field of view of 2 degrees.
(defgeneric get-white-point (standard-illuminant))

;; incandescent / tungsten
(defmethod get-white-point ((standard-illuminant (eql :a)))
  (load-time-value (v3:vec 1.098466 1 0.35582292)))

;; obsolete, direct sunlight at noon
(defmethod get-white-point ((standard-illuminant (eql :b)))
  (load-time-value (v3:vec 0.9909274 1 0.85313267)))

;; obsolete, average / North sky daylight
(defmethod get-white-point ((standard-illuminant (eql :c)))
  (load-time-value (v3:vec 0.980706 1 1.1822494)))

;; horizon light, ICC profile PCS
(defmethod get-white-point ((standard-illuminant (eql :d50)))
  (load-time-value (v3:vec 0.964212 1 0.8251883)))

;; mid-morning / mid-afternoon daylight
(defmethod get-white-point ((standard-illuminant (eql :d55)))
  (load-time-value (v3:vec 0.95679706 1 0.92148066)))

;; noon daylight: television, sRGB color space
(defmethod get-white-point ((standard-illuminant (eql :d65)))
  (load-time-value (v3:vec 0.95042855 1 1.0889004)))

;; North sky daylight
(defmethod get-white-point ((standard-illuminant (eql :d75)))
  (load-time-value (v3:vec 0.94972205 1 1.2263936)))

;; high-efficiency blue phosphor monitors, BT.2035
(defmethod get-white-point ((standard-illuminant (eql :d93)))
  (load-time-value (v3:vec 0.953014 1 1.412743)))

;; equal energy
(defmethod get-white-point ((standard-illuminant (eql :e)))
  (load-time-value (v3:vec 1 1 1)))

;; daylight fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f1)))
  (load-time-value (v3:vec 0.9283364 1 1.0366473)))

;; cool white fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f2)))
  (load-time-value (v3:vec 0.9914466 1 0.6731595)))

;; white fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f3)))
  (load-time-value (v3:vec 1.0375348 1 0.49860507)))

;; warm white fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f4)))
  (load-time-value (v3:vec 1.0914726 1 0.3881326)))

;; daylight fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f5)))
  (load-time-value (v3:vec 0.90871966 1 0.98722893)))

;; light white fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f6)))
  (load-time-value (v3:vec 0.97309124 1 0.60190547)))

;; D65 simulator, daylight simulator
(defmethod get-white-point ((standard-illuminant (eql :f7)))
  (load-time-value (v3:vec 0.9501716 1 1.0862966)))

;; D50 simulator, Sylvania F40 Design 50
(defmethod get-white-point ((standard-illuminant (eql :f8)))
  (load-time-value (v3:vec 0.96412545 1 0.823331)))

;; cool white deluxe fluorescent
(defmethod get-white-point ((standard-illuminant (eql :f9)))
  (load-time-value (v3:vec 1.0036479 1 0.67868346)))

;; Philips TL85, Ultralume 50
(defmethod get-white-point ((standard-illuminant (eql :f10)))
  (load-time-value (v3:vec 0.96173507 1 0.8171234)))

;; Philips TL84, Ultralume 40
(defmethod get-white-point ((standard-illuminant (eql :f11)))
  (load-time-value (v3:vec 1.0089889 1 0.6426166)))

;; Philips TL83, Ultralume 30
(defmethod get-white-point ((standard-illuminant (eql :f12)))
  (load-time-value (v3:vec 1.0804629 1 0.3922752)))

;; phosphor-converted blue
(defmethod get-white-point ((standard-illuminant (eql :led-b1)))
  (load-time-value (v3:vec 1.1181952 1 0.33398736)))

;; phosphor-converted blue
(defmethod get-white-point ((standard-illuminant (eql :led-b2)))
  (load-time-value (v3:vec 1.085992 1 0.4065304)))

;; phosphor-converted blue
(defmethod get-white-point ((standard-illuminant (eql :led-b3)))
  (load-time-value (v3:vec 1.0088638 1 0.67714214)))

;; phosphor-converted blue
(defmethod get-white-point ((standard-illuminant (eql :led-b4)))
  (load-time-value (v3:vec 0.9771559 1 0.87835515)))

;; phosphor-converted blue
(defmethod get-white-point ((standard-illuminant (eql :led-b5)))
  (load-time-value (v3:vec 0.96353525 1 1.1266997)))

;; mixing of phosphor-converted blue LED and red LED (blue-hybrid)
(defmethod get-white-point ((standard-illuminant (eql :led-bh1)))
  (load-time-value (v3:vec 1.1003443 1 0.35907534)))

;; mixing of red, green, and blue LEDs
(defmethod get-white-point ((standard-illuminant (eql :led-rgb1)))
  (load-time-value (v3:vec 1.0821658 1 0.292567)))

;; phosphor-converted violet
(defmethod get-white-point ((standard-illuminant (eql :led-v1)))
  (load-time-value (v3:vec 1.0026385 1 0.1961302)))

;; phosphor-converted violet
(defmethod get-white-point ((standard-illuminant (eql :led-v2)))
  (load-time-value (v3:vec 1.0015894 1 0.6474171)))
