(in-package #:%mfiano.graphics.image.base)

(defstruct (context
            (:conc-name nil)
            (:predicate nil)
            (:copier nil))
  (illuminants (u:dict) :type hash-table)
  (color-space-data (u:dict) :type hash-table)
  (color-space-graph (make-instance 'graph:digraph))
  (color-pools (u:dict #'equal) :type hash-table)
  (cone-responses (u:dict) :type hash-table)
  (chromatic-adaptation-transforms (u:dict #'equal) :type hash-table)
  (rgb-transforms (u:dict #'equal) :type hash-table))

(u:define-printer (context stream :type nil :identity t)
  (format stream "CONTEXT"))

(defvar *context* (make-context))

(defvar *parallel-p* nil)

(defvar *worker-pools* nil)

(defun make-thread-pool (context worker-count)
  (lp:make-kernel worker-count
                  :name "image-worker"
                  :context (lambda (x)
                             (let ((*worker-pools* (u:dict #'equal)))
                               (funcall x)))
                  :bindings `((*context* . ,context))))

;;; Public interface

(defmacro with-threads ((&optional (count 4)) &body body)
  `(let ((*parallel-p* t)
         (lp:*kernel* (make-thread-pool *context* ,count)))
     ,@body))
