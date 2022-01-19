(in-package #:mfiano.graphics.tools.color)

(defclass alpha (color)
  ((%a :accessor a
       :initarg :a
       :initform 0)))

(defun alpha (value &key (bpc 8))
  (make-instance 'alpha :bpc bpc :a value))

(defmethod decompose ((color alpha))
  (a color))

(defmethod canonicalize ((source alpha))
  (let ((a (%or-shift-8bpc source (a source))))
    (rgba a a a a :bpc 16 :pma t)))

(defmethod convert ((source color) (target alpha))
  (let ((color (canonicalize source)))
    (setf (a target) (%or-shift-8bpc target (a color) -8))
    target))
