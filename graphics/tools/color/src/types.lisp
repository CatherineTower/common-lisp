(in-package #:mfiano.graphics.tools.color)

;;; Abstract classes

(defclass color ()
  ((%data :reader data
          :initarg :data)))

;;; Concrete classes

(defclass rgba (color)
  ((%pma :reader pma
         :initarg :pma)))

(defclass rgba16 (rgba) ())

(defclass alpha (color) ())

(defclass alpha16 (color) ())

(defclass gray (color) ())

(defclass gray16 (color) ())

;;; Constructors

(defun rgba (r g b a &key pma)
  (declare (optimize speed))
  (%check-ub8 r g b a)
  (let* ((data (u:make-ub8-array 4))
         (color (make-instance 'rgba :data data :pma pma)))
    (%write-rgba data r g b a)
    color))

(defun rgba16 (r g b a &key pma)
  (declare (optimize speed))
  (%check-ub16 r g b a)
  (let* ((data (u:make-ub16-array 4))
         (color (make-instance 'rgba16 :data data :pma pma)))
    (%write-rgba data r g b a)
    color))

(defun alpha (value)
  (declare (optimize speed))
  (%check-ub8 value)
  (make-instance 'alpha :data value))

(defun alpha16 (value)
  (declare (optimize speed))
  (%check-ub16 value)
  (make-instance 'alpha16 :data value))

(defun gray (value)
  (declare (optimize speed))
  (%check-ub8 value)
  (make-instance 'gray :data value))

(defun gray16 (value)
  (declare (optimize speed))
  (%check-ub16 value)
  (make-instance 'gray16 :data value))
