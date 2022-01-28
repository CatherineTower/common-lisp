(in-package #:mfiano.graphics.tools.image)

;;; image type

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

;;; image implementation

(defmethod initialize-instance :after ((instance image) &key context width height)
  (let* ((channel-count (pixel-channel-count instance))
         (data (make-array (list width height channel-count)
                           :element-type 'u:f32
                           :initial-element 0f0)))
    (reinitialize-instance instance :data data)
    (fill-color instance (m:vec 0 0 0 1) :context (or context *context*))))

(defun make-image (width height &key (color-type 'rgba) (context *context*))
  (make-instance (color-type->image-type color-type)
                 :context context
                 :width width
                 :height height))

(declaim (inline %channel))
(defun %channel (data x y index)
  (aref data x y index))

(declaim (inline (setf %channel)))
(defun (setf %channel) (value data x y index)
  (setf (aref data x y index) value))

;;; color protocol

(defgeneric color-type->image-type (color-type)
  (:method (color-type))
  (:method :around (color-type)
    (let ((image-type (call-next-method)))
      (if (subtypep image-type 'image)
          image-type
          (error "The image type ~s for color type ~s is not a class that is a subtype of ~s."
                 image-type
                 color-type
                 'image)))))

(defgeneric pixel-channel-count (image))

(defgeneric alpha-channel-index (image)
  (:method ((image image))
    nil))

(defun fill-color (image color &key (context *context*))
  (declare (optimize speed))
  (let* ((data (data image))
         (width (width image))
         (height (height image))
         (color-array (m:to-array! color :single-float))
         (color-length (length color-array)))
    (declare ((u:f32a (* * *)) data)
             (u:ub16 width height)
             ((u:f32a (*)) color-array))
    (with-context (context)
      (time
       (lp:pdotimes (x width)
         (dotimes (y height)
           (dotimes (i color-length)
             (setf (%channel data x y i) (aref color-array i)))))))))
