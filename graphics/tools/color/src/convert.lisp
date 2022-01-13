(in-package #:mfiano.graphics.tools.color)

(defgeneric convert (source target)
  (:method :around ((source color) target)
    ;; Skip the conversion if the color is already of the given type.
    (if (eq (class-name (class-of source)) target)
        source
        (call-next-method))))

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

(defmethod convert ((source color) (target rgb16))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (rgb16-r target) (ash r -8)
          (rgb16-g target) (ash g -8)
          (rgb16-b target) (ash b -8))
    target))

(defmethod convert ((source color) (target (eql 'rgb16)))
  (declare (optimize speed))
  (convert source (rgb16 0 0 0)))

(defmethod convert ((source color) (target rgba8))
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

(defmethod convert ((source color) (target (eql 'rgba8)))
  (declare (optimize speed))
  (convert source (rgba8 0 0 0 0)))

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

(defmethod convert ((source color) (target gray8))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (gray8-value target) (%encode-bt709 r g b 8))
    target))

(defmethod convert ((source color) (target (eql 'gray8)))
  (declare (optimize speed))
  (convert source (gray8 0)))

(defmethod convert ((source color) (target gray16))
  (declare (optimize speed))
  (u:mvlet ((r g b (decompose source)))
    (declare (u:ub16 r g b))
    (setf (gray16-value target) (%encode-bt709 r g b 16))
    target))

(defmethod convert ((source color) (target (eql 'gray16)))
  (declare (optimize speed))
  (convert source (gray16 0)))

(defmethod convert ((source color) (target alpha8))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (declare (u:ub16 a))
    (setf (alpha8-alpha target) (ash a -8))
    target))

(defmethod convert ((source color) (target (eql 'alpha8)))
  (declare (optimize speed))
  (convert source (alpha8 0)))

(defmethod convert ((source color) (target alpha16))
  (declare (optimize speed))
  (u:mvlet ((_ _ _ a (decompose source)))
    (setf (alpha16-alpha target) a)
    target))

(defmethod convert ((source color) (target (eql 'alpha16)))
  (declare (optimize speed))
  (convert source (alpha16 0)))

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

(defmethod convert ((source color) (target gray-alpha16))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose source)))
    (declare (u:ub16 r g b a))
    (setf (gray-alpha16-value target) (%encode-bt709 r g b 16)
          (gray-alpha16-alpha target) a)
    target))

(defmethod convert ((source color) (target (eql 'gray-alpha16)))
  (declare (optimize speed))
  (convert source (gray-alpha16 0 0)))
