(in-package #:%mfiano.graphics.image.color)

(defclass color (storage)
  ((%space-name
    :type symbol
    :reader space-name
    :initarg :space)
   (%default-space-name
    :type (and symbol (not null))
    :reader default-space-name
    :initarg :default-space)
   (%illuminant-name
    :type symbol
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)
   (%default-illuminant-name
    :initarg :default-illuminant
    :reader default-illuminant-name
    :accessor %default-illuminant-name)))

(declaim (inline model-name))
(defun model-name (color)
  (declare (optimize speed))
  (class-name (class-of color)))

(u:define-printer (color stream :type nil)
  (format stream "COLOR (model: ~a, space: ~a, illuminant: ~a)~%  ~{~{~a~^: ~}~^~%  ~}"
          (model-name color)
          (space-name color)
          (illuminant-name color)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names color)
               (channels color))))

(defmethod initialize-instance :after ((instance color) &key space illuminant)
  (let* ((model (model-name instance))
         (space (or space (default-space-name instance))))
    (u:if-found (spec (u:href (base:color-space-data base:*context*) space))
      (destructuring-bind (required-model &rest args &key ((:illuminant default-illuminant))
                           &allow-other-keys)
          spec
        (setf (%default-illuminant-name instance) default-illuminant)
        (let ((args (if illuminant (list* :illuminant illuminant args) args)))
          (if (subtypep model required-model)
              (apply #'reinitialize-instance instance :allow-other-keys t args)
              (error "Color space ~s is not valid for color model ~a." space model))))
      (error "Color space ~s is not defined." space))))

(defun make-color (model &rest args)
  (if (subtypep model 'color)
      (apply #'make-instance model args)
      (error "Color model ~s is not defined." model)))

(declaim (inline copy-illuminant-name))
(defun copy-illuminant-name (from to &optional default)
  (declare (optimize speed))
  (let ((illuminant-name (if default (default-illuminant-name from) (illuminant-name from))))
    (setf (%illuminant-name to) illuminant-name)
    (values)))

(defun register-color-space (space-name model-name &rest args)
  (let ((args (list* model-name :space space-name args)))
    (setf (u:href (base:color-space-data base:*context*) space-name) args)
    (values)))

(defmacro define-model (name superclasses &body body)
  (let ((models (base:color-models base:*context*)))
    (unless (find name models)
      (let ((id (1+ (length models)))
            (max 256))
        (when (>= id max)
          (error "Total number of color model definitions exceeded the maximum of ~d ~
                  when trying to define color model: ~s."
                 (1- max)
                 name))
        (u:appendf (base:color-models base:*context*) `(,name))
        (setf (get name :model-id) id))))
  `(defclass ,name ,(or superclasses '(color)) ()
     (:default-initargs
      ,@(car body))))

(defmacro define-color-space (name () &key (model name) (illuminant :d65) (gamma 2.2d0) coords)
  (let ((space-list (base:color-spaces base:*context*)))
    (unless (find name space-list)
      (let ((id (1+ (length space-list)))
            (max 256))
        (when (>= id 256)
          (error "Total number of color space definitions exceeded the maximum of ~d ~
                  when trying to define color space: ~s."
                 (1- max)
                 name))
        (u:appendf (base:color-spaces base:*context*) `(,name))
        (setf (get name :space-id) id))))
  `(register-color-space ',name ',model :illuminant ',illuminant :gamma ',gamma :coords ',coords))
