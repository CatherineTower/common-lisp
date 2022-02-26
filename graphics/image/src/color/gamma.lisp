(in-package #:%mfiano.graphics.image.color)

(defun linearize-rgb (color)
  (let ((channels (channels color))
        (gamma (gamma color)))
    (map-into channels (lambda (x) (linearize-rgb-channel x gamma)) channels)
    color))

(defun delinearize-rgb (color)
  (let ((channels (channels color))
        (gamma (gamma color)))
    (map-into channels (lambda (x) (delinearize-rgb-channel x gamma)) channels)
    color))

(defgeneric linearize-rgb-channel (value gamma))

(defgeneric delinearize-rgb-channel (value gamma))

(defmethod linearize-rgb-channel (value (gamma double-float))
  (if (minusp value)
      (- (expt (- value) gamma))
      (expt value gamma)))

(defmethod delinearize-rgb-channel (value (gamma double-float))
  (if (minusp value)
      (- (expt (- value) (/ gamma)))
      (expt value (/ gamma))))

(defmethod linearize-rgb-channel (value (gamma (eql 'L*)))
  (if (<= value 0.08d0)
      (/ (* value 100d0) +cie-k+)
      (expt (/ (+ value 0.16d0) 1.16d0) 3d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'L*)))
  (if (<= value +cie-e+)
      (/ (* value +cie-k+) 100d0)
      (- (* 1.16d0 (expt value (/ 3))) 0.16d0)))

(defmethod linearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.04045d0)
      (/ value 12.92d0)
      (expt (/ (+ value 0.055d0) 1.055d0) 2.4d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.0031308d0)
      (* value 12.92d0)
      (- (* (expt value (/ 2.4d0)) 1.055d0) 0.055d0)))

(defmethod linearize-rgb-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.081d0)
      (/ value 4.5d0)
      (expt (/ (+ value 0.099d0) 1.099d0) (/ 0.45d0))))

(defmethod delinearize-rgb-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.018d0)
      (* value 4.5d0)
      (- (* (expt value 0.45d0) 1.099d0) 0.099d0)))
