(in-package #:%mfiano.graphics.tools.image.base)

(defclass context ()
  ((%mixins
    :type hash-table
    :reader mixins
    :allocation :class
    :initform (u:dict #'equal))
   (%thread-pool
    :type lp:kernel
    :reader thread-pool
    :accessor %thread-pool)
   (%illuminants
    :type hash-table
    :reader illuminants
    :initarg :illuminants
    :initform (u:dict))
   (%color-spaces
    :type hash-table
    :reader color-spaces
    :initarg :color-spaces
    :initform (u:dict))
   (%cone-responses
    :type hash-table
    :reader cone-responses
    :initarg :cone-responses
    :initform (u:dict))
   (%chromatic-adaptation-transforms
    :type hash-table
    :reader chromatic-adaptation-transforms
    :initform (u:dict #'equal))
   (%rgb-transforms
    :type hash-table
    :reader rgb-transforms
    :initform (u:dict #'equal))))

(defun make-thread-pool (context &optional worker-count)
  (lp:make-kernel (or worker-count (cl-cpus:get-number-of-processors))
                  :name "image-worker"
                  :context #'worker-context
                  :bindings `((*context* . ,context))))

(defun copy-context (context)
  (make-instance 'context
                 :illuminants (u:copy-hash-table (illuminants context))
                 :color-spaces (u:copy-hash-table (color-spaces context))
                 :cone-responses (u:copy-hash-table (cone-responses context))))

(defun %make-context (&key default (worker-count 4))
  (let ((context (if default (copy-context default) (make-instance 'context))))
    (setf (%thread-pool context) (make-thread-pool context worker-count))
    context))

(defvar *default-context* (%make-context))

(defvar *context*)

;;; Public interface

(defun make-context (&key worker-count)
  (%make-context :default *default-context* :worker-count worker-count))

(defmacro with-context ((context) &body body)
  `(let* ((*context* ,context)
          (lp:*kernel* (thread-pool *context*)))
     ,@body))
