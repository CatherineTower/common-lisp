(in-package #:mfiano.graphics.tools.color)

(defstruct (rgba16-pma
            (:include rgba16)
            (:constructor rgba16-pma (r g b a))
            (:predicate nil)
            (:copier nil)))

(defmethod decompose ((color rgba16-pma))
  (declare (optimize speed))
  (values (rgba16-r color)
          (rgba16-g color)
          (rgba16-b color)
          (rgba16-a color)))

(defmethod convert ((source color) (target rgba16-pma))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (setf (rgba16-r target) r
          (rgba16-g target) g
          (rgba16-b target) b
          (rgba16-a target) a)
    target))

(defmethod convert ((source color) (target (eql 'rgba16-pma)))
  (declare (optimize speed))
  (convert source (rgba16-pma 0 0 0 0)))
