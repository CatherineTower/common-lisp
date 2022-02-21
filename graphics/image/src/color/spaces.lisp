(in-package #:%mfiano.graphics.image.color)

(declaim (notinline get-color-space-spec))
(defun get-color-space-spec (space-name)
  (u:href (base:color-spaces base:*context*) space-name))

(declaim (notinline get-space-model))
(defun get-space-model (space-name)
  (car (get-color-space-spec space-name)))

(defun register-color-space (space-name model-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defmacro define-color-spaces (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key models &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v)))
              `(register-color-space ',space-name ',models ,@(u:plist-remove args :model)))))
        body)))
