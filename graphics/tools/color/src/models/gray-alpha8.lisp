(in-package #:mfiano.graphics.tools.color)

(defstruct (gray-alpha8
            (:include gray8)
            (:constructor gray-alpha8 (value alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xff :type u:ub8))

(defmethod decompose ((color gray-alpha8))
  (declare (optimize speed))
  (let ((v (%or-shift8 (gray-alpha8-value color)))
        (a (%or-shift8 (gray-alpha8-alpha color))))
    (values v v v a)))

(defmethod convert ((source color) (target gray-alpha8))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (setf (gray-alpha8-value target) (%encode-bt709 r g b 8)
          (gray-alpha8-alpha target) (ash a -8))
    target))

(defmethod convert ((source color) (target (eql 'gray-alpha8)))
  (declare (optimize speed))
  (convert source (gray-alpha8 0 0)))
