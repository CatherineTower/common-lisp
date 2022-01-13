(in-package #:mfiano.graphics.tools.color)

(defgeneric convert (source target)
  (:method :around ((source color) target)
    ;; Skip the conversion if the color is already of the given type.
    (if (eq (class-name (class-of source)) target)
        source
        (call-next-method))))

(defmethod convert ((source color) (target rgba))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (cond
      ((zerop a)
       (setf (rgba-r target) 0
             (rgba-g target) 0
             (rgba-b target) 0
             (rgba-a target) 0))
      ((= a #xffff)
       (setf (rgba-r target) (ash r -8)
             (rgba-g target) (ash g -8)
             (rgba-b target) (ash b -8)
             (rgba-a target) #xff))
      (t
       (setf (rgba-r target) (truncate (- (ash r 16) r) a)
             (rgba-g target) (truncate (- (ash g 16) g) a)
             (rgba-b target) (truncate (- (ash b 16) b) a)
             (rgba-a target) (ash a -8))))
    target))

(defmethod convert ((source color) (target (eql 'rgba)))
  (declare (optimize speed))
  (convert source (rgba 0 0 0 0)))

(defmethod convert ((source color) (target rgba-pma))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (setf (rgba-r target) (ash r -8)
          (rgba-g target) (ash g -8)
          (rgba-b target) (ash b -8)
          (rgba-a target) (ash a -8))
    target))

(defmethod convert ((source color) (target (eql 'rgba-pma)))
  (declare (optimize speed))
  (convert source (rgba-pma 0 0 0 0)))

(defmethod convert ((source color) (target rgba16))
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

(defmethod convert ((source color) (target (eql 'rgba16)))
  (declare (optimize speed))
  (convert source (rgba16 0 0 0 0)))

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

(defmethod convert ((source color) (target alpha))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (declare (u:ub16 a))
    (setf (alpha-value target) (ash a -8))
    target))

(defmethod convert ((source color) (target (eql 'alpha)))
  (declare (optimize speed))
  (convert source (alpha 0)))

(defmethod convert ((source color) (target alpha16))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (setf (alpha16-value target) a)
    target))

(defmethod convert ((source color) (target (eql 'alpha16)))
  (declare (optimize speed))
  (convert source (alpha16 0)))

(defmethod convert ((source color) (target gray))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
    (setf (gray-value target) (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -24))
    target))

(defmethod convert ((source color) (target (eql 'gray)))
  (declare (optimize speed))
  (convert source (gray 0)))

(defmethod convert ((source color) (target gray16))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
    (setf (gray16-value target) (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -16))
    target))

(defmethod convert ((source color) (target (eql 'gray16)))
  (declare (optimize speed))
  (convert source (gray16 0)))
