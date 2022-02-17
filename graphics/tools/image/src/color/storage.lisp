(in-package #:%mfiano.graphics.tools.image.color)

(defclass storage () ())

;; Provides storage for a color with 1 channel.
(defclass storage1 (storage)
  ((%data
    :type (u:f64a (1))
    :reader data
    :initform (make-array 1 :element-type 'u:f64 :initial-element 0d0))))

;; Provides storage for a color with 2 channels.
(defclass storage2 (storage)
  ((%data
    :type v2:vec
    :reader data
    :initform (v2:zero))))

;; Provides storage for a color with 3 channels.
(defclass storage3 (storage)
  ((%data
    :type v3:vec
    :reader data
    :initform (v3:zero))))

;; Provides storage for a color with 4 channels.
(defclass storage4 (storage)
  ((%data
    :type v4:vec
    :reader data
    :initform (v4:zero))))

;;; Sized color initialization

(defmethod initialize-instance :after ((instance storage1) &key (channel0 0d0))
  (setf (aref (data instance) 0) (float channel0 1d0)))

(defmethod initialize-instance :after ((instance storage2) &key (channel0 0d0) (channel1 0d0))
  (let ((data (data instance)))
    (setf (aref data 0) (float channel0 1d0)
          (aref data 1) (float channel1 1d0))))

(defmethod initialize-instance :after ((instance storage3)
                                       &key
                                         (channel0 0d0)
                                         (channel1 0d0)
                                         (channel2 0d0))
  (let ((data (data instance)))
    (setf (aref data 0) (float channel0 1d0)
          (aref data 1) (float channel1 1d0)
          (aref data 2) (float channel2 1d0))))

(defmethod initialize-instance :after ((instance storage4)
                                       &key
                                         (channel0 0d0)
                                         (channel1 0d0)
                                         (channel2 0d0)
                                         (channel3 0d0))
  (let ((data (data instance)))
    (setf (aref data 0) (float channel0 1d0)
          (aref data 1) (float channel1 1d0)
          (aref data 2) (float channel2 1d0)
          (aref data 2) (float channel3 1d0))))

(defgeneric zero-channels (storage)
  (:method ((storage storage2))
    (v2:zero! (data storage)))
  (:method ((storage storage3))
    (v3:zero! (data storage)))
  (:method ((storage storage4))
    (v4:zero! (data storage))))

(defgeneric copy-channels (from to)
  (:method ((from storage2) (to storage2))
    (v2:copy! (data to) (data from)))
  (:method ((from storage3) (to storage3))
    (v3:copy! (data to) (data from)))
  (:method ((from storage4) (to storage4))
    (v4:copy! (data to) (data from))))

(defgeneric decompose-channels (storage)
  (:method ((storage storage2))
    (v2:with-components ((v (data storage)))
      (values (float vx 1f0) (float vy 1f0))))
  (:method ((storage storage3))
    (v3:with-components ((v (data storage)))
      (values (float vx 1f0) (float vy 1f0) (float vz 1f0))))
  (:method ((storage storage4))
    (v4:with-components ((v (data storage)))
      (values (float vx 1f0) (float vy 1f0) (float vz 1f0) (float vw 1f0)))))
