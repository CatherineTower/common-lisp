(in-package #:%mfiano.graphics.image.color)

(defvar *pooling-enabled* t)

(defun ensure-color-pool (model)
  (declare (optimize speed))
  (let ((pools (or base:*worker-pools* (base:color-pools base:*context*))))
    (or (u:href pools model)
        (let ((array (make-array 2 :adjustable t :fill-pointer 0)))
          (dotimes (i (length array))
            (setf (aref array i) (make-color model)))
          (setf (u:href pools model) array)
          array))))

(declaim (notinline reset-pool-color))
(defun reset-pool-color (color)
  (zero-channels color)
  (copy-illuminant-name color color t)
  (setf (%space-name color) (default-space-name color))
  (values))

(declaim (notinline copy-pool-color))
(defun copy-pool-color (from to)
  (copy-channels from to)
  (copy-illuminant-name from to)
  (setf (%space-name to) (%space-name from))
  (values))

(defun get-pool-color (model &key space copy)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool model)))
    (declare ((vector t) pool))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (make-color model))))
    (let ((color (vector-pop pool)))
      (if copy
          (copy-pool-color copy color)
          (reset-pool-color color))
      (when space
        (setf (%space-name color) space))
      color)))

(defun put-pool-color (color)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool (type-of color))))
    (declare (vector pool))
    (vector-push-extend color pool (array-total-size pool))
    (values)))

(defmacro with-pool-color ((binding model &key space copy) &body body)
  `(if *pooling-enabled*
       (let ((,binding (get-pool-color ,model :space ,space :copy ,copy)))
         (unwind-protect (progn ,@body)
           (put-pool-color ,binding)))
       (let ((,binding (make-color ,model :space ,space)))
         ,@(when copy
             `((copy-pool-color ,copy ,binding)))
         ,@body)))

(defmacro with-pool-colors ((model &rest rest) &body body)
  `(with-pool-color (,model ',model)
     ,@(if rest
           `((with-pool-colors ,rest ,@body))
           body)))
