(in-package #:mfiano.graphics.tools.image)

(defun register-chromatic-adaptation-method (name matrix)
  (check-type matrix m3:mat)
  (setf (u:href (cone-responses *context*) name) matrix))

(defmacro define-builtin-chromatic-adaptation-methods (() &body body)
  `(with-context (*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name components) x
            `(register-chromatic-adaptation-method ',name (m3:mat ,@components))))
        body)))

(defun get-chromatic-adaptation-transform (method source-illuminant-name target-illuminant-name)
  (declare (optimize speed))
  (let* ((transforms (chromatic-adaptation-transforms *context*))
         (key (list method source-illuminant-name target-illuminant-name)))
    (declare (dynamic-extent key))
    (flet ((calculate-transform ()
             (let ((cone-response (u:href (cone-responses *context*) method))
                   (source-white-point (get-white-point source-illuminant-name))
                   (target-white-point (get-white-point target-illuminant-name)))
               (m3:* (m3:invert cone-response)
                     (m3:* (m3:set-diagonal m3:+zero+
                                            (v3:/ (m3:*v3 cone-response target-white-point)
                                                  (m3:*v3 cone-response source-white-point)))
                           cone-response)))))
      (u:if-found (transform (u:href transforms key))
        transform
        (setf (u:href transforms (copy-list key)) (calculate-transform))))))

(defun adapt-chromaticity (color illuminant-name &key (method :bradford))
  (declare (optimize speed))
  (let ((source (illuminant-name color))
        (target illuminant-name))
    (when (eq source target)
      (return-from adapt-chromaticity color))
    (let ((data (data color))
          (transform (get-chromatic-adaptation-transform method source target)))
      (m3:*v3! data transform data)
      color)))
