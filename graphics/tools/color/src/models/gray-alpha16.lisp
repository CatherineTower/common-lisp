(in-package #:mfiano.graphics.tools.color)

(defstruct (gray-alpha16
            (:include gray16)
            (:constructor gray-alpha16 (value alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xffff :type u:ub16))

(defmethod decompose ((color gray-alpha16))
  (declare (optimize speed))
  (let ((v (gray-alpha16-value color))
        (a (gray-alpha16-alpha color)))
    (values v v v a)))

(defmethod convert ((source color) (target gray-alpha16))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (setf (gray-alpha16-value target) (%encode-bt709 r g b 16)
          (gray-alpha16-alpha target) a)
    target))

(defmethod convert ((source color) (target (eql 'gray-alpha16)))
  (declare (optimize speed))
  (convert source (gray-alpha16 0 0)))
