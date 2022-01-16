(in-package #:mfiano.graphics.tools.color)

(declaim (inline %indexed))
(defstruct (indexed
            (:include color)
            (:constructor %indexed)
            (:predicate nil)
            (:copier nil))
  (palette nil :type palette))

(defun indexed (palette)
  (declare (optimize speed))
  (etypecase palette
    (palette
     (%indexed :palette palette))
    (symbol
     (%indexed :palette (make-palette palette)))))

(defmethod convert ((source color) (target indexed))
  (declare (optimize speed))
  (loop :with palette-colors := (palette-colors (indexed-palette target))
        :with best := most-positive-fixnum
        :with best-index := 0
        :for palette-color :across palette-colors
        :for i :of-type u:array-index :from 0
        :for length-squared :of-type fixnum := (%length-squared source palette-color)
        :when (< length-squared best)
          :do (when (zerop length-squared)
                (return (aref palette-colors i)))
              (setf best length-squared
                    best-index i)
        :finally (return (aref palette-colors best-index))))

(defmethod convert ((source color) (target (eql 'indexed)))
  (declare (optimize speed))
  (convert source (indexed '3-bit-rgb)))
