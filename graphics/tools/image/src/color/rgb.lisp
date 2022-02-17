(in-package #:%mfiano.graphics.tools.image.color)

;;; Linearize/delinearize RGB space.

(defun linearize-rgb (color)
  (let ((data (data color))
        (gamma (gamma color)))
    (map-into data (lambda (x) (linearize-rgb-channel x gamma)) data)
    color))

(defun delinearize-rgb (color)
  (let ((data (data color))
        (gamma (gamma color)))
    (map-into data (lambda (x) (delinearize-rgb-channel x gamma)) data)
    color))

(defmethod linearize-rgb-channel (value (gamma double-float))
  (expt value gamma))

(defmethod delinearize-rgb-channel (value (gamma double-float))
  (expt value (/ gamma)))

(defmethod linearize-rgb-channel (value (gamma (eql 'L*)))
  (if (<= value 0.08)
      (* 100d0 value #.(/ (float 24389/27 1d0)))
      (expt (* (+ value 0.16d0) (/ 1.16d0)) 3d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'L*)))
  (if (<= value #.(float 216/24389 1d0))
      (* (* value #.(float 24389/27 1d0) 100d0))
      (- (* 1.16d0 (expt value #.(float (/ 3) 1d0))) 0.16d0)))

(defmethod linearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.04045)
      (* value #.(/ 12.92d0))
      (expt (* (+ value 0.055d0) #.(/ 1.055d0)) 2.4d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.0031308)
      (* value 12.92d0)
      (- (* (expt value #.(/ 2.4d0)) 1.055d0) 0.055d0)))

(defmethod linearize-rgb-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.081)
      (* value #.(/ 4.5d0))
      (expt (* (+ value 0.099d0) #.(/ 1.099d0)) (/ 0.45d0))))

(defmethod delinearize-rgb-channel (value (gamma (eql 'rec.709)))
  (if (< value 0.018)
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

(declaim (inline transform-rgb-xyz))
(defun transform-rgb-xyz (from to illuminant-name)
  (declare (optimize speed))
  (let ((transform (get-rgb-transform from to illuminant-name)))
    (m3:*v3! (data to) transform (data from))
    (setf (%illuminant-name to) illuminant-name)
    to))

(declaim (inline rgb->xyz))
(defun rgb->xyz (rgb xyz)
  (declare (optimize speed))
  (with-pool-color (temp-rgb (space-name rgb) :copy rgb)
    (linearize-rgb temp-rgb)
    (transform-rgb-xyz temp-rgb xyz (illuminant-name rgb))))

(declaim (inline xyz->rgb))
(defun xyz->rgb (xyz rgb)
  (declare (optimize speed))
  (with-pool-color (temp-rgb (space-name rgb) :copy rgb)
    (transform-rgb-xyz xyz temp-rgb (illuminant-name rgb))
    (delinearize-rgb temp-rgb)))

(defmacro generate-xyz->rgb-converters ()
  )
