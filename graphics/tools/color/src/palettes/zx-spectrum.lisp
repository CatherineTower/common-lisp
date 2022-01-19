(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql 'zx-spectrum)))
  (list
   (rgb8 0 0 0)
   (rgb8 0 0 215)
   (rgb8 215 0 0)
   (rgb8 215 0 215)
   (rgb8 0 215 0)
   (rgb8 0 215 215)
   (rgb8 215 215 0)
   (rgb8 215 215 215)
   (rgb8 0 0 255)
   (rgb8 255 0 0)
   (rgb8 255 0 255)
   (rgb8 0 255 0)
   (rgb8 0 255 255)
   (rgb8 255 255 0)
   (rgb8 255 255 255)))
