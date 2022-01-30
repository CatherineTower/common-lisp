(in-package #:mfiano.graphics.tools.image)

;;; TODO: This file needs serious thought.

;;; While sRGB is a color space, the color model it belongs to is RGB. The RGB model may have an
;;; alpha channel, with the model specified as RGBA. Additionally, the ordering of channels is not
;;; necessarily RGB(A) for the RGB model. Common arrangements we would like to support include:

;;; - RGB
;;; - BGR
;;; - RGBA
;;; - BGRA
;;; - ARGB
;;; - ABGR

;;; So, in addition to color space conversions, we should also have a way to both specify the model,
;;; and convert between model orderings of the same model.
