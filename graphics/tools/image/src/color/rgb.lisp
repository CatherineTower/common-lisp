(in-package #:mfiano.graphics.tools.image.color)

;;; Linearize/delinearize transfer functions.

(defun linearize-rgb (color)
  (let ((data (m:to-array! (data color) :double-float))
        (gamma (gamma color)))
    (map-into data (lambda (x) (linearize-rgb-channel x gamma)) data)
    color))

(defun delinearize-rgb (color)
  (let ((data (m:to-array! (data color) :double-float))
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
    (labels ((calculate-rgb-transform (rgb-space)
               (destructuring-bind ((rx ry) (gx gy) (bx by)) (coords rgb-space)
                 (declare (u:f64 rx ry gx gy bx by))
                 (let* ((r (m:vec (/ rx ry) 1 (/ (- 1 rx ry) ry)))
                        (g (m:vec (/ gx gy) 1 (/ (- 1 gx gy) gy)))
                        (b (m:vec (/ bx by) 1 (/ (- 1 bx by) by)))
                        (scale (m:* (m:invert (m:mat/from-vecs r g b))
                                    (get-white-point illuminant-name))))
                   (m:mat/from-vecs (m:* r (m:x scale))
                                    (m:* g (m:y scale))
                                    (m:* b (m:z scale))))))
             (calculate-transform ()
               (etypecase from
                 (rgb (calculate-rgb-transform from))
                 (xyz (m:invert (calculate-rgb-transform to))))))
      (declare (inline calculate-transform))
      (u:if-found (transform (u:href transforms key))
        transform
        (setf (u:href transforms (copy-list key)) (calculate-transform))))))

(declaim (inline transform-rgb-xyz))
(defun transform-rgb-xyz (from to illuminant-name)
  (declare (optimize speed))
  (let ((transform (get-rgb-transform from to illuminant-name)))
    (m:*! transform (data from) (data to))
    (setf (%illuminant-name to) illuminant-name)
    to))
