(in-package #:%mfiano.graphics.image.base)

(defstruct (context
            (:conc-name nil)
            (:predicate nil)
            (:copier nil))
  (illuminants (u:dict) :type hash-table)
  (color-models nil :type list)
  (color-spaces nil :type list)
  (color-space-data (u:dict) :type hash-table)
  (color-space-graph (make-instance 'graph:digraph))
  (color-pools (make-array (ash 1 16) :initial-element nil) :type (simple-array t (*)))
  (cone-responses (u:dict) :type hash-table)
  (chromatic-adaptation-transforms (u:dict #'equal) :type hash-table)
  (rgb-transforms (u:dict #'equal) :type hash-table)
  (rgb-transform-lock
   (bt:make-lock "rgb-transforms")
   :type bt:lock))

(u:define-printer (context stream :type nil :identity t)
  (format stream "CONTEXT"))

(defvar *context* (make-context))

(defvar *parallel-p* nil)

(defvar *worker-pools* nil)

(defun make-thread-pool (context worker-count)
  (lp:make-kernel worker-count
                  :name "image-worker"
                  :context (lambda (x)
                             (let ((*worker-pools* (make-array (ash 1 16) :initial-element nil)))
                               (funcall x)))
                  :bindings `((*context* . ,context))))

;;; Public interface

(defmacro with-threads ((&optional (count 4)) &body body)
  `(let ((*parallel-p* t)
         (lp:*kernel* (make-thread-pool *context* ,count)))
     ,@body))
