(in-package #:mfiano.graphics.tools.image.color)

;;; Base color storage class which all other sized color classes inherit from. Sub-classes of
;;; COLOR-STORAGE classes are mixins that provide storage for color data. They have no knowledge of
;;; which channels are stored where or in what encoding (color space) they are stored in.

(defclass color-storage () ())

;; Provides storage for a color with 1 channel.
(defclass color-storage1 (color-storage)
  ((%data
    :type (u:f64a (1))
    :reader data
    :initform (make-array 1 :element-type 'u:f64 :initial-element 0d0))))

;; Provides storage for a color with 2 channels.
(defclass color-storage2 (color-storage)
  ((%data
    :type v2:vec
    :reader data
    :initform (v2:zero))))

;; Provides storage for a color with 3 channels.
(defclass color-storage3 (color-storage)
  ((%data
    :type v3:vec
    :reader data
    :initform (v3:zero))))

;; Provides storage for a color with 4 channels.
(defclass color-storage4 (color-storage)
  ((%data
    :type v4:vec
    :reader data
    :initform (v4:zero))))

;;; Sized color initialization

(defmethod update-instance-for-different-class :after (previous (current color-storage1)
                                                       &key (c0 0d0))
  (unless (b::has-mixin-p previous 'color-storage1)
    (setf (c0 current) (float c0 1d0))))

(defmethod update-instance-for-different-class :after (previous (current color-storage2)
                                                       &key (c0 0d0) (c1 0d0))
  (unless (b::has-mixin-p previous 'color-storage2)
    (setf (c0 current) (float c0 1d0)
          (c1 current) (float c1 1d0))))

(defmethod update-instance-for-different-class :after (previous (current color-storage3)
                                                       &key (c0 0d0) (c1 0d0) (c2 0d0))
  (unless (b::has-mixin-p previous 'color-storage3)
    (setf (c0 current) (float c0 1d0)
          (c1 current) (float c1 1d0)
          (c2 current) (float c2 1d0))))

(defmethod update-instance-for-different-class :after (previous (current color-storage4)
                                                       &key (c0 0d0) (c1 0d0) (c2 0d0) (c3 0d0))
  (unless (b::has-mixin-p previous 'color-storage4)
    (setf (c0 current) (float c0 1d0)
          (c1 current) (float c1 1d0)
          (c2 current) (float c2 1d0)
          (c3 current) (float c3 1d0))))

;;; Sized color accessors

(defgeneric c0 (storage)
  (:method ((storage color-storage1))
    (aref (data storage) 0))
  (:method ((storage color-storage2))
    (v2:x (data storage)))
  (:method ((storage color-storage3))
    (v3:x (data storage)))
  (:method ((storage color-storage4))
    (v4:x (data storage))))

(defgeneric (setf c0) (value storage)
  (:method ((value real) (storage color-storage1))
    (setf (aref (data storage) 0) (float value 1d0)))
  (:method ((value real) (storage color-storage2))
    (setf (v2:x (data storage)) (float value 1d0)))
  (:method ((value real) (storage color-storage3))
    (setf (v3:x (data storage)) (float value 1d0)))
  (:method ((value real) (storage color-storage4))
    (setf (v4:x (data storage)) (float value 1d0))))

(defgeneric c1 (storage)
  (:method ((storage color-storage2))
    (v2:y (data storage)))
  (:method ((storage color-storage3))
    (v3:y (data storage)))
  (:method ((storage color-storage4))
    (v4:y (data storage))))

(defgeneric (setf c1) (value storage)
  (:method ((value real) (storage color-storage2))
    (setf (v2:y (data storage)) (float value 1d0)))
  (:method ((value real) (storage color-storage3))
    (setf (v3:y (data storage)) (float value 1d0)))
  (:method ((value real) (storage color-storage4))
    (setf (v4:y (data storage)) (float value 1d0))))

(defgeneric c2 (storage)
  (:method ((storage color-storage3))
    (v3:z (data storage)))
  (:method ((storage color-storage4))
    (v4:z (data storage))))

(defgeneric (setf c2) (value storage)
  (:method ((value real) (storage color-storage3))
    (setf (v3:z (data storage)) (float value 1d0)))
  (:method ((value real) (storage color-storage4))
    (setf (v4:z (data storage)) (float value 1d0))))

(defgeneric c3 (storage)
  (:method ((storage color-storage4))
    (v4:w (data storage))))

(defgeneric (setf c3) (value storage)
  (:method ((value real) (storage color-storage4))
    (setf (v4:w (data storage)) (float value 1d0))))

;;; Color protocol

;; TODO: This is redundant. PIXEL-CHANNEL-COUNT retrieves the number of channels of each pixel in an
;; image. I'm not quite sure what to do about this yet.
(defgeneric channel-count (storage)
  (:method ((storage color-storage))
    (length (data storage))))
