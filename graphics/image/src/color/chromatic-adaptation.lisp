(in-package #:%mfiano.graphics.image.color)

(defun get-chromatic-adaptation-transform (method source-illuminant-name target-illuminant-name)
  (declare (optimize speed))
  (let* ((transforms (base:chromatic-adaptation-transforms base:*context*))
         (key (list method source-illuminant-name target-illuminant-name)))
    (declare (dynamic-extent key))
    (flet ((calculate-transform ()
             (let ((cone-response (u:href (base:cone-responses base:*context*) method))
                   (source-white-point (get-white-point source-illuminant-name))
                   (target-white-point (get-white-point target-illuminant-name)))
               (m3:* (m3:invert cone-response)
                     (m3:* (m3:set-diagonal
                            m3:+zero+
                            (v3:/ (m3:*v3 cone-response target-white-point)
                                  (m3:*v3 cone-response source-white-point)))
                           cone-response)))))
      (bt:with-lock-held ((base:chromatic-adaptation-transform-lock base:*context*))
        (u:if-found (transform (u:href transforms key))
          transform
          (setf (u:href transforms (copy-list key)) (calculate-transform)))))))

(defun adapt-chromaticity (color illuminant-name &key (method :bradford))
  (declare (optimize speed))
  (let ((source (illuminant-name color))
        (target illuminant-name))
    (when (eq source target)
      (return-from adapt-chromaticity color))
    (let ((channels (channels color))
          (transform (get-chromatic-adaptation-transform method source target)))
      (m3:*v3! channels transform channels)
      (setf (%illuminant-name color) illuminant-name)
      color)))

(defun register-chromatic-adaptation-method (name matrix)
  (check-type matrix m3:mat)
  (setf (u:href (base:cone-responses base:*context*) name) matrix))

(defmacro define-chromatic-adaptation-methods (() &body body)
  `(progn
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name components) x
            `(register-chromatic-adaptation-method
              ',name
              (m3:mat ,@(mapcar (lambda (x) (float x 1d0)) components)))))
        body)))

(define-chromatic-adaptation-methods ()
  (:bradford
   ;; Reference: http://www.brucelindbloom.com/index.html?Eqn_ChromAdapt.html
   (0.8951 -0.7502 0.0389 0.2664 1.7135 -0.0685 -0.1614 0.0367 1.0296))
  (:cat02
   ;; Reference: https://en.wikipedia.org/wiki/CIECAM02#CAT02
   (0.7328 -0.7036 0.003 0.4296 1.6975 0.0136 -0.1624 0.0061 0.9834))
  (:cat16
   ;; Reference: https://observablehq.com/@jrus/cam16
   (0.401288 -0.250268 -0.002079 0.650173 1.204414 0.048952 -0.051461 0.045854 0.953127))
  (:fairchild
   ;; Reference: http://markfairchild.org/PDFs/PRO17.pdf
   (0.8562 -0.836 0.0357 0.3372 1.8327 -0.0469 -0.1934 0.0033 1.0112))
  (:sharp
   ;; Reference: https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.364.1672&rep=rep1&type=pdf
   (1.2694 -0.8364 0.0297 -0.0988 1.8006 -0.0315 -0.1706 0.0357 1.0018))
  (:von-kries
   ;; Reference: http://www.brucelindbloom.com/index.html?Eqn_ChromAdapt.html
   (0.40024 -0.2263 0 0.7076 1.16532 0 -0.08081 0.0457 0.91822))
  (:xyz-scaling
   ;; Reference: http://www.brucelindbloom.com/index.html?Eqn_ChromAdapt.html
   (1 0 0 0 1 0 0 0 1)))
