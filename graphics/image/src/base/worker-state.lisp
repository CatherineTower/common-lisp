(in-package #:%mfiano.graphics.image.base)

(defclass worker-state ()
  ((%color-pools
    :type (simple-array t (*))
    :reader color-pools
    :initform (make-array (ash 1 16) :initial-element nil))
   (%chromatic-adaptation-transforms
    :type hash-table
    :reader chromatic-adaptation-transforms
    :initform (u:dict #'equal))
   (%rgb-transforms
    :type hash-table
    :reader rgb-transforms
    :initform (u:dict #'equal))))

(defun make-worker-state ()
  (make-instance 'worker-state))

(defvar *worker-state* (make-worker-state))
