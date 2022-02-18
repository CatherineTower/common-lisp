(in-package #:%mfiano.graphics.image)

;;;; TODO: This file needs some work to integrate additional color models and somehow map them to a
;;;; color space. Additionally, PIXEL-CHANNEL-COUNT is redundant, and should be query-able from the
;;;; image's color model. Also, ALPHA-CHANNEL-INDEX should be a method on the image's color model,
;;;; too.

;;; RGBA

(defclass rgba-image (image) ())

(defmethod color-type->image-type ((color-type (eql 'rgba)))
  'rgba-image)

(defmethod pixel-channel-count ((image rgba-image))
  4)

(defmethod alpha-channel-index ((image rgba-image))
  3)

;;; XYZ

(defclass xyz-image (image) ())

(defmethod color-type->image-type ((color-type (eql 'xyz)))
  'xyz-image)

(defmethod pixel-channel-count ((image xyz-image))
  3)
