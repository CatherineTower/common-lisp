(in-package #:mfiano.graphics.tools.image.color)

(defun register-chromatic-adaptation-method (name matrix)
  (check-type matrix m:matrix3)
  (setf (u:href (base:cone-responses base:*context*) name) matrix))

(defmacro define-builtin-chromatic-adaptation-methods (() &body body)
  `(base:with-context (base:*default-context*)
     ,@(mapcar
        (lambda (x)
          (destructuring-bind (name (column0 column1 column2)) x
            `(register-chromatic-adaptation-method
              ',name
              (m:mat/from-vecs (m:vec ,@column0) (m:vec ,@column1) (m:vec ,@column2)))))
        body)))

(defun get-chromatic-adaptation-transform (method source-illuminant-name target-illuminant-name)
  (declare (optimize speed))
  (let* ((transforms (base:chromatic-adaptation-transforms base:*context*))
         (key (list method source-illuminant-name target-illuminant-name)))
    (declare (dynamic-extent key))
    (flet ((calculate-transform ()
             (let ((cone-response (u:href (base:cone-responses base:*context*) method))
                   (source-white-point (get-white-point source-illuminant-name))
                   (target-white-point (get-white-point target-illuminant-name)))
               (m:* (m:invert cone-response)
                    (m:* (m:set-diagonal m:+m3-zero+
                                         (m:/ (m:* cone-response target-white-point)
                                              (m:* cone-response source-white-point)))
                         cone-response)))))
      (u:if-found (transform (u:href transforms key))
        transform
        (setf (u:href transforms (copy-list key)) (calculate-transform))))))

(defun adapt-chromaticity (color illuminant-name &key (method 'bradford))
  (declare (optimize speed))
  (let ((source (illuminant-name color))
        (target illuminant-name))
    (when (eq source target)
      (return-from adapt-chromaticity color))
    (let ((data (data color))
          (transform (get-chromatic-adaptation-transform method source target)))
      (m:*! transform data data)
      (setf (%illuminant-name color) illuminant-name)
      color)))
