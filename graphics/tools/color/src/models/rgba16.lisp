(in-package #:mfiano.graphics.tools.color)

(defstruct (rgba16
            (:include rgb16)
            (:constructor rgba16 (r g b a))
            (:predicate nil)
            (:copier nil))
  (a 0 :type u:ub16))

(defmethod decompose ((model rgba16))
  (declare (optimize speed))
  (flet ((%decompose (value alpha)
           (truncate (* value alpha) #xffff)))
    (declare (inline %decompose))
    (let ((a (rgba16-a model)))
      (values (%decompose (rgba16-r model) a)
              (%decompose (rgba16-g model) a)
              (%decompose (rgba16-b model) a)
              a))))

(defmethod convert ((source model) (target rgba16))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (cond
      ((zerop a)
       (setf (rgba16-r target) 0
             (rgba16-g target) 0
             (rgba16-b target) 0
             (rgba16-a target) 0))
      ((= a #xffff)
       (setf (rgba16-r target) (ash r -8)
             (rgba16-g target) (ash g -8)
             (rgba16-b target) (ash b -8)
             (rgba16-a target) a))
      (t
       (setf (rgba16-r target) (truncate (- (ash r 16) r) a)
             (rgba16-g target) (truncate (- (ash g 16) g) a)
             (rgba16-b target) (truncate (- (ash b 16) b) a)
             (rgba16-a target) a)))
    target))

(defmethod convert ((source model) (target (eql 'rgba16)))
  (declare (optimize speed))
  (convert source (rgba16 0 0 0 0)))