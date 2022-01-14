(in-package #:mfiano.graphics.tools.color)

(defstruct (model
            (:constructor nil)
            (:copier nil)))

(defstruct (palette
            (:constructor %make-palette)
            (:predicate nil)
            (:copier nil))
  (colors #() :type simple-vector))
