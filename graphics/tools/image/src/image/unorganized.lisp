(in-package #:mfiano.graphics.tools.image)

;;; TODO: The functions in this file have not been organized into the project architecture yet.

(declaim (inline %image-channel))
(defun %image-channel (data x y index)
  (aref data x y index))

(declaim (inline (setf %image-channel)))
(defun (setf %image-channel) (value data x y index)
  (setf (aref data x y index) value))

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

;; TODO: The iteration should be abstracted to a macro, to allow us to perform more than solid color
;; fills across a while image (or sub-image).
(defun fill-color (image color &key (context *context*))
  (declare (optimize speed))
  (let* ((data (data image))
         (width (width image))
         (height (height image))
         (color-data (data color))
         (color-length (length color-data)))
    (declare ((u:f32a (* * *)) data)
             (u:ub16 width height)
             ((u:f32a (*)) color-data))
    (with-context (context)
      (time
       (lp:pdotimes (x width)
         (dotimes (y height)
           (dotimes (i color-length)
             (setf (%image-channel data x y i) (aref color-data i)))))))))
