(in-package #:%mfiano.graphics.tools.image.base)

(defvar *worker-state*)

(defclass worker-state ()
  ((%color-pools
    :type hash-table
    :reader color-pools
    :initform (u:dict #'eq))))

(defun worker-context (worker)
  (let ((*worker-state* (make-instance 'worker-state)))
    (funcall worker)))
