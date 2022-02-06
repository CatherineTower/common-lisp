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

;;; Color space definitions.

(define-color-space xyz ()
  :illuminant :E)
