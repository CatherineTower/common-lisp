(in-package #:%mfiano.graphics.image.color)

(u:eval-always
  (u:define-constant +cie-e+ #.(float 216/24389 1d0))
  (u:define-constant +cie-k+ #.(float 24389/27 1d0)))

(define-color-spaces ()
  (luv :illuminant e))

(defclass luv (model) ()
  (:default-initargs
   :channel-names '(l u v)))

(defun luv (l u v &key)
  (make-instance 'luv :channel0 l :channel1 u :channel2 v))

(defmethod default-color ((model (eql 'luv)) &rest args)
  (declare (ignore args))
  (luv 0 0 0))

(defun luv->xyz (luv xyz)
  (declare (optimize speed))
  (let ((luv-channels (channels luv))
        (xyz-channels (channels xyz))
        (white-point (get-white-point (illuminant-name xyz))))
    (declare (v3:vec luv-channels xyz-channels white-point))
    (v3:with-components ((luv- luv-channels)
                         (xyz- xyz-channels)
                         (w white-point))
      (when (zerop luv-x)
        (v3:zero! xyz-channels)
        (return-from luv->xyz xyz))
      (let* ((div (+ wx (* wy 15) (* wz 3)))
             (a (* (1- (/ (* 52 luv-x) (+ luv-y (* 13 luv-x(/ (* wx 4) div))))) #.(/ 3)))
             (y (if (> luv-x #.(* +cie-k+ +cie-e+))
                    (expt (* (+ luv-x 16) #.(/ 116)) 3)
                    (* luv-x #.(/ +cie-k+))))
             (d (* (- (/ (* 39 luv-x) (+ luv-z (* 13 luv-x (/ (* wy 9) div)))) 5) y))
             (-5y (* y -5)))
        (setf xyz-x (/ (- d -5y) (- a -1/3))
              xyz-y y
              xyz-z (+ (* xyz-x a) -5y))
        xyz))))

(defun xyz->luv (xyz luv)
  (declare (optimize speed))
  (let ((xyz-channels (channels xyz))
        (luv-channels (channels luv))
        (white-point (get-white-point (illuminant-name xyz))))
    (declare (v3:vec xyz-channels luv-channels white-point))
    (v3:with-components ((xyz- xyz-channels)
                         (luv- luv-channels)
                         (w white-point))
      (let ((reference-y (/ xyz-y wy))
            (div-uv (+ xyz-x (* xyz-y 15) (* xyz-z 3)))
            (div-w (+ wx (* wy 15) (* wz 3))))
        (if (zerop div-uv)
            (v3:zero! luv-channels)
            (setf luv-x (if (> reference-y +cie-e+)
                            (- (* 116 (expt reference-y #.(/ 3d0))) 16)
                            (* +cie-k+ reference-y))
                  luv-y (* luv-x 13 (- (/ (* xyz-x 4) div-uv) (/ (* wx 4) div-w)))
                  luv-z (* luv-x 13 (- (/ (* xyz-y 9) div-uv) (/ (* wy 9) div-w)))))
        luv))))
