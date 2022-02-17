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

(defmethod update-instance-for-different-class :after (previous (current storage1)
                                                       &key (channel0 0d0))
  (unless (base:has-mixin-p previous 'storage1)
    (setf (channel0 current) (float channel0 1d0))))

(defmethod update-instance-for-different-class :after (previous (current storage2)
                                                       &key
                                                         (channel0 0d0)
                                                         (channel1 0d0))
  (unless (base:has-mixin-p previous 'storage2)
    (setf (channel0 current) (float channel0 1d0)
          (channel1 current) (float channel1 1d0))))

(defmethod update-instance-for-different-class :after (previous (current storage3)
                                                       &key
                                                         (channel0 0d0)
                                                         (channel1 0d0)
                                                         (channel2 0d0))
  (unless (base:has-mixin-p previous 'storage3)
    (setf (channel0 current) (float channel0 1d0)
          (channel1 current) (float channel1 1d0)
          (channel2 current) (float channel2 1d0))))

(defmethod update-instance-for-different-class :after (previous (current storage4)
                                                       &key
                                                         (channel0 0d0)
                                                         (channel1 0d0)
                                                         (channel2 0d0)
                                                         (channel3 0d0))
  (unless (base:has-mixin-p previous 'storage4)
    (setf (channel0 current) (float channel0 1d0)
          (channel1 current) (float channel1 1d0)
          (channel2 current) (float channel2 1d0)
          (channel3 current) (float channel3 1d0))))

;;; Sized color accessors

(defmethod channel0 ((storage storage1))
  (aref (data storage) 0))

(defmethod channel0 ((storage storage2))
  (v2:x (data storage)))

(defmethod channel0 ((storage storage3))
  (v3:x (data storage)))

(defmethod channel0 ((storage storage4))
  (v4:x (data storage)))

(defmethod (setf channel0) ((value real) (storage storage1))
  (setf (aref (data storage) 0) (float value 1d0)))

(defmethod (setf channel0) ((value real) (storage storage2))
  (setf (v2:x (data storage)) (float value 1d0)))

(defmethod (setf channel0) ((value real) (storage storage3))
  (setf (v3:x (data storage)) (float value 1d0)))

(defmethod (setf channel0) ((value real) (storage storage4))
  (setf (v4:x (data storage)) (float value 1d0)))

(defmethod channel1 ((storage storage2))
  (v2:y (data storage)))

(defmethod channel1 ((storage storage3))
  (v3:y (data storage)))

(defmethod channel1 ((storage storage4))
  (v4:y (data storage)))

(defmethod (setf channel1) ((value real) (storage storage2))
  (setf (v2:y (data storage)) (float value 1d0)))

(defmethod (setf channel1) ((value real) (storage storage3))
  (setf (v3:y (data storage)) (float value 1d0)))

(defmethod (setf channel1) ((value real) (storage storage4))
  (setf (v4:y (data storage)) (float value 1d0)))

(defmethod channel2 ((storage storage3))
  (v3:z (data storage)))

(defmethod channel2 ((storage storage4))
  (v4:z (data storage)))

(defmethod (setf channel2) ((value real) (storage storage3))
  (setf (v3:z (data storage)) (float value 1d0)))

(defmethod (setf channel2) ((value real) (storage storage4))
  (setf (v4:z (data storage)) (float value 1d0)))

(defmethod channel3 ((storage storage4))
  (v4:w (data storage)))

(defmethod (setf channel3) ((value real) (storage storage4))
  (setf (v4:w (data storage)) (float value 1d0)))

(defmethod zero-storage ((storage storage2))
  (v2:zero! (data storage)))

(defmethod zero-storage ((storage storage3))
  (v3:zero! (data storage)))

(defmethod zero-storage ((storage storage4))
  (v4:zero! (data storage)))

(defmethod copy-storage ((from storage2) (to storage2))
  (v2:copy! (data to) (data from)))

(defmethod copy-storage ((from storage3) (to storage3))
  (v3:copy! (data to) (data from)))

(defmethod copy-storage ((from storage4) (to storage4))
  (v4:copy! (data to) (data from)))

(defmethod extract-values ((storage storage2))
  (v2:with-components ((v (data storage)))
    (values (float vx 1f0) (float vy 1f0))))

(defmethod extract-values ((storage storage3))
  (v3:with-components ((v (data storage)))
    (values (float vx 1f0) (float vy 1f0) (float vz 1f0))))

(defmethod extract-values ((storage storage4))
  (v4:with-components ((v (data storage)))
    (values (float vx 1f0) (float vy 1f0) (float vz 1f0) (float vw 1f0))))
