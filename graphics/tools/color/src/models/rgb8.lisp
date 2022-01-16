(in-package #:mfiano.graphics.tools.color)

(defstruct (rgb8
            (:include color)
            (:constructor rgb8 (r g b))
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub8)
  (g 0 :type u:ub8)
  (b 0 :type u:ub8))

(defmethod decompose ((color rgb8))
  (declare (optimize speed))
  (values (%or-shift8 (rgb8-r color))
          (%or-shift8 (rgb8-g color))
          (%or-shift8 (rgb8-b color))
          #xffff))

(defmethod convert ((source color) (target rgb8))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (rgb8-r target) (ash r -8)
          (rgb8-g target) (ash g -8)
          (rgb8-b target) (ash b -8))
    target))

(defmethod convert ((source color) (target (eql 'rgb8)))
  (declare (optimize speed))
  (convert source (rgb8 0 0 0)))
