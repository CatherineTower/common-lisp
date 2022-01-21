(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass gray (color)
  ((%value :accessor value
           :initarg :value)))

(defmethod initialize-instance :after ((instance gray) &key)
  (with-slots (%bpc %value) instance
    (%check-bpc-values %bpc %value)))

(defmethod decompose ((color gray))
  (value color))

;;; gray8

(defclass gray8 (gray) ())

(defun gray8 (&optional (value 0))
  (make-instance 'gray8 :bpc 8 :value value))

(defmethod canonicalize-components ((color gray8))
  (let ((v (* (value color) #x101)))
    (values v v v #xffff)))

(defmethod convert ((source color) (target gray8))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color 8))
    target))

;;; gray16

(defclass gray16 (gray) ())

(defun gray16 (&optional (value 0))
  (make-instance 'gray16 :bpc 16 :value value))

(defmethod canonicalize-components ((color gray16))
  (let ((v (value color)))
    (values v v v #xffff)))

(defmethod convert ((source color) (target gray8))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color 16))
    target))
