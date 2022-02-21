(in-package #:%mfiano.graphics.image.color)

(defvar *pooling-enabled* nil)

(defun ensure-color-pool (model space)
  (declare (optimize speed))
  (let ((pools (or base:*worker-pools* (base:color-pools base:*context*)))
        (key (cons model space)))
    (declare (dynamic-extent key))
    (or (u:href pools key)
        (let ((array (make-array 2 :adjustable t :fill-pointer 0)))
          (dotimes (i (length array))
            (setf (aref array i) (make-color model :space space)))
          (setf (u:href pools (copy-list key)) array)
          array))))

(declaim (notinline reset-pool-color))
(defun reset-pool-color (color)
  (zero-channels color)
  (copy-illuminant-name color color t)
  (values))

(defun get-pool-color (model space &key copy)
  (declare (optimize speed))
  (let ((space (u:make-keyword space))
        (pool (ensure-color-pool model space)))
    (declare ((vector t) pool))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (make-color model :space space))))
    (let ((color (vector-pop pool)))
      (if copy
          (copy-channels copy color)
          (reset-pool-color color))
      color)))

(defun put-pool-color (color)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool (type-of color) (space-name color))))
    (declare (vector pool))
    (vector-push-extend color pool (array-total-size pool))
    (values)))

(defmacro with-pool-color ((binding model &key space copy) &body body)
  (let ((space (or space model)))
    `(if *pooling-enabled*
         (let ((,binding (get-pool-color ,model ,space :copy ,copy)))
           (unwind-protect (progn ,@body)
             (put-pool-color ,binding)))
         (let ((,binding (make-color ,model :space ,space)))
           ,@(when copy
               `((copy-channels ,copy ,binding)))
           ,@body))))

(defmacro with-pool-colors ((model &rest rest) &body body)
  `(with-pool-color (,model ',model)
     ,@(if rest
           `((with-pool-colors ,rest ,@body))
           body)))
