(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  ;; Reference: http://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf
  (adobe-rgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.21d0 0.71d0) (0.15d0 0.06d0))
   :gamma #.(float 563/256 1d0))
  ;; Reference: https://en.wikipedia.org/wiki/Wide-gamut_RGB_color_space
  (adobe-wide-gamut-rgb
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.1152d0 0.8264d0) (0.1566d0 0.0177d0))
   :gamma #.(float 563/256 1d0))
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (apple-rgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.625d0 0.34d0) (0.28d0 0.595d0) (0.155d0 0.07d0))
   :gamma 1.8d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (best-rgb
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.215d0 0.775d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (beta-rgb
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.6888d0 0.3112d0) (0.1986d0 0.7551d0) (0.1265d0 0.0352d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (bruce-rgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.28d0 0.65d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  ;; Reference: https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.470-6-199811-S!!PDF-E.pdf
  (bt470-ntsc
   :models (rgb rgba)
   :illuminant :c
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (cie-rgb
   :models (rgb rgba)
   :illuminant :e
   :coords ((0.7347d0 0.2653d0) (0.2738d0 0.7174d0) (0.1666d0 0.0089d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (colormatch-rgb
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.63d0 0.34d0) (0.295d0 0.605d0) (0.15d0 0.075d0))
   :gamma 1.8d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (don-rgb-4
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.696d0 0.3d0) (0.215d0 0.765d0) (0.13d0 0.035d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (eci-rgb-v2
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.67d0 0.33d0) (0.21d0 0.71d0) (0.14d0 0.08d0))
   :gamma L*)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (ekta-space-ps5
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.695d0 0.305d0) (0.26d0 0.7d0) (0.11d0 0.005d0))
   :gamma 2.2d0)
  ;; Reference: https://www.color.org/ROMMRGB.pdf
  (prophoto-rgb
   :models (rgb rgba)
   :illuminant :d50
   :coords ((0.7347d0 0.2653d0) (0.1596d0 0.8404d0) (0.0366d0 0.0001d0))
   :gamma 1.8d0)
  (simple-srgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma 2.2d0)
  ;; Reference: http://www.brucelindbloom.com/WorkingSpaceInfo.html
  (smpte-c-rgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.63d0 0.34d0) (0.31d0 0.595d0) (0.155d0 0.07d0))
   :gamma 2.2d0)
  ;; Reference: https://en.wikipedia.org/wiki/SRGB
  (srgb
   :models (rgb rgba)
   :illuminant :d65
   :coords ((0.64d0 0.33d0) (0.3d0 0.6d0) (0.15d0 0.06d0))
   :gamma srgb))

(defclass rgb (model)
  ((%coords
    :type list
    :reader coords
    :initarg :coords)
   (%gamma
    :type (or u:positive-float symbol)
    :reader gamma
    :initarg :gamma))
  (:default-initargs
   :channel-names '(#\R #\G #\B)
   :default-space 'srgb))

(defun rgb (r g b &key (space :srgb) illuminant)
  (make-instance 'rgb :space space :illuminant illuminant :channel0 r :channel1 g :channel2 b))

(defclass rgba (rgb alpha) ()
  (:default-initargs
   :channels (v4:zero)
   :channel-names '(#\R #\G #\B #\A)
   :alpha-index 3))

(defun rgba (r g b a &key (space :srgb) illuminant pre-multiply-alpha)
  (make-instance 'rgba
                 :space space
                 :illuminant illuminant
                 :pre-multiply-alpha pre-multiply-alpha
                 :channel0 r
                 :channel1 g
                 :channel2 b
                 :channel3 a))

;;; Linearize/delinearize RGB space.

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
  (if (<= value 0.08)
      (/ (* value 100d0) +cie-k+)
      (expt (/ (+ value 0.16d0) 1.16d0) 3d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'L*)))
  (if (<= value +cie-e+)
      (/ (* value +cie-k+) 100d0)
      (- (* 1.16d0 (expt value (/ 3))) 0.16d0)))

(defmethod linearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.04045)
      (/ value 12.92d0)
      (expt (/ (+ value 0.055d0) 1.055d0) 2.4d0)))

(defmethod delinearize-rgb-channel (value (gamma (eql 'srgb)))
  (if (<= value 0.0031308)
      (* value 12.92d0)
      (- (* (expt value (/ 2.4d0)) 1.055d0) 0.055d0)))

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

(declaim (inline %rgb-xyz))
(defun %rgb-xyz (rgb xyz)
  (declare (optimize speed))
  (let* ((illuminant-name (illuminant-name rgb))
         (transform (get-rgb-transform rgb xyz illuminant-name))
         (rgb-channels (v3:zero)))
    (declare (dynamic-extent rgb-channels))
    (replace rgb-channels (the (or v3:vec v4:vec) (channels rgb)))
    (m3:*v3! (channels xyz) transform rgb-channels)
    (setf (%illuminant-name xyz) illuminant-name)
    xyz))

(declaim (inline rgb->xyz))
(defun rgb->xyz (rgb xyz)
  (declare (optimize speed))
  (with-pool-color (temp-rgb (type-of rgb) :space (space-name rgb) :copy rgb)
    (linearize-rgb temp-rgb)
    (%rgb-xyz temp-rgb xyz)))

(declaim (inline %xyz->rgb))
(defun %xyz->rgb (xyz rgb)
  (declare (optimize speed))
  (let* ((illuminant-name (illuminant-name rgb))
         (transform (get-rgb-transform xyz rgb illuminant-name))
         (rgb-channels (v3:zero)))
    (declare (dynamic-extent rgb-channels))
    (adapt-chromaticity xyz illuminant-name)
    (m3:*v3! rgb-channels transform (channels xyz))
    (replace (the (or v3:vec v4:vec) (channels rgb)) rgb-channels)
    (setf (%illuminant-name rgb) illuminant-name)
    rgb))

(declaim (inline xyz->rgb))
(defun xyz->rgb (xyz rgb)
  (declare (optimize speed))
  (with-pool-color (temp-xyz 'xyz :copy xyz)
    (%xyz->rgb temp-xyz rgb)
    (delinearize-rgb rgb)))
