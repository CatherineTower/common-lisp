(in-package #:mfiano.graphics.tools.color)

(defgeneric convert (color type)
  (:method :around ((color color) type)
    ;; Skip the conversion if the color is already of the given type.
    (if (eq (class-name (class-of color)) type)
        color
        (call-next-method))))

(defmethod convert ((color color) (type (eql 'rgba)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (cond
      ((zerop a)
       (rgba 0 0 0 0))
      ((= a #xffff)
       (rgba (ash r -8) (ash g -8) (ash b -8) #xff))
      (t
       (rgba (ash (truncate (- (ash r 16) r) a) -8)
             (ash (truncate (- (ash g 16) g) a) -8)
             (ash (truncate (- (ash b 16) b) a) -8)
             (ash a -8))))))

(defmethod convert ((color color) (type (eql 'rgba-pma)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (rgba-pma (ash r -8) (ash g -8) (ash b -8) (ash a -8))))

(defmethod convert ((color color) (type (eql 'rgba16)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (cond
      ((zerop a)
       (rgba16 0 0 0 0))
      ((= a #xffff)
       (rgba16 (ash r -8) (ash g -8) (ash b -8) #xff))
      (t
       (rgba16 (truncate (- (ash r 16) r) a)
               (truncate (- (ash g 16) g) a)
               (truncate (- (ash b 16) b) a)
               a)))))

(defmethod convert ((color color) (type (eql 'rgba16-pma)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (rgba16-pma r g b a)))

(defmethod convert ((color color) (type (eql 'alpha)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (alpha (ash a -8))))

(defmethod convert ((color color) (type (eql 'alpha16)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    (alpha16 a)))

(defmethod convert ((color color) (type (eql 'gray)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
    (gray (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -24))))

(defmethod convert ((color color) (type (eql 'gray16)))
  (declare (optimize speed))
  (u:mvlet ((r g b a (decompose color)))
    (declare (u:ub16 r g b a))
    ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
    (gray16 (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -16))))
