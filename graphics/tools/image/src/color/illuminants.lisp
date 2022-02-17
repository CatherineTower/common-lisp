(in-package #:%mfiano.graphics.tools.image.color)

(defclass illuminant ()
  ((%name
    :type (and symbol (not null))
    :reader name
    :initarg :name)
   (%x
    :type u:positive-real
    :reader x
    :initarg :x)
   (%y
    :type u:positive-real
    :reader y
    :initarg :y)
   (%white-point
    :type v3:vec
    :reader white-point
    :initarg :white-point)))

(u:define-printer (illuminant stream)
  (format stream "~s" (name illuminant)))

(declaim (inline get-white-point))
(defun get-white-point (illuminant-name)
  (declare (optimize speed))
  (white-point (u:href (base:illuminants base:*context*) illuminant-name)))

(defun register-illuminant (name x y)
  (assert (and (<= 0 x 1) (<= 0 y 1)))
  (let* ((white-point (v3:vec (/ x y) 1 (/ (- 1 x y) y)))
         (illuminant (make-instance 'illuminant :name name :x x :y y :white-point white-point)))
    (setf (u:href (base:illuminants base:*default-context*) name) illuminant)
    (values)))

(defmacro define-illuminants (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name &key x y) x
            `(register-illuminant ',name ,x ,y)))
        body)))

;; Reference: https://en.wikipedia.org/wiki/Standard_illuminant#White_points_of_standard_illuminants
(define-illuminants ()
  (a :x 0.44757 :y 0.40745)
  (b :x 0.34842 :y 0.35161)
  (c :x 0.31006 :y 0.31616)
  (d50 :x 0.34567 :y 0.3585)
  (d55 :x 0.33242 :y 0.34743)
  (d65 :x 0.31271 :y 0.32902)
  (d75 :x 0.29902 :y 0.31485)
  (d93 :x 0.28315 :y 0.29711)
  (e :x 1/3 :y 1/3)
  (f1 :x 0.3131 :y 0.33727)
  (f2 :x 0.37208 :y 0.37529)
  (f3 :x 0.4091 :y 0.3943)
  (f4 :x 0.44018 :y 0.40329)
  (f5 :x 0.31379 :y 0.34531)
  (f6 :x 0.3779 :y 0.38835)
  (f7 :x 0.31292 :y 0.32933)
  (f8 :x 0.34588 :y 0.35875)
  (f9 :x 0.37417 :y 0.37281)
  (f10 :x 0.34609 :y 0.35986)
  (f11 :x 0.38052 :y 0.37713)
  (f12 :x 0.43695 :y 0.40441)
  (led-b1 :x 0.456 :y 0.4078)
  (led-b2 :x 0.4357 :y 0.4012)
  (led-b3 :x 0.3756 :y 0.3723)
  (led-b4 :x 0.3422 :y 0.3502)
  (led-b5 :x 0.3118 :y 0.3236)
  (led-bh1 :x 0.4474 :y 0.4066)
  (led-rgb1 :x 0.4557 :y 0.4211)
  (led-v1 :x 0.456 :y 0.4548)
  (led-v2 :x 0.3781 :y 0.3775))

;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
(define-illuminants ()
  (dci :x 0.314 :y 0.351))
