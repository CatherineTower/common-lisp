(in-package #:mfiano.graphics.tools.color)

(defstruct (gray8
            (:include color)
            (:constructor gray8 (value))
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub8))

(defmethod decompose ((color gray8))
  (declare (optimize speed))
  (let ((v (%or-shift8 (gray8-value color))))
    (values v v v #xffff)))

(defmethod convert ((source color) (target gray8))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (gray8-value target) (%encode-bt709 r g b 8))
    target))

(defmethod convert ((source color) (target (eql 'gray8)))
  (declare (optimize speed))
  (convert source (gray8 0)))
