(in-package #:mfiano.graphics.tools.image)

;;; General color space class, constructor, and definer.

;; Base class that all color spaces either directly or indirectly inherit from.
(defclass color-space ()
  ((%name
    :type (and symbol (not null))
    :reader color-space
    :initarg :name)
   (%standard-illuminant
    :type standard-illuminant
    :reader standard-illuminant
    :initarg :standard-illuminant)))

;; Convenience macro for defining generic color spaces.
(defmacro define-color-space (name super-classes &body (&key standard-illuminant))
  `(defclass ,name ,(or super-classes '(color-space)) ()
     (:default-initargs
      :name ',name
      :standard-illuminant ',standard-illuminant)))

;;; RGB color space base class, metadata, and definer.

;; Base class all RGB color spaces inherit from
(defclass rgb (color-space) ())

;; Metadata that will be populated during the definition of RGB color spaces.
(gv:define-global-var -rgb-spaces- nil)
(gv:define-global-var -rgb-chromaticity-coordinates- (u:dict))

;; Convenience macro for defining RGB color spaces.
(defmacro define-rgb-color-space (name () &body (&key r g b standard-illuminant))
  `(u:eval-always
     (define-color-space ,name (rgb)
       :standard-illuminant ,standard-illuminant)
     (setf (u:href -rgb-chromaticity-coordinates- ',name) '(,r ,g ,b))
     (pushnew ',name -rgb-spaces-)))
