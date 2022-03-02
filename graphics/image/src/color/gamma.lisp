(in-package #:%mfiano.graphics.image.color)

(declaim (inline %linearize/gamma))
(defun %linearize/gamma (value gamma)
  (if (minusp value)
      (- (expt (- value) gamma))
      (expt value gamma)))

(declaim (inline %linearize/srgb))
(defun %linearize/srgb (value)
  (if (<= value 0.04045d0)
      (* value #.(/ 12.92d0))
      (expt (* (+ (the (u:f64 0d0) value) 0.055d0) #.(/ 1.055d0)) 2.4d0)))

(declaim (inline %linearize/rec709))
(defun %linearize/rec709 (value)
  (if (< value 0.081d0)
      (* value #.(/ 4.5d0))
      (expt (* (+ value 0.099d0) #.(/ 1.099d0)) #.(/ 0.45d0))))

(declaim (inline %linearize/l*))
(defun %linearize/l* (value)
  (if (<= value 0.08d0)
      (* value #.(/ 100d0 +cie-k+))
      (expt (* (+ value 0.16d0) #.(/ 1.16d0)) 3d0)))

(declaim (inline %delinearize/gamma))
(defun %delinearize/gamma (value gamma)
  (if (minusp value)
      (- (expt (- value) (/ gamma)))
      (expt value (/ gamma))))

(declaim (inline %delinearize/srgb))
(defun %delinearize/srgb (value)
  (if (<= value 0.0031308d0)
      (* value 12.92d0)
      (- (* (expt (the (u:f64 0d0) value) #.(/ 2.4d0)) 1.055d0) 0.055d0)))

(declaim (inline %delinearize/rec709))
(defun %delinearize/rec709 (value)
  (if (< value 0.018d0)
      (* value 4.5d0)
      (- (* (expt value 0.45d0) 1.099d0) 0.099d0)))

(declaim (inline %delinearize/l*))
(defun %delinearize/l* (value)
  (if (<= value +cie-e+)
      (* value #.(/ +cie-k+ 100d0))
      (- (* 1.16d0 (expt (the (u:f64 0d0) value) #.(/ 3d0))) 0.16d0)))

(defun linearize-rgb (color)
  (declare (optimize speed))
  (let ((channels (channels color))
        (gamma (gamma color)))
    (declare (u:f64a channels))
    (flet ((%linearize (value)
             (etypecase gamma
               (u:f64 (%linearize/gamma value gamma))
               (symbol
                (ecase gamma
                  (srgb (%linearize/srgb value))
                  (rec.709 (%linearize/rec709 value))
                  (l* (%linearize/l* value)))))))
      (declare (inline %linearize))
      (map-into channels #'%linearize channels)
      color)))

(defun delinearize-rgb (color)
  (declare (optimize speed))
  (let ((channels (channels color))
        (gamma (gamma color)))
    (declare (u:f64a channels))
    (flet ((%delinearize (value)
             (etypecase gamma
               (u:f64 (%delinearize/gamma value gamma))
               (symbol
                (ecase gamma
                  (srgb (%delinearize/srgb value))
                  (rec.709 (%delinearize/rec709 value))
                  (l* (%delinearize/l* value)))))))
      (declare (inline %delinearize))
      (map-into channels #'%delinearize channels)
      color)))
