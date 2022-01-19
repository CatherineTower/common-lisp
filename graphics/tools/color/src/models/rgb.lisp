(in-package #:mfiano.graphics.tools.color)

(defclass rgb (color)
  ((%r :accessor r
       :initarg :r
       :initform 0)
   (%g :accessor g
       :initarg :g
       :initform 0)
   (%b :accessor b
       :initarg :b
       :initform 0)))

(declaim (inline %rgb))
(defun %rgb (r g b &key bpc)
  (%check-bpc-values bpc r g b)
  (make-instance 'rgb :bpc bpc :r r :g g :b b))

(defun rgb8 (&optional (r 0) (g 0) (b 0))
  (%rgb r g b :bpc 8))

(defun rgb16 (&optional (r 0) (g 0) (b 0))
  (%rgb r g b :bpc 16))

(defmethod decompose ((color rgb))
  (values (r color) (g color) (b color)))

(defmethod canonicalize ((source rgb))
  (rgba16-pma (%or-shift-8bpc source (r source))
              (%or-shift-8bpc source (g source))
              (%or-shift-8bpc source (b source))))

(defmethod convert ((source color) (target rgb))
  (let ((color (canonicalize source)))
    (setf (r target) (%shift (r color) -8)
          (g target) (%shift (g color) -8)
          (b target) (%shift (b color) -8))
    target))
