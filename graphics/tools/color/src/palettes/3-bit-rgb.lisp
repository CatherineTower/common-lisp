(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql '3-bit-rgb)))
  (list
   (rgb 0 0 0)
   (rgb 0 0 255)
   (rgb 0 255 0)
   (rgb 0 255 255)
   (rgb 255 0 0)
   (rgb 255 0 255)
   (rgb 255 255 0)
   (rgb 255 255 255)))
