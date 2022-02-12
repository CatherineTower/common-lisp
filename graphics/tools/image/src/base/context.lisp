(in-package #:%mfiano.graphics.tools.image.internal.base)

(defclass context ()
  ((%mixins
    :type hash-table
    :reader mixins
    :allocation :class
    :initform (u:dict #'equal))
   (%thread-pool
    :type lp:kernel
    :reader thread-pool
    :initarg :thread-pool)
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

(defun make-thread-pool (&optional worker-count)
  (lp:make-kernel (or worker-count (cl-cpus:get-number-of-processors))
                  :context #'worker-context))

(defvar *default-context*
  (make-instance 'context :thread-pool (make-thread-pool 4)))

(defvar *context*)

(defun copy-default-context ()
  (let ((default *default-context*))
    (make-instance 'context
                   :illuminants (u:copy-hash-table (illuminants default))
                   :color-spaces (u:copy-hash-table (color-spaces default))
                   :cone-responses (u:copy-hash-table (cone-responses default)))))

(defun make-context (&key worker-count)
  (let ((context (copy-default-context)))
    (reinitialize-instance context :thread-pool (make-thread-pool worker-count))
    context))

(defmacro with-context ((context) &body body)
  `(let* ((*context* ,context)
          (lp:*kernel* (thread-pool *context*)))
     ,@body))
