(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass alpha (color)
  ((%a :accessor a
       :initarg :a)))

(defmethod initialize-instance :after ((instance alpha) &key)
  (with-slots (%bpc %a) instance
    (%check-bpc-values %bpc %a)))

(defmethod decompose ((color alpha))
  (a color))

;;; alpha8

(defclass alpha8 (alpha) ())

(defun alpha8 (&optional (value #xff))
  (make-instance 'alpha8 :bpc 8 :a value))

(defmethod canonicalize-components ((color alpha8))
  (let ((a (* (a color) #x101)))
    (values a a a a)))

(defmethod convert ((source color) (target alpha8))
  (let ((color (canonicalize source)))
    (setf (a target) (ash (a color) -8))
    target))

;;; alpha16

(defclass alpha16 (alpha) ())

(defun alpha16 (&optional (value #xffff))
  (make-instance 'alpha16 :bpc 16 :a value))

(defmethod canonicalize-components ((color alpha16))
  (let ((a (a color)))
    (values a a a a)))

(defmethod convert ((source color) (target alpha16))
  (let ((color (canonicalize source)))
    (setf (a target) (a color))
    target))
