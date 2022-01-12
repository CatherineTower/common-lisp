(in-package #:mfiano.graphics.tools.color)

(defgeneric convert (color type)
  (:method :around ((color color) type)
    ;; Skip the conversion if the color is already of the given type.
    (if (eq (class-name (class-of color)) type)
        color
        (call-next-method))))

(defmethod convert ((color color) (type (eql 'rgba)))
  (u:mvlet ((r g b a (decode color)))
    (if (pma color)
        (rgba (ash r -8) (ash g -8) (ash b -8) (ash a -8))
        (cond
          ((zerop a)
           (rgba 0 0 0 0))
          ((= a #xffff)
           (rgba (ash r -8) (ash g -8) (ash b -8) #xff))
          (t
           (rgba (ash (truncate (- (ash r 16) r) a) -8)
                 (ash (truncate (- (ash g 16) g) a) -8)
                 (ash (truncate (- (ash b 16) b) a) -8)
                 (ash a -8)))))))

(defmethod convert ((color color) (type (eql 'rgba16)))
  (u:mvlet ((r g b a (decode color)))
    (if (pma color)
        (rgba16 r g b a)
        (cond
          ((zerop a)
           (rgba16 0 0 0 0))
          ((= a #xffff)
           (rgba16 (ash r -8) (ash g -8) (ash b -8) #xff))
          (t
           (rgba16 (truncate (- (ash r 16) r) a)
                   (truncate (- (ash g 16) g) a)
                   (truncate (- (ash b 16) b) a)
                   a))))))

(defmethod convert ((color color) (type (eql 'alpha)))
  (u:mvlet ((r g b a (decode color)))
    (alpha (ash a -8))))

(defmethod convert ((color color) (type (eql 'alpha16)))
  (u:mvlet ((r g b a (decode color)))
    (alpha16 a)))

(defmethod convert ((color color) (type (eql 'gray)))
  ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
  (u:mvlet ((r g b a (decode color)))
    (gray (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -24))))

(defmethod convert ((color color) (type (eql 'gray16)))
  ;; Uses the ITU-R Recommendation BT.709 standard for its luma coefficients.
  (u:mvlet ((r g b a (decode color)))
    (gray16 (ash (+ (* 13933 r) (* 46871 g) (* 4732 b) #x8000) -16))))
