(in-package #:%mfiano.graphics.tools.image.color)

(defclass alpha ()
  ((%alpha-index
    :type (integer 0 3)
    :reader alpha-index
    :initarg :alpha-index)
   (%pre-multiplied-alpha
    :type (member :auto t nil)
    :reader pre-multiplied-alpha-p
    :initarg :pre-multiply-alpha)))

(defmethod initialize-instance :around ((instance alpha) &key pre-multiply-alpha)
  (call-next-method)
  (when (eq pre-multiply-alpha :auto)
    (pre-multiply-alpha instance)
    (setf (slot-value instance '%pre-multiplied-alpha) t))
  instance)

(defgeneric pre-multiply-alpha (color)
  (:method ((color alpha))
    (let* ((channels (channels color))
           (index (alpha-index color))
           (alpha (aref channels index)))
      (dotimes (i (length channels))
        (unless (= i index)
          (setf (aref channels i) (* (aref channels i) alpha)))))))

(defgeneric un-pre-multiple-alpha (color)
  (:method ((color alpha))
    (let* ((channels (channels color))
           (index (alpha-index color))
           (alpha (aref channels index)))
      (dotimes (i (length channels))
        (unless (= i index)
          (setf (aref channels i) (if (zerop alpha) 0d0 (/ (aref channels i) alpha))))))))
