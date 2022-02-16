(in-package #:mfiano.graphics.tools.image.color)

;;; Luv

(defclass luv (model) ()
  (:default-initargs
   :model-name 'luv
   :channel-names '(l u v)))

(defun luv (l u v &key)
  (let ((color (make-color 'luv 'luv)))
    (base:mix color 'storage3 :channel0 l :channel1 u :channel2 v)))

;;; RGB

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

(defun rgb (r g b &key (space 'srgb))
  (let ((color (make-color 'rgb space)))
    (base:mix color 'storage3 :channel0 r :channel1 g :channel2 b)))

(defun rgba (r b g a &key (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-names '(r g b a))
    (base:mix color 'storage4 :channel0 r :channel1 g :channel2 b :channel3 a)
    (base:mix color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

(defmethod default ((model (eql 'rgba)) &rest args)
  (apply #'rgba 0 0 0 1 args))

;;; XYZ

(defclass xyz (model) ()
  (:default-initargs
   :model-name 'xyz
   :channel-names '(x y z)))

(defun xyz (x y z &key)
  (let ((color (make-color 'xyz 'xyz)))
    (base:mix color 'storage3 :channel0 x :channel1 y :channel2 z)))
