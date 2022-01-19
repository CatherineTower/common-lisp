(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql '3-3-2-bit-rgb8)))
  (list
   (rgb8 0 0 0)
   (rgb8 36 0 0)
   (rgb8 73 0 0)
   (rgb8 109 0 0)
   (rgb8 146 0 0)
   (rgb8 182 0 0)
   (rgb8 219 0 0)
   (rgb8 255 0 0)
   (rgb8 0 36 0)
   (rgb8 0 73 0)
   (rgb8 0 109 0)
   (rgb8 0 146 0)
   (rgb8 0 182 0)
   (rgb8 0 219 0)
   (rgb8 0 255 0)
   (rgb8 0 0 85)
   (rgb8 0 0 170)
   (rgb8 0 0 255)))
