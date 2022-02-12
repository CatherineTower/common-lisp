(in-package #:mfiano.graphics.tools.image.color)

(defun register-color-space (name type &rest args)
  (setf (u:href (base:color-spaces base:*context*) name) (list* type :space name args))
  (values))

(defmacro define-builtin-color-spaces (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v)))
              `(register-color-space ',name ',(or model name) ,@(u:plist-remove args :model)))))
        body)))
