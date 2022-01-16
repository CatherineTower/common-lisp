(in-package #:mfiano.graphics.tools.color)

(defstruct (alpha16
            (:include color)
            (:constructor alpha16 (alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xffff :type u:ub16))

(defmethod decompose ((color alpha16))
  (declare (optimize speed))
  (let ((a (alpha16-alpha color)))
    (values a a a a)))

(defmethod convert ((source color) (target alpha16))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (setf (alpha16-alpha target) a)
    target))

(defmethod convert ((source color) (target (eql 'alpha16)))
  (declare (optimize speed))
  (convert source (alpha16 0)))
