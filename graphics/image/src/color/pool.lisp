(in-package #:%mfiano.graphics.image.color)

(defvar *pooling-enabled* t)

(defun ensure-color-pool (pool-index)
  (declare (optimize speed))
  (let ((pools (or base:*worker-pools* (base:color-pools base:*context*))))
    (declare ((simple-array t (*)) pools))
    (or (aref pools pool-index)
        (setf (aref pools pool-index) (make-array 2 :adjustable t :fill-pointer 0)))))

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

(defun get-pool-color (pool-index model space &key copy)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool pool-index)))
    (declare ((vector t) pool))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (make-color model :space space))))
    (let ((color (vector-pop pool)))
      (if copy
          (copy-pool-color copy color)
          (reset-pool-color color))
      color)))

(defun put-pool-color (pool-index color)
  (declare (optimize speed))
  (let ((pool (ensure-color-pool pool-index)))
    (declare (vector pool))
    (vector-push-extend color pool (array-total-size pool))
    (values)))

(defmacro with-pool-color ((binding model &key space copy) &body body)
  (u:with-gensyms (pool-index model-id space-id)
    `(if *pooling-enabled*
         (let* ((,model-id (get ,model :model-id))
                (,space-id (if ,space (get ,space :space-id) 0))
                (,pool-index (logior ,model-id (ash ,space-id 8)))
                (,binding (get-pool-color ,pool-index ,model ,space :copy ,copy)))
           (declare (u:ub8 ,model-id ,space-id))
           (unwind-protect (progn ,@body)
             ,pool-index
             (put-pool-color ,pool-index ,binding)))
         (let ((,binding (make-color ,model :space ,space)))
           ,@(when copy
               `((copy-pool-color ,copy ,binding)))
           ,@body))))

;; (defmacro with-pool-color ((binding model &key space copy) &body body)
;;   `(if *pooling-enabled*
;;        (let ((,binding (get-pool-color ,model ,space :copy ,copy)))
;;          (unwind-protect (progn ,@body)
;;            (put-pool-color ,binding ,model ,space)))
;;        (let ((,binding (make-color ,model :space ,space)))
;;          ,@(when copy
;;              `((copy-pool-color ,copy ,binding)))
;;          ,@body)))

(defmacro with-pool-colors ((model &rest rest) &body body)
  `(with-pool-color (,model ',model)
     ,@(if rest
           `((with-pool-colors ,rest ,@body))
           body)))
