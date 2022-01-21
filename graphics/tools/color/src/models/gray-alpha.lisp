(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass gray-alpha (gray alpha) ())

(defmethod decompose ((color gray-alpha))
  (values (value color) (a color)))

;;; gray-alpha8

(defclass gray-alpha8 (gray-alpha) ())

(defun gray-alpha8 (&optional (value 0) (alpha #xff))
  (make-instance 'gray-alpha8 :bpc 8 :value value :a alpha))

(defmethod canonicalize-components ((color gray-alpha8))
  (let ((v (* (value color) #x101))
        (a (* (a color) #x101)))
    (values v v v a)))

(defmethod convert ((source color) (target gray-alpha8))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color 8)
          (a target) (ash (a color) -8))
    target))

;;; gray-alpha16

(defclass gray-alpha16 (gray-alpha) ())

(defun gray-alpha16 (&optional (value 0) (alpha #xff))
  (make-instance 'gray-alpha16 :bpc 16 :value value :a alpha))

(defmethod canonicalize-components ((color gray-alpha16))
  (let ((v (value color))
        (a (a color)))
    (values v v v a)))

(defmethod convert ((source color) (target gray-alpha16))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color 16)
          (a target) (ash (a color) -8))
    target))
