(in-package #:mfiano.graphics.tools.color)

(defclass alpha (color)
  ((%a :accessor a
       :initarg :a
       :initform 0)))

(defun alpha (value &key (bpc 8))
  (make-instance 'alpha :bpc bpc :a value))

(defmethod zero :after ((color alpha))
  (setf (a color) 0))

(defmethod replace :after ((source alpha) (target alpha))
  (setf (a target) (a source)))

(defmethod or-shift :after ((color alpha) (bit-count (eql 8)))
  (setf (a color) (%or-shift (a color) 8)))

(defmethod shift :after ((color alpha) (bit-count fixnum))
  (setf (a color) (%shift (a color) 8)))

(defmethod canonicalize ((color alpha))
  (let ((a (or-shift color 8)))
    (rgba a a a a :bpc 16 :pma t)))

(defmethod convert ((source color) (target alpha))
  (let ((color (canonicalize source)))
    (setf (a target) (if (= (bpc target) 8) (%shift (a color) -8) (a color)))
    target))
