(in-package #:mfiano.graphics.tools.image.color)

(defclass color-model ()
  ((%model-name
    :type (and symbol (not null))
    :reader model-name
    :initarg :model-name)
   (%space-name
    :type (and symbol (not null))
    :reader space-name
    :initarg :space)
   (%illuminant-name
    :type (and symbol (not null))
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)
   (%channel-order
    :type list
    :reader channel-order
    :initarg :channel-order)))

(defclass xyz (color-model) ()
  (:default-initargs
   :model-name 'xyz
   :channel-order '(x y z)))

(defclass rgb (color-model)
  ((%coords
    :type list
    :reader coords
    :initarg :coords)
   (%gamma
    :type (or u:positive-float symbol)
    :reader gamma
    :initarg :gamma))
  (:default-initargs
   :model-name 'rgb
   :channel-order '(r g b)))

(u:define-printer (color-model stream :type nil)
  (format stream "COLOR (model: ~a, space: ~s)~%  ~{~{~a~^: ~}~^~%  ~}"
          (model-name color-model)
          (space-name color-model)
          (map 'list (lambda (x y) (list x (float y 1f0)))
               (channel-order color-model)
               (data color-model))))

(defun make-color (model-name space-name)
  (u:if-found (args (u:href (b::color-spaces b::*context*) space-name))
    (destructuring-bind (required-model-name . rest) args
      (declare (ignore rest))
      (if (eq model-name required-model-name)
          (apply #'make-instance args)
          (error "Color space ~s is not valid for color model ~s." space-name model-name)))
    (error "Color space ~s is not defined." space-name)))
