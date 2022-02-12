(in-package #:mfiano.graphics.tools.image.color)

;;; Linearize / De-linearize tonal response curves

(defun linearize-rgb (color)
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f64a data))
    (map-into data (lambda (x) (linearize-channel gamma x)) data)
    color))

(defun delinearize-rgb (color)
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f64a data))
    (map-into data (lambda (x) (delinearize-channel gamma x)) data)
    color))

;;; Linearize / Delinearize the TRC of an individual color channel.

(defgeneric linearize-channel (gamma value)
  (:method ((gamma double-float) value)
    (expt value gamma)))

(defgeneric delinearize-channel (gamma value)
  (:method ((gamma double-float) value)
    (expt value (/ gamma))))

(defmethod linearize-channel ((gamma (eql 'L*)) value)
  (if (<= value 0.08)
      (* 100d0 value #.(/ (float 24389/27 1d0)))
      (expt (* (+ value 0.16d0) (/ 1.16d0)) 3d0)))

(defmethod delinearize-channel ((gamma (eql 'L*)) value)
  (if (<= value #.(float 216/24389 1d0))
      (* (* value #.(float 24389/27 1d0) 100d0))
      (- (* 1.16d0 (expt value #.(float (/ 3) 1d0))) 0.16d0)))

(defmethod linearize-channel ((gamma (eql 'srgb)) value)
  (if (<= value 0.04045)
      (* value #.(/ 12.92d0))
      (expt (* (+ value 0.055d0) #.(/ 1.055d0)) 2.4d0)))

(defmethod delinearize-channel ((gamma (eql 'srgb)) value)
  (if (<= value 0.0031308)
      (* value 12.92d0)
      (- (* (expt value #.(/ 2.4d0)) 1.055d0) 0.055d0)))

(defmethod linearize-channel ((gamma (eql 'rec.709)) value)
  (if (< value 0.081)
      (* value #.(/ 4.5d0))
      (expt (* (+ value 0.099d0) #.(/ 1.099d0)) (/ 0.45d0))))

(defmethod delinearize-channel ((gamma (eql 'rec.709)) value)
  (if (< value 0.018)
      (* value 4.5d0)
      (- (* (expt value 0.45d0) 1.099d0) 0.099d0)))
