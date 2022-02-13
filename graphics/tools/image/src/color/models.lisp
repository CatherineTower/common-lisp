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
   (%illuminant-name
    :type (and symbol (not null))
    :reader illuminant-name
    :accessor %illuminant-name
    :initarg :illuminant)
   (%channel-names
    :type list
    :reader channel-names
    :initarg :channel-names)))

(defclass xyz (model) ()
  (:default-initargs
   :model-name 'xyz
   :channel-names '(x y z)))

(defclass rgb (model)
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
   :channel-names '(r g b)))

(defclass luv (model) ()
  (:default-initargs
   :model-name 'luv
   :channel-names '(l u v)))

(u:define-printer (model stream :type nil)
  (format stream "COLOR (model: ~s, space: ~s)~%  ~{~{~a~^: ~}~^~%  ~}"
          (model-name model)
          (space-name model)
          (map 'list #'list
               (channel-names model)
               (m:to-array (data model) :single-float))))

(defun make-color (model-name space-name)
  (u:if-found (args (u:href (base:color-spaces base:*context*) space-name))
    (destructuring-bind (required-model-name . rest) args
      (declare (ignore rest))
      (if (eq model-name required-model-name)
          (apply #'make-instance args)
          (error "Color space ~s is not valid for color model ~s." space-name model-name)))
    (error "Color space ~s is not defined." space-name)))
