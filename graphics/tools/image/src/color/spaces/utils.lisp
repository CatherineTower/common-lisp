(in-package #:mfiano.graphics.tools.image)

;;; General color space class, constructor, and definer.

;; Base class that all color spaces either directly or indirectly inherit from.
(defclass color-space ()
  ((%name
    :type (and symbol (not null))
    :reader color-space
    :initarg :name)
   (%illuminant
    :type illuminant
    :reader illuminant
    :accessor %illuminant
    :initarg :illuminant)))

;; Convenience macro for defining generic color spaces.
(defmacro define-color-space (name super-classes &body (&rest initargs))
  `(defclass ,name (color-space ,@super-classes) ()
     (:default-initargs
      :name ',name
      ,@(loop :for (k v) :on initargs :by #'cddr
              :collect k
              :collect `',v))))

;;; RGB color space base class, metadata, and definer.

(defclass rgb ()
  ((%gamma
    :reader gamma
    :initarg :gamma)))

;; Metadata that will be populated during the definition of RGB color spaces.
(gv:define-global-var -rgb-spaces- nil)
(gv:define-global-var -rgb-chromaticity-coordinates- (u:dict))

;; Convenience macro for defining RGB color spaces.
(defmacro define-rgb-color-space (name () &body (&key r g b gamma illuminant))
  `(u:eval-always
     (define-color-space ,name (rgb)
       :gamma ,gamma
       :illuminant ,illuminant)
     (setf (u:href -rgb-chromaticity-coordinates- ',name) '(,r ,g ,b))
     (pushnew ',name -rgb-spaces-)))
