(in-package #:%mfiano.graphics.image.color)

(define-color-spaces ()
  (cielab :illuminant d65))

(defclass cielab (model) ()
  (:default-initargs
   :channel-names '("L*" "a*" "b*")))

(defun cielab (l a b)
  (make-instance 'cielab :channel0 l :channel1 a :channel2 b))

(defmethod default-color ((model (eql 'cielab)) &rest args)
  (declare (ignore args))
  (cielab 0 0 0))

(declaim (notinline cielab->xyz))
(defun cielab->xyz (cielab xyz)
  (declare (optimize speed))
  (let ((lab-channels (channels cielab))
        (xyz-channels (channels xyz))
        (white-point (get-white-point (illuminant-name cielab))))
    (declare (v3:vec xyz-channels white-point))
    (v3:with-components ((xyz- xyz-channels)
                         (w white-point))
      (let* ((L (v3:x lab-channels))
             (a (v3:y lab-channels))
             (b (v3:z lab-channels))
             (fy (* (+ L 16) #.(/ 116)))
             (fx (+ (* a #.(/ 500)) fy))
             (fz (- fy (* b #.(/ 200))))
             (fx^3 (expt fx 3))
             (fz^3 (expt fz 3))
             (rx (if (> fx^3 +cie-e+)
                     fx^3
                     (* (- (* fx 116) 16) #.(/ +cie-k+))))
             (ry (if (> L #.(* +cie-k+ +cie-e+))
                     (expt (* (+ L 16) #.(/ 116)) 3)
                     (* L #.(/ +cie-k+))))
             (rz (if (> fz^3 +cie-e+)
                     fz^3
                     (* (- (* fz 116) 16) #.(/ +cie-k+)))))
        (setf xyz-x (* rx wx)
              xyz-y (* ry wy)
              xyz-z (* rz wz))
        xyz))))

(declaim (inline xyz->cielab))
(defun xyz->cielab (xyz cielab)
  (declare (optimize speed))
  (let* ((lab-channels (channels cielab))
         (r (v3:/ (channels xyz) (get-white-point (illuminant-name xyz))))
         (rx (v3:x r))
         (ry (v3:y r))
         (rz (v3:z r))
         (fx (if (> rx +cie-e+)
                 (expt rx #.(/ 3d0))
                 (* (+ (* +cie-k+ rx) 16) #.(/ 116))))
         (fy (if (> ry +cie-e+)
                 (expt ry #.(/ 3d0))
                 (* (+ (* +cie-k+ ry) 16) #.(/ 116))))
         (fz (if (> rz +cie-e+)
                 (expt rz #.(/ 3d0))
                 (* (+ (* +cie-k+ rz) 16) #.(/ 116)))))
    (declare (v3:vec lab-channels)
             (dynamic-extent r))
    (v3:with-components ((lab- lab-channels))
      (setf lab-x (- (* fy 116) 16)
            lab-y (* (- fx fy) 500)
            lab-z (* (- fy fz) 200))
      cielab)))
