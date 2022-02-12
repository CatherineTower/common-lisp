(in-package #:%mfiano.graphics.tools.image.internal.base)

(defvar *worker-state*)

(defclass worker-state ()
  ((%vectors
    :type (simple-vector 4)
    :reader vectors
    :initform (make-array 4))))

(defun make-worker-state ()
  (let* ((state (make-instance 'worker-state))
         (vectors (vectors state)))
    (dotimes (i (length vectors))
      (setf (aref vectors i) (v3:zero)))
    state))

(defun worker-context (worker)
  (let ((*worker-state* (make-worker-state)))
    (funcall worker)))
