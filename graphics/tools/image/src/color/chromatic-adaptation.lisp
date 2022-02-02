(in-package #:mfiano.graphics.tools.image)

(defvar *chromatic-adaptation-transforms*
  (u:dict
   :bradford
   (m3:mat 0.8951 -0.7502 0.0389 0.2664 1.7135 -0.0685 -0.1614 0.0367 1.0296)
   :ciecam02
   (m3:mat 0.7328 -0.7036 0.003 0.4296 1.6975 0.0136 -0.1624 0.0061 0.9834)
   :cat16
   (m3:mat 0.401288 -0.250268 -0.002079 0.650173 1.204414 0.048952 -0.051461 0.045854 0.953127)
   :ciecam97s-revised
   (m3:mat 0.8562 -0.836 0.0357 0.3372 1.8327 -0.0469 -0.1934 0.0033 1.0112)
   :fairchild
   (m3:mat 0.8562 -0.836 0.0357 0.3372 1.8327 -0.0469 -0.1934 0.0033 1.0112)
   :sharp
   (m3:mat 1.2694 -0.8364 0.0297 -0.0988 1.8006 -0.0315 -0.1706 0.0357 1.0018)
   :von-kries
   (m3:mat 0.40024 -0.2263 0 0.7076 1.16532 0 -0.08081 0.0457 0.91822)
   :xyz-scaling
   (m3:id)))

(defvar *chromatic-adaptation-matrices*
  (labels ((permute-illuminant-pairs ()
             (let ((illuminant-pairs nil))
               (u:map-permutations (lambda (x) (push x illuminant-pairs))
                                   (u:hash-keys *standard-illuminant-white-points*)
                                   :length 2)
               (nreverse illuminant-pairs)))
           (calculate-chromatic-adaptation-matrix (type source target)
             (let ((transform (u:href *chromatic-adaptation-transforms* type)))
               (m3:* (m3:invert transform)
                     (m3:* (m3:set-diagonal
                            m3:+zero+
                            (v3:/ (m3:*v3 transform
                                          (u:href *standard-illuminant-white-points* target))
                                  (m3:*v3 transform
                                          (u:href *standard-illuminant-white-points* source))))
                           transform))))
           (populate-chromatic-adaptation-matrix-table ()
             (let ((table (u:dict #'equal))
                   (illuminant-pairs (permute-illuminant-pairs)))
               (u:do-hash-keys (type *chromatic-adaptation-transforms*)
                 (dolist (pair illuminant-pairs)
                   (destructuring-bind (source target) pair
                     (let ((matrix (calculate-chromatic-adaptation-matrix type source target)))
                       (setf (u:href table (list type source target)) matrix)))))
               table)))
    (populate-chromatic-adaptation-matrix-table)))

(declaim (inline get-chromatic-adaptation-matrix))
(defun get-chromatic-adaptation-matrix (type source target)
  (declare (optimize speed))
  (values (u:href *chromatic-adaptation-matrices* (list type source target))))