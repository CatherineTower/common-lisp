(in-package #:%mfiano.graphics.tools.image.base)

(defstruct (context
            (:conc-name nil)
            (:predicate nil)
            (:copier nil))
  (illuminants (u:dict) :type hash-table)
  (color-spaces (u:dict) :type hash-table)
  (cone-responses (u:dict) :type hash-table)
  (chromatic-adaptation-transforms (u:dict #'equal) :type hash-table)
  (rgb-transforms (u:dict #'equal) :type hash-table))

(defvar *context* (make-context))

(defvar *parallel-p* nil)

(defvar *worker-pools*)

(defun make-thread-pool (context worker-count)
  (lp:make-kernel worker-count
                  :name "image-worker"
                  :context (lambda (x)
                             (let ((*worker-pools* (u:dict #'eq)))
                               (funcall x)))
                  :bindings `((*context* . ,context))))

;;; Public interface

(defmacro with-threads ((&optional (count 4)) &body body)
  `(let ((*parallel-p* t)
         (lp:*kernel* (make-thread-pool *context* ,count)))
     ,@body))
