(in-package #:mfiano.graphics.tools.image.color)

;;; Mixin classes

(defclass uniform-transfer () ())

;;; Protocol

(defgeneric linearize (color))

(defgeneric delinearize (color))

(defgeneric linearize-channel (value gamma))

(defgeneric delinearize-channel (value gamma))

;;; Implementation

(defmethod linearize ((color uniform-transfer))
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f64a data))
    (map-into data (lambda (x) (linearize-channel x gamma)) data)
    color))

(defmethod delinearize ((color uniform-transfer))
  (let ((data (data color))
        (gamma (gamma color)))
    (declare (u:f64a data))
    (map-into data (lambda (x) (delinearize-channel x gamma)) data)
    color))

;; TODO: Stubs for LUV transfer functions
;;(defmethod linearize ((color luv)))
;;(defmethod delinearize ((color luv)))

;;; Uniform channel transfer function helpers

(defmethod linearize-channel (value (gamma double-float))
  (expt value gamma))

(defmethod delinearize-channel (value (gamma double-float))
  (expt value (/ gamma)))

(defmethod linearize-channel (value (gamma (eql 'L*)))
  (if (<= value 0.08)
      (* 100d0 value #.(/ (float 24389/27 1d0)))
      (expt (* (+ value 0.16d0) (/ 1.16d0)) 3d0)))

(defmethod delinearize-channel (value (gamma (eql 'L*)))
  (if (<= value #.(float 216/24389 1d0))
      (* (* value #.(float 24389/27 1d0) 100d0))
      (- (* 1.16d0 (expt value #.(float (/ 3) 1d0))) 0.16d0)))

(defmethod linearize-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.04045)
      (* value #.(/ 12.92d0))
      (expt (* (+ value 0.055d0) #.(/ 1.055d0)) 2.4d0)))

(defmethod delinearize-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.0031308)
      (* value 12.92d0)
      (- (* (expt value #.(/ 2.4d0)) 1.055d0) 0.055d0)))

(defmethod linearize-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.081)
      (* value #.(/ 4.5d0))
      (expt (* (+ value 0.099d0) #.(/ 1.099d0)) (/ 0.45d0))))

(defmethod delinearize-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.018)
      (* value 4.5d0)
      (- (* (expt value 0.45d0) 1.099d0) 0.099d0)))
