(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql 'cga)))
  (list
   (rgb8 0 0 0)
   (rgb8 0 0 170)
   (rgb8 0 170 0)
   (rgb8 0 170 170)
   (rgb8 170 0 0)
   (rgb8 170 0 170)
   (rgb8 170 85 0)
   (rgb8 170 170 170)
   (rgb8 85 85 85)
   (rgb8 85 85 255)
   (rgb8 85 255 85)
   (rgb8 85 255 255)
   (rgb8 255 85 85)
   (rgb8 255 85 255)
   (rgb8 255 255 85)
   (rgb8 255 255 255)))