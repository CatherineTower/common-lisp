(in-package #:%mfiano.graphics.image.color)

(declaim (inline %linearize-rgb-channel))
(defun %linearize-rgb-channel (value gamma)
  (etypecase gamma
    (u:f64
     (if (minusp value)
         (- (expt (- value) gamma))
         (expt value gamma)))
    (symbol
     (ecase gamma
       (srgb
        (if (<= value 0.04045d0)
            (* value #.(/ 12.92d0))
            (expt (* (+ (the (u:f64 0d0) value) 0.055d0) #.(/ 1.055d0)) 2.4d0)))
       (rec.709
        (if (< value 0.081d0)
            (* value #.(/ 4.5d0))
            (expt (* (+ value 0.099d0) #.(/ 1.099d0)) #.(/ 0.45d0))))
       (L*
        (if (<= value 0.08d0)
            (* value #.(/ 100d0 +cie-k+))
            (expt (* (+ value 0.16d0) #.(/ 1.16d0)) 3d0)))))))

(declaim (inline %delinearize-rgb-channel))
(defun %delinearize-rgb-channel (value gamma)
  (etypecase gamma
    (u:f64
     (if (minusp value)
         (- (expt (- value) (/ gamma)))
         (expt value (/ gamma))))
    (symbol
     (ecase gamma
       (srgb
        (if (<= value 0.0031308d0)
            (* value 12.92d0)
            (- (* (expt (the (u:f64 0d0) value) #.(/ 2.4d0)) 1.055d0) 0.055d0)))
       (rec.709
        (if (< value 0.018d0)
            (* value 4.5d0)
            (- (* (expt value 0.45d0) 1.099d0) 0.099d0)))
       (L*
        (if (<= value +cie-e+)
            (* value (/ +cie-k+ 100d0))
            (- (* 1.16d0 (expt (the (u:f64 0d0) value) #.(/ 3d0))) 0.16d0)))))))

(defun linearize-rgb (color)
  (declare (optimize speed))
  (let ((channels (channels color))
        (gamma (gamma color)))
    (declare (u:f64a channels))
    (map-into channels (lambda (x) (%linearize-rgb-channel x gamma)) channels)
    color))

(defun delinearize-rgb (color)
  (declare (optimize speed))
  (let ((channels (channels color))
        (gamma (gamma color)))
    (declare (u:f64a channels))
    (map-into channels (lambda (x) (%delinearize-rgb-channel x gamma)) channels)
    color))
