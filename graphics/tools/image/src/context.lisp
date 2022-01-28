(in-package #:mfiano.graphics.tools.image)

(defclass context ()
  ((%thread-pool
    :type lp:kernel
    :reader thread-pool
    :initarg :thread-pool)))

(defun make-thread-pool (&optional worker-count)
  (lp:make-kernel (or worker-count (cl-cpus:get-number-of-processors))
                  :context #'worker-context))

(defun make-context (&key worker-count)
  (make-instance 'context :thread-pool (make-thread-pool worker-count)))

(defvar *context* (make-context))

(defmacro with-context ((context) &body body)
  `(let* ((*context* ,context)
          (lp:*kernel* (thread-pool *context*)))
     ,@body))
