(in-package #:%mfiano.graphics.image.color)

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

(declaim (notinline get-white-point))
(defun get-white-point (illuminant-name)
  (declare (optimize speed))
  (white-point (u:href (base:illuminants base:*context*) illuminant-name)))

(defun register-illuminant (name x y)
  (assert (and (<= 0 x 1) (<= 0 y 1)))
  (let* ((white-point (v3:vec (/ x y) 1 (/ (- 1 x y) y)))
         (illuminant (make-instance 'illuminant :name name :x x :y y :white-point white-point)))
    (setf (u:href (base:illuminants base:*context*) name) illuminant)
    (values)))

(defmacro define-illuminants (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name x y) x
            `(register-illuminant ',name ,x ,y)))
        body)))

;; Reference: https://en.wikipedia.org/wiki/Standard_illuminant#White_points_of_standard_illuminants
(define-illuminants ()
  (:a 0.44757 0.40745)
  (:b 0.34842 0.35161)
  (:c 0.31006 0.31616)
  (:d50 0.34567 0.3585)
  (:d55 0.33242 0.34743)
  (:d65 0.31271 0.32902)
  (:d75 0.29902 0.31485)
  (:d93 0.28315 0.29711)
  (:e 1/3 1/3)
  (:f1 0.3131 0.33727)
  (:f2 0.37208 0.37529)
  (:f3 0.4091 0.3943)
  (:f4 0.44018 0.40329)
  (:f5 0.31379 0.34531)
  (:f6 0.3779 0.38835)
  (:f7 0.31292 0.32933)
  (:f8 0.34588 0.35875)
  (:f9 0.37417 0.37281)
  (:f10 0.34609 0.35986)
  (:f11 0.38052 0.37713)
  (:f12 0.43695 0.40441)
  (:led-b1 0.456 0.4078)
  (:led-b2 0.4357 0.4012)
  (:led-b3 0.3756 0.3723)
  (:led-b4 0.3422 0.3502)
  (:led-b5 0.3118 0.3236)
  (:led-bh1 0.4474 0.4066)
  (:led-rgb1 0.4557 0.4211)
  (:led-v1 0.456 0.4548)
  (:led-v2 0.3781 0.3775))

;; Reference: https://en.wikipedia.org/wiki/DCI-P3#System_colorimetry
(define-illuminants ()
  (:dci 0.314 0.351))
