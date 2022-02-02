(in-package #:mfiano.graphics.tools.image)

(u:define-constant +rgb-spaces+
    '(:adobe-rgb :apple-rgb :best-rgb :beta-rgb :bruce-rgb :cie-rgb :colormatch-rgb :don-rgb-4
      :eci-rgb-v2 :ekta-space-ps5 :ntsc-rgb :pal/secam-rgb :prophoto-rgb :smpte-c-rgb :srgb
      :wide-gamut-rgb)
  :test #'equal)

(defvar *rgb-chromaticity-coordinates*
  (u:dict
   :adobe-rgb '((0.64 0.33) (0.21 0.71) (0.15 0.06))
   :apple-rgb '((0.625 0.34) (0.28 0.595) (0.155 0.07))
   :best-rgb '((0.7347 0.2653) (0.215 0.775) (0.13 0.035))
   :beta-rgb '((0.6888 0.3112) (0.1986 0.7551) (0.1265 0.0352))
   :bruce-rgb '((0.64 0.33) (0.28 0.65) (0.15 0.06))
   :cie-rgb '((0.735 0.265) (0.274 0.717) (0.167 0.009))
   :colormatch-rgb '((0.63 0.34) (0.295 0.605) (0.15 0.075))
   :don-rgb-4 '((0.696 0.3) (0.215 0.765) (0.13 0.035))
   :eci-rgb-v2 '((0.67 0.33) (0.21 0.71) (0.14 0.08))
   :ekta-space-ps5 '((0.695 0.305) (0.26 0.7) (0.11 0.005))
   :ntsc-rgb '((0.67 0.33) (0.21 0.71) (0.14 0.08))
   :pal/secam-rgb '((0.64 0.33) (0.29 0.6) (0.15 0.06))
   :prophoto-rgb '((0.7347 0.2653) (0.1596 0.8404) (0.0366 0.0001))
   :smpte-c-rgb '((0.63 0.34) (0.31 0.595) (0.155 0.07))
   :srgb '((0.64 0.33) (0.3 0.6) (0.15 0.06))
   :wide-gamut-rgb '((0.735 0.265) (0.115 0.826) (0.157 0.018))))

;; This hash table is keyed by a list of (FROM TO STANDARD-ILLUMINANT) with a value representing a
;; 3x3 matrix that can be used to convert a color in FROM space to TO space, where FROM or TO is any
;; RGB space or XYZ space, with one side required to be XYZ. STANDARD-ILLUMINANT is the name of the
;; standard illuminant, such as :D65, that the RGB space is using for its chromaticity.
(defvar *rgb-conversion-matrices*
  (labels ((generate-pairs ()
             (let ((pairs nil))
               (alexandria:map-product
                (lambda (x y)
                  (push (cons x y) pairs))
                +rgb-spaces+
                +standard-illuminants+)
               (nreverse pairs)))
           (calculate-rgb-conversion-matrix (rgb-space standard-illuminant)
             (destructuring-bind ((rx ry) (gx gy) (bx by))
                 (u:href *rgb-chromaticity-coordinates* rgb-space)
               (let* ((r (v3:vec (/ rx ry) 1 (/ (- 1 rx ry) ry)))
                      (g (v3:vec (/ gx gy) 1 (/ (- 1 gx gy) gy)))
                      (b (v3:vec (/ bx by) 1 (/ (- 1 bx by) by)))
                      (scale (m3:*v3 (m3:invert (m3:mat r g b))
                                     (get-white-point standard-illuminant))))
                 (m3:mat (v3:scale r (v3:x scale))
                         (v3:scale g (v3:y scale))
                         (v3:scale b (v3:z scale))))))
           (populate-rgb-conversion-matrix-table ()
             (let ((table (u:dict #'equal)))
               (dolist (pair (generate-pairs))
                 (destructuring-bind (rgb-space . illuminant) pair
                   (let ((matrix (calculate-rgb-conversion-matrix rgb-space illuminant)))
                     (setf (u:href table (list rgb-space :xyz illuminant)) matrix
                           (u:href table (list :xyz rgb-space illuminant)) (m3:invert matrix)))))
               table)))
    (populate-rgb-conversion-matrix-table)))
