(in-package #:%mfiano.graphics.image.base)

(defvar *parallel-p* nil)

(defun make-thread-pool (context worker-count)
  (lp:make-kernel worker-count
                  :name "image-worker"
                  :context (lambda (x)
                             (let ((*worker-state* (make-worker-state)))
                               (funcall x)))
                  :bindings `((*context* . ,context))))

(defmacro with-threads ((&optional (count 4)) &body body)
  `(let ((*parallel-p* t)
         (lp:*kernel* (make-thread-pool *context* ,count)))
     ,@body))
