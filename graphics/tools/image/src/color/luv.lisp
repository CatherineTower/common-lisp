(in-package #:mfiano.graphics.tools.image.color)

(u:eval-always
  (u:define-constant +cie-e+ #.(float 216/24389 1d0))
  (u:define-constant +cie-k+ #.(float 24389/27 1d0)))

(defun luv->xyz (in out)
  (declare (optimize speed))
  (let ((in-data (data in))
        (out-data (data out))
        (white-point (get-white-point (illuminant-name out))))
    (declare (v3:vec in-data out-data white-point))
    (v3:with-components ((i in-data)
                         (o out-data)
                         (w white-point))
      (when (zerop ix)
        (v3:zero! out-data)
        (return-from luv->xyz out))
      (let* ((div (+ wx (* wy 15) (* wz 3)))
             (a (* (1- (/ (* 52 ix) (+ iy (* 13 ix (/ (* wx 4) div))))) #.(/ 3)))
             (y (if (> ix (* +cie-k+ +cie-e+))
                    (expt (* (+ ix 16) #.(/ 116)) 3)
                    (* ix #.(/ +cie-k+))))
             (d (* (- (/ (* 39 ix) (+ iz (* 13 ix (/ (* wy 9) div)))) 5) y))
             (-5y (* y -5)))
        (setf ox (/ (- d -5y) (- a -1/3))
              oy y
              oz (+ (* ox a) -5y))
        out))))

(defun xyz->luv (in out)
  (declare (optimize speed))
  (let ((in-data (data in))
        (out-data (data out))
        (white-point (get-white-point (illuminant-name in))))
    (declare (v3:vec in-data out-data white-point))
    (v3:with-components ((i in-data)
                         (o out-data)
                         (w white-point))
      (let ((reference-y (/ iy wy))
            (div-uv (+ ix (* iy 15) (* iz 3)))
            (div-w (+ wx (* wy 15) (* wz 3))))
        (if (zerop div-uv)
            (v3:zero! out-data)
            (setf ox (if (> reference-y +cie-e+)
                         (- (* 116 (expt reference-y #.(/ 3d0))) 16)
                         (* +cie-k+ reference-y))
                  oy (* ox 13 (- (/ (* ix 4) div-uv) (/ (* wx 4) div-w)))
                  oz (* ox 13 (- (/ (* iy 9) div-uv) (/ (* wy 9) div-w)))))
        out))))
