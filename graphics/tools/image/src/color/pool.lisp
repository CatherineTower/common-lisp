(in-package #:%mfiano.graphics.tools.image.color)

(declaim (inline make-pool-color))
(defun make-pool-color (model-name space-name)
  (default model-name :space space-name :allow-other-keys t))

(defun ensure-color-pool (model-name space-name)
  (declare (optimize speed))
  (let ((pools (base:color-pools base:*worker-state*)))
    (or (u:href pools space-name)
        (let ((array (make-array 2 :adjustable t :fill-pointer 0)))
          (dotimes (i (length array))
            (setf (aref array i) (make-pool-color model-name space-name)))
          (setf (u:href pools space-name) array)
          array))))

(declaim (inline reset-pool-color))
(defun reset-pool-color (color)
  (zero-storage color)
  (setf (%illuminant-name color) (default-illuminant-name color))
  (values))

(defun get-pool-color (space-name &key copy)
  (declare (optimize speed))
  (let* ((model-name (car (get-color-space-args space-name)))
         (pool (ensure-color-pool model-name space-name)))
    (declare ((vector t) pool))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (make-pool-color model-name space-name))))
    (let ((color (vector-pop pool)))
      (if copy
          (copy-storage copy color)
          (reset-pool-color color))
      color)))

(defun put-pool-color (color)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool (model-name color) (space-name color))))
    (declare (vector pool))
    (vector-push-extend color pool (array-total-size pool))
    (values)))

(defmacro with-pool-color ((binding space-name &key copy) &body body)
  (u:with-gensyms (model-name)
    `(if (boundp 'base:*worker-state*)
         (let ((,binding (get-pool-color ,space-name :copy ,copy)))
           (unwind-protect (progn ,@body)
             (put-pool-color ,binding)))
         (let* ((,model-name (car (get-color-space-args ,space-name)))
                (,binding (make-pool-color ,model-name ,space-name)))
           ,@(when copy
               `((copy-storage ,copy ,binding)))
           ,@body))))
