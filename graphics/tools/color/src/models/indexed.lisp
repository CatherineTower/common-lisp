(in-package #:mfiano.graphics.tools.color)

(defstruct (indexed
            (:include model)
            (:constructor %indexed)
            (:predicate nil)
            (:copier nil))
  (palette nil :type palette))

(defun indexed (palette-name)
  (%indexed :palette (make-palette palette-name)))

(defmethod convert ((source model) (target indexed))
  (loop :with palette-colors := (palette-colors (indexed-palette target))
        :with best := 0
        :with best-index := 0
        :for palette-color :across palette-colors
        :for i :from 0
        :for length-squared := (%length-squared source palette-color)
        :when (< length-squared best)
          :do (when (zerop length-squared)
                (return (aref palette-colors i)))
              (setf best length-squared
                    best-index i)
        :finally (return (aref palette-colors best-index))))
