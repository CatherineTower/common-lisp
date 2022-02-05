(in-package #:mfiano.graphics.tools.image)

;;; Linearize / De-linearize tonal response curves

(defun linearize-rgb (color)
  (declare (optimize speed))
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f32a data))
    (map-into data (lambda (x) (linearize-channel gamma x)) data)
    color))

(defun delinearize-rgb (color)
  (declare (optimize speed))
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f32a data))
    (map-into data (lambda (x) (delinearize-channel gamma x)) data)
    color))

;;; Linearize / De-linearize the TRC of an individual color channel.

(defgeneric linearize-channel (gamma value)
  (:method ((gamma single-float) value)
    (declare (optimize speed)
             ((u:f32 0f0 1f0) value))
    (expt value gamma)))

(defgeneric delinearize-channel (gamma value)
  (:method ((gamma single-float) value)
    (declare (optimize speed)
             ((u:f32 0f0) value))
    (expt value (/ gamma))))

(defmethod linearize-channel ((gamma (eql 'L*)) value)
  (declare (optimize speed)
           ((u:f32 0f0 1f0) value))
  (if (<= value 0.08f0)
      (* 100f0 value #.(/ (float 24389/27 1f0)))
      (expt (* (+ value 0.16f0) (/ 1.16f0)) 3f0)))

(defmethod delinearize-channel ((gamma (eql 'L*)) value)
  (declare (optimize speed)
           ((u:f32 0f0) value))
  (if (<= value #.(float 216/24389 1f0))
      (* (* value #.(float 24389/27 1f0) 100f0))
      (- (* 1.16f0 (expt value #.(float (/ 3) 1f0))) 0.16f0)))

(defmethod linearize-channel ((gamma (eql 'srgb)) value)
  (declare (optimize speed)
           ((u:f32 0f0 1f0) value))
  (if (<= value 0.04045f0)
      (* value #.(/ 12.92f0))
      (expt (* (+ value 0.055f0) #.(/ 1.055f0)) 2.4f0)))

(defmethod delinearize-channel ((gamma (eql 'srgb)) value)
  (declare (optimize speed)
           ((u:f32 0f0) value))
  (if (<= value 0.0031308f0)
      (* value 12.92f0)
      (- (* (expt value #.(/ 2.4f0)) 1.055f0) 0.055f0)))
