(in-package #:mfiano.graphics.image.test)

(defvar *level* 0)

(defclass report (p:report)
  ((%output
    :accessor output
    :initarg :output
    :initarg :stream)
   (%show-listing-p
    :accessor show-listing-p
    :initarg :show-listing))
  (:default-initargs
   :stream *standard-output*
   :show-listing t))

(defmethod p:eval-in-context :before ((report report) (result p:parent-result))
  (p:report-on result report))

(defmethod p:eval-in-context :around ((report report) (result p:result))
  (when (eq (p:status result) :unknown)
    (multiple-value-prog1
        (handler-case (call-next-method)
          (error (datum)
            (warn "Unhandled error when evaluating ~a:~%  ~a~%"
                  (or (ignore-errors (p:format-result result :oneline)) result)
                  datum)
            (setf (p:status result) :failed)))
      (p:report-on result report))))

(defmethod p:eval-in-context ((report report) (result p:value-result))
  (handler-case (call-next-method)
    (error (datum)
      (setf (p:value result) (if (typep result 'p:multiple-value-result) (list datum) datum))
      (setf (p:status result) :failed))))

(defmethod p:eval-in-context ((report report) (result p:finishing-result))
  (handler-case (call-next-method)
    (error ())))

(defmethod p:eval-in-context ((report report) (result p:result))
  (let ((*level* (1+ *level*)))
    (call-next-method)))

(defmethod p:report-on :around (thing (report report))
  (when (show-listing-p report)
    (call-next-method)))

(defmethod p:report-on :before ((result p:result) (report report))
  (format (output report)
          "~& ~:[      ~;~:*~6,3f~] ~a~v@{  ~} "
          (p:duration result)
          (case (p:status result)
            (:passed "  [PASS]  ")
            (:failed "  [FAIL]  ")
            (:skipped " [SKIP]  ")
            (t "          "))
          *level*
          t))

(defmethod p:report-on :after (thing (report report))
  (terpri (output report))
  (force-output (output report)))

(defmethod p:report-on ((result p:result) (report report))
  (write-string (p:format-result result :oneline) (output report)))

(defmethod p:report-on ((result p:test-result) (report report))
  (write-string (p:name (p:expression result)) (output report)))

(defmethod p:summarize ((report report))
  (flet ((filter (results)
           (remove-if (lambda (x) (typep x 'p:test-result)) results)))
    (let ((failures (p:results-with-status :failed report)))
      (format (output report)
              "~&~%~
             Summary:~%~
             Passed:  ~6d~%~
             Failed:  ~6d~%~
             Skipped: ~6d~%"
              (length (filter (p:results-with-status :passed report)))
              (length (filter failures))
              (length (p:results-with-status :skipped report)))
      (when failures
        (format (output report) "~&~%Failures:~%")
        (dolist (failure failures)
          (if (typep failure 'p:parent-result)
              (format (output report) "~&~a~%" (p:format-result failure :extensive))
              (format (output report) "~&~a~%~%" (p:format-result failure :extensive)))))
      report)))

(defun run ()
  (p:test :mfiano.graphics.image.test :report 'report))
