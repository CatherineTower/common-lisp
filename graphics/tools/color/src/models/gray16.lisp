(in-package #:mfiano.graphics.tools.color)

(defstruct (gray16
            (:include model)
            (:constructor gray16 (value))
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub16))

(defmethod decompose ((model gray16))
  (declare (optimize speed))
  (let ((v (gray16-value model)))
    (values v v v #xffff)))

(defmethod convert ((source model) (target gray16))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (gray16-value target) (%encode-bt709 r g b 16))
    target))

(defmethod convert ((source model) (target (eql 'gray16)))
  (declare (optimize speed))
  (convert source (gray16 0)))
