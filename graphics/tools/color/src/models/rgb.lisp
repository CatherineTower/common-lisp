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

(defun rgb (r g b &key (bpc 8))
  (make-instance 'rgb :bpc bpc :r r :g g :b b))

(defmethod zero :after ((color rgb))
  (setf (r color) 0
        (g color) 0
        (b color) 0))

(defmethod replace :after ((source rgb) (target rgb))
  (setf (r target) (r source)
        (g target) (g source)
        (b target) (b source)))

(defmethod shift :after ((color rgb) (bit-count fixnum))
  (setf (r color) (%shift (r color) bit-count)
        (g color) (%shift (g color) bit-count)
        (b color) (%shift (b color) bit-count)))

(defmethod or-shift :after ((color rgb) (bit-count (eql 8)))
  (setf (r color) (%or-shift (r color) 8)
        (g color) (%or-shift (g color) 8)
        (b color) (%or-shift (b color) 8)))

(defmethod scale :after ((color rgb) (scalar fixnum))
  (setf (r color) (* (r color) scalar)
        (g color) (* (g color) scalar)
        (b color) (* (b color) scalar)))

(defmethod unscale :after ((color rgb) (scalar fixnum))
  (setf (r color) (truncate (r color) scalar)
        (g color) (truncate (g color) scalar)
        (b color) (truncate (b color) scalar)))

(defmethod canonicalize ((color rgb))
  (or-shift color 8)
  (rgba (r color) (g color) (b color) #xffff :bpc 16 :pma t))

(defmethod convert ((source color) (target rgb))
  (replace (shift (canonicalize source) -8) target))
