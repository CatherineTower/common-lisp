(in-package #:%mfiano.graphics.image.color)

(defvar *pooling-enabled* nil)

(defun ensure-color-pool (model space)
  (declare (optimize speed))
  (let ((pools (or base:*worker-pools* (base:color-pools base:*context*)))
        (key (cons model space)))
    (declare (dynamic-extent key))
    (or (u:href pools key)
        (let ((array (make-array 2 :adjustable t :fill-pointer 0)))
          (setf (u:href pools (copy-list key)) array)))))

(declaim (inline reset-pool-color))
(defun reset-pool-color (color)
  (zero-channels color)
  (copy-illuminant-name color color t)
  (values))

(declaim (inline copy-pool-color))
(defun copy-pool-color (from to)
  (copy-channels from to)
  (copy-illuminant-name from to)
  (values))

(defun get-pool-color (model space &key copy)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool model space)))
    (declare ((vector t) pool))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (make-color model :space space))))
    (let ((color (vector-pop pool)))
      (if copy
          (copy-pool-color copy color)
          (reset-pool-color color))
      color)))

(defun put-pool-color (color)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool (type-of color) (space-name color))))
    (declare (vector pool))
    (vector-push-extend color pool (array-total-size pool))
    (values)))

(defmacro with-pool-color ((binding model &key space copy) &body body)
  `(if *pooling-enabled*
       (let ((,binding (get-pool-color ,model ,space :copy ,copy)))
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
