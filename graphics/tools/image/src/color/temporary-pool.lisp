(in-package #:mfiano.graphics.tools.image.color)

(defun ensure-color-pool (model-name space-name)
  (let ((colors (base:colors base:*worker-state*)))
    (or (u:href colors space-name)
        (let ((array (make-array 2 :adjustable t :fill-pointer 0)))
          (dotimes (i (length array))
            (setf (aref array i) (default model-name :space-name space-name :allow-other-keys t)))
          (setf (u:href colors space-name) array)
          array))))

(defun request-temporary-color (space-name &key copy)
  (let* ((model-name (car (get-color-space-args space-name)))
         (pool (ensure-color-pool model-name space-name)))
    (when (zerop (fill-pointer pool))
      (map-into pool (lambda () (default model-name :space space-name :allow-other-keys t))))
    (let ((color (vector-pop pool)))
      (when copy
        (m:copy! (data copy) (data color)))
      color)))

(defun reset-temporary-color (color)
  (setf (%illuminant-name color) (default-illuminant-name color))
  (m:zero! (data color))
  (values))

(defun return-temporary-color (color)
  (let ((pool (ensure-color-pool (model-name color) (space-name color))))
    (reset-temporary-color color)
    (vector-push-extend color pool (array-total-size pool))))

(defmacro with-temporary-color ((binding space-name &key copy) &body body)
  (u:with-gensyms (model-name)
    `(if (boundp '*worker-state*)
         (let ((,binding (request-temporary-color ,space-name :copy ,copy)))
           (unwind-protect (progn ,@body)
             (return-temporary-color ,binding)))
         (let* ((,model-name (car (get-color-space-args ,space-name)))
                (,binding (default ,model-name :space ,space-name :allow-other-keys t)))
           ,@body))))
