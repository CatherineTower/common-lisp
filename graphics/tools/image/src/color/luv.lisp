(in-package #:mfiano.graphics.tools.image.color)

(u:define-constant +epsilon/luv+ #.(float 216/24389 1d0))
(u:define-constant +kappa/luv+ #.(float 24389/27 1d0))
(u:define-constant +c/luv+ #.(float -1/3 1d0))

;;; Luv->XYZ

(defun %u-chromaticity (color-components)
  (v3:with-components ((color- color-components))
    (/ (* color-x 4)
       (+ color-x (* color-y 15) (* color-z 3)))))

(defun %v-chromaticity (color-components)
  (v3:with-components ((color- color-components))
    (/ (* color-y 9)
       (+ color-x (* color-y 15) (* color-z 3)))))

;; The mapping for Luvs in WITH-COMPONENTS is thus: x->l, y->u, z->v

(defun %a (luv-channels illuminant)
  (v3:with-components ((luv- luv-channels))
    (/ (1- (/ (* 52 luv-x)
              (+ luv-y (* 13 luv-x (%u-chromaticity illuminant)))))
       3)))

(defun %d (luv-channels y illuminant)
  (v3:with-components ((luv- luv-channels))
    (* (- (/ (* 39 luv-x)
             (+ luv-z (* 13 luv-x (%v-chromaticity illuminant))))
          5)
       y)))

(defun %y (luv-channels)
  (v3:with-components ((luv- luv-channels))
    (if (> luv-x (* +kappa/luv+ +epsilon/luv+))
        (expt (/ (+ luv-x 16) 116) 3)
        (/ luv-x +kappa/luv+))))

(defun %luv->xyz (in out)
  (let ((source-channels (data in))
        (illuminant (get-white-point (illuminant-name in))))
    (when (zerop (v3:x source-channels))
      (error "Illegal L value in Luv ~A" in))
    (let* ((a (%a source-channels illuminant))
           (y (%y source-channels))
           (x (/ (- (%d source-channels y illuminant) (* -5 y))
                 (- a -1/3)))
           (z (+ (* x a)
                 (* y -5))))
      (v3:with-components ((xyz- (data out)))
        (setf xyz-x x)
        (setf xyz-y y)
        (setf xyz-z z)))
    out))

;;; XYZ->LUV

(defun %reference-y (y illuminant)
  (/ y (v3:y illuminant)))

(defun %xyz->luv (in out)
  (let* ((source-channels (data in))
         (illuminant (get-white-point (illuminant-name in)))
         (reference-y (%reference-y (v3:y source-channels) illuminant))
         (l (if (> reference-y +epsilon/luv+)
                (- (* 116 (expt reference-y 1/3)) 16)
                (* +kappa/luv+ reference-y)))
         (u (* 13 l (- (%u-chromaticity source-channels)
                       (%u-chromaticity illuminant))))
         (v (* 13 l (- (%v-chromaticity source-channels)
                       (%v-chromaticity illuminant)))))
    (v3:with-components ((luv- (data out)))
      (setf luv-x l)
      (setf luv-y u)
      (setf luv-z v)))
  out)
