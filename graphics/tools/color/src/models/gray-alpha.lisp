(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass gray-alpha (gray alpha) ())

(defmethod decompose ((color gray-alpha))
  (values (value color) (a color)))

;;; gray-alpha8

(defclass gray-alpha8 (gray-alpha) ())

(defun gray-alpha8 (&optional (value 0) (alpha #xff))
  (make-instance 'gray-alpha8 :bpc 8 :value value :a alpha))

(defmethod canonicalize-channels ((color gray-alpha8))
  (with-channels ((v a) color)
    (->! (_ (v a)) (* _ #x101))
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

(defmethod canonicalize-channels ((color gray-alpha16))
  (with-channels ((v a) color)
    (values v v v a)))

(defmethod convert ((source color) (target gray-alpha16))
  (let ((color (canonicalize source)))
    (setf (value target) (%encode-bt709 color 16)
          (a target) (ash (a color) -8))
    target))
