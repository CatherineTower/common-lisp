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

(u:define-printer (color stream :type nil)
  (format stream "COLOR (model: ~a, space: ~a, illuminant: ~a)~%  ~{~{~a~^: ~}~^~%  ~}"
          (type-of color)
          (space-name color)
          (illuminant-name color)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-names color)
               (channels color))))

(defmethod initialize-instance :after ((instance color) &key space illuminant)
  (let* ((model (type-of instance))
         (space (or space (default-space-name instance))))
    (u:if-found (spec (get-color-space-spec space))
      (destructuring-bind (space &rest args &key models ((:illuminant default-illuminant)) &allow-other-keys) spec
        (setf (%default-illuminant-name instance) default-illuminant)
        (let ((args (if illuminant (list* :illuminant illuminant args) args)))
          (if (member model models)
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