(in-package #:%mfiano.graphics.tools.image.color)

(defclass storage ()
  ((%channels
    :type u:f64a
    :reader channels
    :initarg :channels
    :initform (v3:zero))
   (%channel-names
    :type list
    :reader channel-names
    :initarg :channel-names)))

;;; Sized color initialization

(defmethod initialize-instance :after ((instance storage)
                                       &key
                                         (channel0 0d0)
                                         (channel1 0d0 channel1-p)
                                         (channel2 0d0 channel2-p)
                                         (channel3 0d0 channel3-p))
  (let ((channels (channels instance)))
    (setf (aref channels 0) (float channel0 1d0))
    (when channel1-p
      (setf (aref channels 1) (float channel1 1d0)))
    (when channel2-p
      (setf (aref channels 2) (float channel2 1d0)))
    (when channel3-p
      (setf (aref channels 3) (float channel3 1d0)))))

(declaim (inline zero-channels))
(defun zero-channels (storage)
  (let ((channels (channels storage)))
    (declare ((u:f64a (*)) channels))
    (fill channels 0d0)))

(declaim (inline copy-channels))
(defun copy-channels (from to)
  (let ((from-channels (channels from))
        (to-channels (channels to)))
    (declare ((u:f64a (*)) to-channels from-channels))
    (replace to-channels from-channels)))

(defun decompose-channels (storage)
  (let ((channels (channels storage)))
    (etypecase channels
      ((u:f64a (1))
       (aref channels 0))
      (v2:vec
       (values (v2:x channels) (v2:y channels)))
      (v3:vec
       (values (v3:x channels) (v3:y channels) (v3:z channels)))
      (v4:vec
       (values (v4:x channels) (v4:y channels) (v4:z channels) (v4:w channels))))))
