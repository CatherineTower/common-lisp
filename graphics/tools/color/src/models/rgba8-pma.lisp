(in-package #:mfiano.graphics.tools.color)

(defstruct (rgba8-pma
            (:include rgba8)
            (:constructor rgba8-pma (r g b a))
            (:predicate nil)
            (:copier nil)))

(defmethod decompose ((color rgba8-pma))
  (declare (optimize speed))
  (values (%or-shift8 (rgba8-r color))
          (%or-shift8 (rgba8-g color))
          (%or-shift8 (rgba8-b color))
          (%or-shift8 (rgba8-a color))))

(defmethod convert ((source color) (target rgba8-pma))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (setf (rgba8-r target) (ash r -8)
          (rgba8-g target) (ash g -8)
          (rgba8-b target) (ash b -8)
          (rgba8-a target) (ash a -8))
    target))

(defmethod convert ((source color) (target (eql 'rgba8-pma)))
  (declare (optimize speed))
  (convert source (rgba8-pma 0 0 0 0)))
