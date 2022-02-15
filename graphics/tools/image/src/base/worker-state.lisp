(in-package #:%mfiano.graphics.tools.image.internal.base)

(defvar *worker-state*)

(defclass worker-state ()
  ((%colors
    :type hash-table
    :reader colors
    :initform (u:dict #'eq))))

(defun worker-context (worker)
  (let ((*worker-state* (make-instance 'worker-state)))
    (funcall worker)))
