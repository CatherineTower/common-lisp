(in-package #:%mfiano.graphics.tools.image)

(defclass image ()
  ((%width
    :type u:ub16
    :reader width
    :initarg :width)
   (%height
    :type u:ub16
    :reader height
    :initarg :height)
   (%data
    :type (u:f32a (* * *))
    :reader data
    :initarg :data)))

(u:define-printer (image stream :type nil :identity t)
  (format stream "~a ~dx~d"
          (class-name (class-of image))
          (width image)
          (height image)))

(defmethod initialize-instance :after ((instance image) &key context width height)
  (let* ((channel-count (pixel-channel-count instance))
         (data (make-array (list width height channel-count)
                           :element-type 'u:f32
                           :initial-element 0f0)))
    (reinitialize-instance instance :data data)
    (fill-color instance (v4:vec 0 0 0 1) :context (or context base:*context*))))

(defun make-image (width height &key (color-type 'rgba) (context base:*context*))
  (make-instance (color-type->image-type color-type)
                 :context context
                 :width width
                 :height height))
