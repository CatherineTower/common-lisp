(in-package #:mfiano.graphics.tools.image)

(u:define-constant +epsilon/luv+ #.(float 216/24389 1f0))
(u:define-constant +kappa/luv+ #.(float 24389/27 1f0))
(u:define-constant +c/luv+ #.(float -1/3 1f0))

(defparameter *reference-white/xyz* (v3:vec 0.964220f0 1f0 0.825210f0))

(defun %reference-white-u-chromaticity (reference-white)
  (v3:with-components ((white- reference-white))
    (/ (* white-x 4)
       (+ white-x (* white-y 15) (* white-z 3)))))

(defun %reference-white-v-chromaticity (reference-white)
  (v3:with-components ((white- reference-white))
    (/ (* white-y 9)
       (+ white-x (* white-y 15) (* white-z 3)))))

;; The mapping for Luv's in WITH-VECTOR is thus: x->l, y->u, z->v

(defun %a (luv &optional (reference-white *reference-white/xyz*))
  (v3:with-components ((luv- luv))
      (/ (1- (/ (* 52 luv-x)
               (+ luv-y (* 13 luv-x (%reference-white-u-chromaticity reference-white)))))
         3)))

(defun %d (luv y &optional (reference-white *reference-white/xyz*))
  (v3:with-components ((luv- luv))
    (* (- (/ (* 39 luv-x)
             (+ luv-z (* 13 luv-x (%reference-white-v-chromaticity reference-white))))
          5)
       y)))

(defun %y (luv)
  (v3:with-components ((luv- luv))
    (if (> luv-x (* +kappa/luv+ +epsilon/luv+))
        (expt (/ (+ luv-x 16) 116) 3)
        (/ luv-x +kappa/luv+))))

;; Inlined into LUV->XYZ, kept for reference
;; (defun %x (luv)
;;   (let ((y (%y luv)))
;;     (/ (- (%d luv y) (* -5 y))
;;        (- (%a luv) -1/3))))

;; Inlined into LUV->XYZ, kept for reference
;; (defun %z (luv)
;;   (let ((y (%y luv))
;;         (x (%x luv)))
;;     (+ (* x (%a luv))
;;        (* y -5))))

(defun luv->xyz (in out)
  (when (zerop (v3:x in))
    (error "Illegal L value in Luv ~A" in))
  (let* ((a (%a in))
         (y (%y in))
         (x (/ (- (%d in y) (* -5 y))
               (- a -1/3)))
         (z (+ (* x a)
               (* y -5))))
    (v3:with-components ((xyz- out))
      (setf xyz-x x)
      (setf xyz-y y)
      (setf xyz-z z)))
  out)

(let ((ins '((10 5 5)
             (10 5 10)
             (50 32 6)
             (100 0 0)
             (50 -100 -100)))
      (outs '((0.011914886 0.011260199 0.0038838014)
              (0.011103791 0.011260199 -2.1322072e-4)
              (0.2153254 0.1841865 0.118402004)
              (0.9642199 1.0 0.8252096)
              (0.06858555 0.1841865 0.7094506))))
  (loop :for in :in ins
        :for out :in outs
        :for luv = (apply #'v3:vec in)
        :for xyz = (apply #'v3:vec out)
        do (let ((test-xyz (luv->xyz luv (v3:vec 0 0 0))))
             (unless (v3:= test-xyz xyz)
               (error "Test failed: ~A is not equal to ~A"
                      test-xyz
                      xyz)))))
