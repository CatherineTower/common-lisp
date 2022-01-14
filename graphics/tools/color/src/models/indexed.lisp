(in-package #:mfiano.graphics.tools.color)

(defstruct (indexed
            (:include model)
            (:constructor indexed (palette))
            (:predicate nil)
            (:copier nil))
  (palette nil :type palette))

(defmethod convert ((source model) (target palette))
  (loop :with palette-colors := (palette-colors palette)
        :with best := 0
        :for palette-color :across palette-colors
        :for i :from 0
        :for length-squared := (%length-squared color palette-color)
        :when (< length-squared best)
          :do (when (zerop length-squared)
                (return (aref palette-colors i)))
              (setf best length-squared)
        :finally (return (aref palette-colors i))))
