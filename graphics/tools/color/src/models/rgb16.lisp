(in-package #:mfiano.graphics.tools.color)

(defstruct (rgb16
            (:include model)
            (:constructor rgb16 (r g b))
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub16)
  (g 0 :type u:ub16)
  (b 0 :type u:ub16))

(defmethod decompose ((model rgb16))
  (declare (optimize speed))
  (values (rgb16-r model)
          (rgb16-g model)
          (rgb16-b model)
          #xffff))

(defmethod convert ((source model) (target rgb16))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (rgb16-r target) (ash r -8)
          (rgb16-g target) (ash g -8)
          (rgb16-b target) (ash b -8))
    target))

(defmethod convert ((source model) (target (eql 'rgb16)))
  (declare (optimize speed))
  (convert source (rgb16 0 0 0)))