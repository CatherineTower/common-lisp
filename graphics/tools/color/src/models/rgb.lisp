(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass rgb (color)
  ((%r :accessor r
       :initarg :r)
   (%g :accessor g
       :initarg :g)
   (%b :accessor b
       :initarg :b)))

(defmethod initialize-instance :after ((instance rgb) &key)
  (with-slots (%bpc %r %g %b) instance
    (%check-bpc-values %bpc %r %g %b)))

(defmethod decompose ((color rgb))
  (values (r color) (g color) (b color)))

;;; rgb8

(defclass rgb8 (rgb) ())

(defun rgb8 (&optional (r 0) (g 0) (b 0))
  (make-instance 'rgb8 :bpc 8 :r r :g g :b b))

(defmethod canonicalize-channels ((color rgb8))
  (with-channels ((r g b) color)
    (combine-values
      (-> (_ (r g b)) (* _ #x101))
      #xffff)))

(defmethod convert ((source color) (target rgb8))
  (let ((color (canonicalize source)))
    (setf (r target) (ash (r color) -8)
          (g target) (ash (g color) -8)
          (b target) (ash (b color) -8))
    target))

;;; rgb16

(defclass rgb16 (rgb) ())

(defun rgb16 (&optional (r 0) (g 0) (b 0))
  (make-instance 'rgb16 :bpc 16 :r r :g g :b b))

(defmethod canonicalize-channels ((color rgb16))
  (with-channels ((r g b) color)
    (values r g b #xffff)))

(defmethod convert ((source color) (target rgb16))
  (let ((color (canonicalize source)))
    (setf (r target) (r color)
          (g target) (g color)
          (b target) (b color))
    target))
