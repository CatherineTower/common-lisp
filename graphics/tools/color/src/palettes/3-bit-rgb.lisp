(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql '3-bit-rgb)))
  (list
   (rgb8 0 0 0)
   (rgb8 0 0 255)
   (rgb8 0 255 0)
   (rgb8 0 255 255)
   (rgb8 255 0 0)
   (rgb8 255 0 255)
   (rgb8 255 255 0)
   (rgb8 255 255 255)))
