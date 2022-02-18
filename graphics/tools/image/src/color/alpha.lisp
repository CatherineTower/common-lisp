(in-package #:%mfiano.graphics.tools.image.color)

(defclass alpha ()
  ((%alpha-index
    :type (integer 0 3)
    :reader alpha-index
    :initarg :alpha-index)
   (%pre-multiply-alpha
    :type boolean
    :reader pre-multiplied-alpha-p
    :initarg :pre-multiply-alpha)))

(defmethod initialize-instance :around ((instance alpha) &key alpha-index pre-multiply-alpha)
  (call-next-method)
  (when pre-multiply-alpha
    (let ((channels (channels instance)))
      (dotimes (i (length channels))
        (unless (= i alpha-index)
          (setf (aref channels i) (* (aref channels i) (aref channels alpha-index))))))))
