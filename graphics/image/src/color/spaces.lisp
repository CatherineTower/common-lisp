(in-package #:%mfiano.graphics.image.color)

(declaim (inline get-color-space-spec))
(defun get-color-space-spec (space-name)
  (u:href (base:color-spaces base:*context*) space-name))

(declaim (inline get-space-model))
(defun get-space-model (space-name)
  (car (get-color-space-spec space-name)))

(defun register-color-space (model-name space-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defmacro define-color-spaces (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v))
                  (model-name (or model space-name)))
              `(register-color-space ',model-name ',space-name ,@(u:plist-remove args :model)))))
        body)))
