(in-package #:mfiano.graphics.tools.color)

(defstruct (alpha8
            (:include model)
            (:constructor alpha8 (alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xff :type u:ub8))

(defmethod decompose ((model alpha8))
  (declare (optimize speed))
  (let ((a (%or-shift8 (alpha8-alpha model))))
    (values a a a a)))

(defmethod convert ((source model) (target alpha8))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (declare (u:ub16 a))
    (setf (alpha8-alpha target) (ash a -8))
    target))

(defmethod convert ((source model) (target (eql 'alpha8)))
  (declare (optimize speed))
  (convert source (alpha8 0)))
