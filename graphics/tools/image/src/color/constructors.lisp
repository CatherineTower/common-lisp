(in-package #:mfiano.graphics.tools.image.color)

;;; Luv

(defun luv (l u v)
  (let ((color (make-color 'luv 'luv)))
    (base:mix color 'storage3 :channel0 l :channel1 u :channel2 v)))

;;; RGB

(defun rgb (r g b &key (space 'srgb))
  (let ((color (make-color 'rgb space)))
    (base:mix color 'storage3 :channel0 r :channel1 g :channel2 b)))

(defun rgba (r b g a &key (space 'srgb) pre-multiply-alpha)
  (let ((color (make-color 'rgb space)))
    (reinitialize-instance color :channel-names '(r g b a))
    (base:mix color 'storage4 :channel0 r :channel1 g :channel2 b :channel3 a)
    (base:mix color 'alpha :alpha-index 3 :pre-multiply-alpha pre-multiply-alpha)))

;;; XYZ

(defun xyz (x y z)
  (let ((color (make-color 'xyz 'xyz)))
    (base:mix color 'storage3 :channel0 x :channel1 y :channel2 z)))

;;; Defaults

(defgeneric default (model &rest args)
  (:method ((model symbol) &rest args)
    (apply model 0 0 0 args))
  (:method ((model (eql 'rgba)) &rest args)
    (apply #'rgba 0 0 0 1 args)))
