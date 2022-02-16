(in-package #:mfiano.graphics.tools.image.color)

(defclass model ()
  ((%model-name
    :type (and symbol (not null))
    :reader model-name
    :initarg :model-name)
   (%space-name
    :type (and symbol (not null))
    :reader space-name
    :initarg :space)
   (%default-illuminant-name
    :type (and symbol (not null))
    :reader default-illuminant-name)
   (%illuminant-name
    :type (and symbol (not null))
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)
   (%channel-names
    :type list
    :reader channel-names
    :initarg :channel-names)))

(defmethod initialize-instance :after ((instance model) &key illuminant)
  (setf (slot-value instance '%default-illuminant-name) illuminant))

(u:define-printer (model stream :type nil)
  (format stream "COLOR (model: ~s, space: ~s)~%  ~{~{~a~^: ~}~^~%  ~}"
          (model-name model)
          (space-name model)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names model)
               (data model))))

(defun register-color-space (model-name space-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-spaces base:*context*) space-name) args)
    (values)))

(defun get-color-space-args (space-name)
  (u:href (base:color-spaces base:*context*) space-name))

(defun make-color (model-name space-name)
  (u:if-found (args (get-color-space-args space-name))
    (destructuring-bind (required-model-name . rest) args
      (declare (ignore rest))
      (if (eq model-name required-model-name)
          (apply #'make-instance args)
          (error "Color space ~s is not valid for color model ~s." space-name model-name)))
    (error "Color space ~s is not defined." space-name)))

(defmacro define-builtin-color-spaces (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (space-name &rest args &key model &allow-other-keys) x
            (let ((args (loop :for (k v) :on args :by #'cddr :collect k :collect `',v))
                  (model-name (or model space-name)))
              `(register-color-space ',model-name ',space-name ,@(u:plist-remove args :model)))))
        body)))

(defmacro define-rgb-value-converters ((from))
  (u:with-gensyms (color)
    (let* ((model-spaces (u:hash-values (base:color-spaces base:*default-context*)))
           (rgb-spaces (mapcar
                        (lambda (x) (u:plist-get (cdr x) :space))
                        (remove-if-not (lambda (x) (eq x 'rgb)) model-spaces :key #'car))))
      `(progn
         ,@(mapcar
            (lambda (x)
              (destructuring-bind (from to) x
                `(defmethod base:convert ((from ,from) (to (eql ',to)))
                   (with-pool-color (,color to)
                     (extract-values (base:convert from ,color))))))
            (u:map-product #'list `(,from) rgb-spaces))))))
