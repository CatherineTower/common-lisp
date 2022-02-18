(in-package #:%mfiano.graphics.tools.image.color)

(defclass alpha ()
  ((%alpha-index
    :type (integer 0 3)
    :reader alpha-index)
   (%pre-multiply-alpha
    :type boolean
    :reader pre-multiply-alpha-p)))

(defmethod initialize-instance :around ((instance alpha) &key alpha-index pre-multiply-alpha)
  (call-next-method)
  (when pre-multiply-alpha
    (let ((channels (channels instance)))
      (dotimes (i (length channels))
        (unless (= i alpha-index)
          (setf (aref channels i) (* (aref channels i) (aref channels alpha-index))))))))
