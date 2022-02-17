(in-package #:%mfiano.graphics.tools.image.color)

(defclass alpha ()
  ((%alpha-index
    :type (integer 0 3)
    :reader alpha-index)
   (%pre-multiply-alpha
    :type boolean
    :reader pre-multiply-alpha-p)))

(defmethod initialize-instance :after ((instance alpha) &key alpha-index pre-multiply-alpha)
  (when pre-multiply-alpha
    (let ((data (data instance)))
      (dotimes (i (length data))
        (unless (= i alpha-index)
          (setf (aref data i) (* (aref data i) (aref data alpha-index))))))))
