(in-package #:mfiano.graphics.tools.image)

(defgeneric linearize-channel (trc value))

(defmethod linearize-channel ((trc (eql 'gamma-2.2)) (value single-float))
  (declare (optimize speed)
           ((u:f32 0f0 1f0) value))
  (expt value 2.2f0))

(defmethod linearize-channel ((trc (eql 'srgb)) (value single-float))
  (declare (optimize speed)
           ((u:f32 0f0 1f0) value))
  (if (<= value 0.04045f0)
      (* value #.(/ 12.92f0))
      (expt (* (+ value 0.055f0) #.(/ 1.055f0)) 2.4f0)))

(defmethod delinearize-channel ((trc (eql 'srgb)) (value single-float))
  (declare (optimize speed)
           ((u:f32 0f0) value))
  (if (<= value 0.0031308f0)
      (* value 12.92f0)
      (- (* (expt value #.(/ 2.4f0)) 1.055f0) 0.055f0)))

(defun linearize-trc (color trc)
  (declare (optimize speed))
  (let ((data (data color)))
    (declare (u:f32a data))
    (map-into data (lambda (x) (linearize-channel trc x)) data)))

(defun delinearize-trc (color trc)
  (declare (optimize speed))
  (let ((data (data color)))
    (declare (u:f32a data))
    (map-into data (lambda (x) (delinearize-channel trc x)) data)))
