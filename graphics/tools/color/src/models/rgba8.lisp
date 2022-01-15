(in-package #:mfiano.graphics.tools.color)

(defstruct (rgba8
            (:include rgb8)
            (:constructor rgba8 (r g b a))
            (:predicate nil)
            (:copier nil))
  (a 0 :type u:ub8))

(defmethod decompose ((model rgba8))
  (declare (optimize speed))
  (flet ((%decompose (value alpha)
           (truncate (* (%or-shift8 value) alpha) #xff)))
    (declare (inline %decompose))
    (let ((a (rgba8-a model)))
      (values (%decompose (rgba8-r model) a)
              (%decompose (rgba8-g model) a)
              (%decompose (rgba8-b model) a)
              (%or-shift8 a)))))

;; non-consing
(defmethod convert ((source model) (target rgba8))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (cond
      ((zerop a)
       (setf (rgba8-r target) 0
             (rgba8-g target) 0
             (rgba8-b target) 0
             (rgba8-a target) 0))
      ((= a #xffff)
       (setf (rgba8-r target) (ash r -8)
             (rgba8-g target) (ash g -8)
             (rgba8-b target) (ash b -8)
             (rgba8-a target) #xff))
      (t
       (setf (rgba8-r target) (truncate (- (ash r 16) r) a)
             (rgba8-g target) (truncate (- (ash g 16) g) a)
             (rgba8-b target) (truncate (- (ash b 16) b) a)
             (rgba8-a target) (ash a -8))))
    target))

;; consing
(defmethod convert ((source model) (target (eql 'rgba8)))
  (declare (optimize speed))
  (convert source (rgba8 0 0 0 0)))