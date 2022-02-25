(in-package #:%mfiano.graphics.image.color)

;;; Linearize/delinearize RGB.

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

;;; RGB to/from XYZ transformation.

(defun get-rgb-transform (from to illuminant-name)
  (let* ((transforms (base:rgb-transforms base:*context*))
         (from-space (space-name from))
         (to-space (space-name to))
         (key (list from-space to-space illuminant-name)))
    (declare (dynamic-extent key))
    (labels ((make-vector (x y)
               (let ((x (/ x y))
                     (z (/ (- 1 x y) y)))
                 (declare (u:f64 x z))
                 (v3:vec x 1 z)))
             (calculate-rgb-transform (rgb-space)
               (destructuring-bind ((rx ry) (gx gy) (bx by)) (coords rgb-space)
                 (declare (u:f64 rx ry gx gy bx by))
                 (let* ((r (make-vector rx ry))
                        (g (make-vector gx gy))
                        (b (make-vector bx by))
                        (scale (m3:*v3 (m3:invert (m3:mat r g b))
                                       (get-white-point illuminant-name))))
                   (m3:mat (v3:scale r (v3:x scale))
                           (v3:scale g (v3:y scale))
                           (v3:scale b (v3:z scale))))))
             (calculate-transform ()
               (etypecase from
                 (rgb (calculate-rgb-transform from))
                 (xyz (m3:invert (calculate-rgb-transform to))))))
      (declare (inline make-vector calculate-transform))
      (u:if-found (transform (u:href transforms key))
        transform
        (setf (u:href transforms (copy-list key)) (calculate-transform))))))
