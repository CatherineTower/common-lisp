(in-package #:mfiano.graphics.tools.image)

(u:eval-always
  (defun %generate-rgb-illuminant-pairs ()
    (let ((pairs nil))
      (alexandria:map-product
       (lambda (x y)
         (push (cons x y) pairs))
       -rgb-spaces-
       -illuminants-)
      (nreverse pairs)))

  (defun %calculate-rgb-conversion-matrix (rgb-space illuminant)
    (destructuring-bind ((rx ry) (gx gy) (bx by))
        (u:href -rgb-chromaticity-coordinates- rgb-space)
      (let* ((r (v3:vec (/ rx ry) 1 (/ (- 1 rx ry) ry)))
             (g (v3:vec (/ gx gy) 1 (/ (- 1 gx gy) gy)))
             (b (v3:vec (/ bx by) 1 (/ (- 1 bx by) by)))
             (scale (m3:*v3 (m3:invert (m3:mat r g b))
                            (get-white-point illuminant))))
        (m3:mat (v3:scale r (v3:x scale))
                (v3:scale g (v3:y scale))
                (v3:scale b (v3:z scale))))))

  (defun %make-rgb-transformation-matrix-table ()
    (let ((table (u:dict #'equal)))
      (dolist (pair (%generate-rgb-illuminant-pairs))
        (destructuring-bind (rgb-space . illuminant) pair
          (let ((matrix (%calculate-rgb-conversion-matrix rgb-space illuminant)))
            (setf (u:href table (list rgb-space 'xyz illuminant)) matrix
                  (u:href table (list 'xyz rgb-space illuminant)) (m3:invert matrix)))))
      table)))

;; This hash table is keyed by a list of (FROM TO ILLUMINANT) with a value representing a 3x3 matrix
;; that can be used to convert a color in FROM space to TO space, where FROM or TO is any RGB space
;; or XYZ space, with one side required to be XYZ. ILLUMINANT is the name of the standard
;; illuminant, such as :D65, that the RGB space is using for its chromaticity.
(gv:define-global-var -rgb-transformation-matrices- (%make-rgb-transformation-matrix-table))

(declaim (inline transform-rgb-xyz))
(defun transform-rgb-xyz (from to illuminant)
  (declare (optimize speed))
  (let* ((key (list (color-space from) (color-space to) illuminant))
         (matrix (u:href -rgb-transformation-matrices- key)))
    (declare (dynamic-extent key))
    (m3:*v3! (data to) matrix (data from))
    (setf (%illuminant to) illuminant)
    to))
