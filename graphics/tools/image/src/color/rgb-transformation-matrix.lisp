(in-package #:mfiano.graphics.tools.image)

;; This hash table is keyed by a list of (FROM TO STANDARD-ILLUMINANT) with a value representing a
;; 3x3 matrix that can be used to convert a color in FROM space to TO space, where FROM or TO is any
;; RGB space or XYZ space, with one side required to be XYZ. STANDARD-ILLUMINANT is the name of the
;; standard illuminant, such as :D65, that the RGB space is using for its chromaticity.
(gv:define-global-var -rgb-transformation-matrices-
    (labels ((generate-pairs ()
               (let ((pairs nil))
                 (alexandria:map-product
                  (lambda (x y)
                    (push (cons x y) pairs))
                  +rgb-working-spaces+
                  +standard-illuminants+)
                 (nreverse pairs)))
             (calculate-rgb-conversion-matrix (rgb-space standard-illuminant)
               (destructuring-bind ((rx ry) (gx gy) (bx by))
                   (u:href -rgb-chromaticity-coordinates- rgb-space)
                 (let* ((r (v3:vec (/ rx ry) 1 (/ (- 1 rx ry) ry)))
                        (g (v3:vec (/ gx gy) 1 (/ (- 1 gx gy) gy)))
                        (b (v3:vec (/ bx by) 1 (/ (- 1 bx by) by)))
                        (scale (m3:*v3 (m3:invert (m3:mat r g b))
                                       (get-white-point standard-illuminant))))
                   (m3:mat (v3:scale r (v3:x scale))
                           (v3:scale g (v3:y scale))
                           (v3:scale b (v3:z scale))))))
             (make-rgb-transformation-matrix-table ()
               (let ((table (u:dict #'equal)))
                 (dolist (pair (generate-pairs))
                   (destructuring-bind (rgb-space . illuminant) pair
                     (let ((matrix (calculate-rgb-conversion-matrix rgb-space illuminant)))
                       (setf (u:href table (list rgb-space 'xyz illuminant)) matrix
                             (u:href table (list 'xyz rgb-space illuminant)) (m3:invert matrix)))))
                 table)))
      (make-rgb-transformation-matrix-table)))

(declaim (inline get-rgb-transformation-matrix))
(defun get-rgb-transformation-matrix (from to standard-illuminant)
  (declare (optimize speed))
  (values (u:href -rgb-transformation-matrices- (list from to standard-illuminant))))

(declaim (inline %transform-rgb-xyz))
(defun %transform-rgb-xyz (from to standard-illuminant)
  (declare (optimize speed))
  (let* ((from-space (color-space from))
         (to-space (color-space to))
         (matrix (get-rgb-transformation-matrix from-space to-space standard-illuminant)))
    (m3:*v3! (data to) matrix (data from))
    to))
