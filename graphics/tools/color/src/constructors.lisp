(in-package #:mfiano.graphics.tools.color)

(defun rgba (r g b a)
  (declare (optimize speed))
  (%rgba :r r :g g :b b :a a))

(defun rgba-pma (r g b a)
  (declare (optimize speed))
  (%rgba-pma :r r :g g :b b :a a))

(defun rgba16 (r g b a)
  (declare (optimize speed))
  (%rgba16 :r r :g g :b b :a a))

(defun rgba16-pma (r g b a)
  (declare (optimize speed))
  (%rgba16-pma :r r :g g :b b :a a))

(defun alpha (value)
  (declare (optimize speed))
  (%alpha :value value))

(defun alpha16 (value)
  (declare (optimize speed))
  (%alpha16 :value value))

(defun gray (value)
  (declare (optimize speed))
  (%gray :value value))

(defun gray16 (value)
  (declare (optimize speed))
  (%gray16 :value value))
