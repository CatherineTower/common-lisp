(in-package #:mfiano.graphics.tools.color)

(defclass indexed (color)
  ((%palette :reader palette
             :initarg :palette
             :initform (make-palette '3-bit-rgb))))

(defun indexed (palette)
  (etypecase palette
    (palette
     (make-instance 'indexed :palette palette))
    (symbol
     (make-instance 'indexed :palette (make-palette palette)))))

(defmethod convert ((source color) (target indexed))
  (loop :with palette-colors := (colors (palette target))
        :with best := most-positive-fixnum
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
