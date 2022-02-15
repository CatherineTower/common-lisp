(in-package #:mfiano.graphics.tools.image.color)

(u:define-constant +cie-e+ #.(float 216/24389 1d0))
(u:define-constant +cie-k+ #.(float 24389/27 1d0))

(defun %u-chromaticity (color-components)
  (m:with-vector ((3 color- color-components)) ()
    (/ (* color-x 4)
       (+ color-x (* color-y 15) (* color-z 3)))))

(defun %v-chromaticity (color-components)
  (m:with-vector ((3 color- color-components)) ()
    (/ (* color-y 9)
       (+ color-x (* color-y 15) (* color-z 3)))))

(defun %luv->xyz (in out)
  (let ((source-channels (data in))
        (white-point (get-white-point (illuminant-name out))))
    (when (zerop (m:x source-channels))
      (error "Illegal L value in Luv ~A" in))
    (m:with-vector ((3 luv- source-channels)) ()
      (let* ((a (/ (1- (/ (* 52 luv-x)
                          (+ luv-y (* 13 luv-x (%u-chromaticity white-point)))))
                   3))
             (y (if (> luv-x (* +cie-k+ +cie-e+))
                    (expt (/ (+ luv-x 16) 116) 3)
                    (/ luv-x +cie-k+)))
             (-5y (* y -5))
             (d (* (- (/ (* 39 luv-x)
                         (+ luv-z (* 13 luv-x (%v-chromaticity white-point))))
                      5)
                   y))
             (x (/ (- d -5y)
                   (- a -1/3)))
             (z (+ (* x a) -5y)))
        (m:with-vector ((3 xyz- (data out))) (:read-only nil)
          (setf xyz-x x
                xyz-y y
                xyz-z z)))))
    out)

(defun %xyz->luv (in out)
  (let* ((source-channels (data in))
         (white-point (get-white-point (illuminant-name out)))
         (reference-y (/ (m:y source-channels) (m:y white-point)))
         (l (if (> reference-y +cie-e+)
                (- (* 116 (expt reference-y 1/3)) 16)
                (* +cie-k+ reference-y)))
         (u (* 13 l (- (%u-chromaticity source-channels)
                       (%u-chromaticity white-point))))
         (v (* 13 l (- (%v-chromaticity source-channels)
                       (%v-chromaticity white-point)))))
    (m:with-vector ((3 luv- (data out))) (:read-only nil)
      (setf luv-x l
            luv-y u
            luv-z v))
    out))
