(in-package #:mfiano.graphics.tools.image)

;;; Base color class which all other sized color classes inherit from.

(defclass color ()
  (
   ;; The position of the alpha channel for this color model, or NIL if there is no alpha channel.
   (%alpha-index
    :type (or (integer 0 3) null)
    :reader alpha-index
    :initarg :alpha-index
    :initform nil)
   ;; Whether or not the primary channels are pre-multiplied with the alpha channel, if one exists.
   (%pre-multiplied-alpha
    :type boolean
    :reader pre-multiplied-alpha-p
    :initarg :pre-multiplied-alpha
    :initform nil)))

;;; Sized colors
;;;
;;; These are meant to be inherited by specific concrete color types, depending on the number of
;;; channels they are composed of.

;; A color with a single channel. This is primarily to be used by gray or alpha only colors.
(defclass color1 (color)
  ((%data
    :type (u:f32a (1))
    :reader data
    :initform (make-array 1 :element-type 'u:f32 :initial-element 0f0))))

;; A color with 2 channels.
(defclass color2 (color)
  ((%data
    :type v2:vec
    :reader data
    :initform (v2:zero))))

;; A color with 3 channels.
(defclass color3 (color)
  ((%data
    :type v3:vec
    :reader data
    :initform (v3:zero))))

;; A color with 4 channels.
(defclass color4 (color)
  ((%data
    :type v4:vec
    :reader data
    :initform (v4:zero))))

;;; Print colors human-readably

(u:define-printer (color stream)
  (format stream "~{~a~^, ~}" (map 'list #'identity (data color))))

;;; Sized color initialization

(defmethod initialize-instance :after ((instance color1) &key (c0 0f0))
  (setf (c0 instance) c0))

(defmethod initialize-instance :after ((instance color2) &key (c0 0f0) (c1 0f0))
  (setf (c0 instance) c0
        (c1 instance) c1))

(defmethod initialize-instance :after ((instance color3) &key (c0 0f0) (c1 0f0) (c2 0f0))
  (setf (c0 instance) c0
        (c1 instance) c1
        (c2 instance) c2))

(defmethod initialize-instance :after ((instance color4) &key (c0 0f0) (c1 0f0) (c2 0f0) (c3 0f0))
  (setf (c0 instance) c0
        (c1 instance) c1
        (c2 instance) c2
        (c3 instance) c3))

;;; Sized color accessors

(defgeneric c0 (color)
  (:method ((color color1))
    (aref (data color) 0))
  (:method ((color color2))
    (v2:x (data color)))
  (:method ((color color3))
    (v3:x (data color)))
  (:method ((color color4))
    (v4:x (data color))))

(defgeneric (setf c0) (value color)
  (:method ((value real) (color color1))
    (setf (aref (data color) 0) (float value 1f0)))
  (:method ((value real) (color color2))
    (setf (v2:x (data color)) (float value 1f0)))
  (:method ((value real) (color color3))
    (setf (v3:x (data color)) (float value 1f0)))
  (:method ((value real) (color color4))
    (setf (v4:x (data color)) (float value 1f0))))

(defgeneric c1 (color)
  (:method ((color color2))
    (v2:y (data color)))
  (:method ((color color3))
    (v3:y (data color)))
  (:method ((color color4))
    (v4:y (data color))))

(defgeneric (setf c1) (value color)
  (:method ((value real) (color color2))
    (setf (v2:y (data color)) (float value 1f0)))
  (:method ((value real) (color color3))
    (setf (v3:y (data color)) (float value 1f0)))
  (:method ((value real) (color color4))
    (setf (v4:y (data color)) (float value 1f0))))

(defgeneric c2 (color)
  (:method ((color color3))
    (v3:z (data color)))
  (:method ((color color4))
    (v4:z (data color))))

(defgeneric (setf c2) (value color)
  (:method ((value real) (color color3))
    (setf (v3:z (data color)) (float value 1f0)))
  (:method ((value real) (color color4))
    (setf (v3:z (data color)) (float value 1f0))))

(defgeneric c3 (color)
  (:method ((color color4))
    (v4:w (data color))))

(defgeneric (setf c3) (value color)
  (:method ((value real) (color color4))
    (setf (v4:w (data color)) (float value 1f0))))

;;; Color protocol

;; TODO: This is redundant. PIXEL-CHANNEL-COUNT retrieves the number of channels of each pixel in an
;; image. I'm not quite sure what to do about this yet.
(defun channel-count (color)
  (length (data color)))

;; NOTE: I don't think we will ever need to convert non-COLOR3's, as I haven't ever seen a non 3x3
;; matrix for converting from one color space to another. If that is the case, this should probably
;; not be a generic function.
(defgeneric transform-color (from to matrix)
  (:method ((from color3) (to color3) matrix)
    (m3:*v3! (data to) matrix (data from))
    to))

;; TODO: The reason this is named generically as CONVERT is because it is likely this will live
;; elsewhere, once we realize methods for converting whole images.
(defgeneric convert (from to))
