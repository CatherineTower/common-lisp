(in-package #:mfiano.graphics.tools.color)

(defmethod make-palette ((name (eql 'apple-ii-hgr)))
  (list
   (rgb 0 0 0)
   (rgb 255 0 255)
   (rgb 0 255 0)
   (rgb 255 255 255)
   (rgb 0 175 255)
   (rgb 255 80 0)))
