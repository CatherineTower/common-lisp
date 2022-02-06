(in-package #:mfiano.graphics.tools.image)

(defmacro define-chromatic-adaptation-methods (() &body body)
  (let ((names (mapcar #'first body)))
    `(u:eval-always
       (gv:define-global-var -chromatic-adaptation-methods- ',names)
       (gv:define-global-var -chromatic-adaptation-transforms-
           (u:dict
            ,@(u:mappend
               (lambda (x)
                 (destructuring-bind (name transform) x
                   `(',name (m3:mat ,@transform))))
               body)))
       (deftype chromatic-adaptation-method () '(member ,@names)))))

(define-chromatic-adaptation-methods ()
  (:bradford
   (0.8951 -0.7502 0.0389 0.2664 1.7135 -0.0685 -0.1614 0.0367 1.0296))
  (:ciecam02
   (0.7328 -0.7036 0.003 0.4296 1.6975 0.0136 -0.1624 0.0061 0.9834))
  (:cat16
   (0.401288 -0.250268 -0.002079 0.650173 1.204414 0.048952 -0.051461 0.045854 0.953127))
  (:fairchild
   (0.8562 -0.836 0.0357 0.3372 1.8327 -0.0469 -0.1934 0.0033 1.0112))
  (:sharp
   (1.2694 -0.8364 0.0297 -0.0988 1.8006 -0.0315 -0.1706 0.0357 1.0018))
  (:von-kries
   (0.40024 -0.2263 0 0.7076 1.16532 0 -0.08081 0.0457 0.91822))
  (:xyz-scaling
   (1 0 0 0 1 0 0 0 1)))

(u:eval-always
  (defun %permute-illuminant-pairs ()
    (let ((pairs nil))
      (u:map-permutations (lambda (x) (push x pairs)) -illuminants- :length 2)
      (nreverse pairs)))

  (defun %calculate-chromatic-adaptation-matrix (type source target)
    (let ((transform (u:href -chromatic-adaptation-transforms- type))
          (source-white-point (u:href -illuminant-white-points- source))
          (target-white-point (u:href -illuminant-white-points- target)))
      (m3:* (m3:invert transform)
            (m3:* (m3:set-diagonal m3:+zero+
                                   (v3:/ (m3:*v3 transform target-white-point)
                                         (m3:*v3 transform source-white-point)))
                  transform))))

  (defun %make-chromatic-adaptation-matrix-table ()
    (let ((table (u:dict #'equal))
          (illuminant-pairs (%permute-illuminant-pairs)))
      (dolist (method -chromatic-adaptation-methods-)
        (dolist (pair illuminant-pairs)
          (destructuring-bind (source target) pair
            (let ((matrix (%calculate-chromatic-adaptation-matrix method source target)))
              (setf (u:href table (list method source target)) matrix)))))
      table)))

;; This hash table is keyed by a list of (METHOD SOURCE TARGET) with a value representing a 3x3
;; chromatic adaptation transformation matrix that can be used to perform chromatic adaptation on
;; a color with the standard illuminant SOURCE to a color with the standard illuminant TARGET.
(gv:define-global-var -chromatic-adaptation-matrices- (%make-chromatic-adaptation-matrix-table))

(defun adapt-chromaticity (color illuminant &key (method :bradford))
  (declare (optimize speed))
  (let ((source-illuminant (illuminant color)))
    (when (eq source-illuminant illuminant)
      (return-from adapt-chromaticity color))
    (let* ((data (data color))
           (key (list method illuminant source-illuminant))
           (matrix (u:href -chromatic-adaptation-matrices- key)))
      (declare (dynamic-extent key))
      (m3:*v3! data matrix data)
      color)))
