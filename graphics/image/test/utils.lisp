(in-package #:mfiano.graphics.image.test)

(defun color (model &optional space)
  (i:default-color model :space (or space model)))

(defun collect-result (result sequence)
  (let ((expected (make-array (length result) :element-type 'u:f64 :initial-element 0d0)))
    (map-into expected (lambda (x) (float x 1d0)) sequence)
    (cons result expected)))

(defun round-trip (from-color to-color)
  (let* ((to-color (i:convert from-color to-color))
         (from-space (c::space-name from-color))
         (out (color (type-of from-color) from-space)))
    (c::channels (i:convert to-color out))))

(defmacro with-round-trips (from to &key (count 1000) (min 0d0) (max 0d0))
  (u:once-only (min max)
    (u:with-gensyms (from-color from-channels to-color results result fail check)
      (destructuring-bind (from-model &optional (from-space from-model)) (u:ensure-list from)
        (destructuring-bind (to-model &optional (to-space to-model)) (u:ensure-list to)
          `(let ((,results nil))
             (dotimes (#:i ,count)
               (let* ((,from-color (color ',from-model ',from-space))
                      (,from-channels (c::channels ,from-color))
                      (,to-color (color ',to-model ',to-space)))
                 (map-into ,from-channels
                           (lambda (x)
                             (declare (ignore x))
                             (float (+ ,min (random (1+ (- ,max ,min)))) 1d0))
                           ,from-channels)
                 (let ((,result (round-trip ,from-color ,to-color)))
                   (push (collect-result ,from-channels ,result) ,results))))
             (let* ((,fail)
                    (,check (every
                             (lambda (x)
                               (let ((pass (v3:= (car x) (cdr x))))
                                 (unless pass
                                   (setf ,fail x))
                                 pass))
                             ,results)))
               (ok ,check
                   (if ,fail
                       (format nil "~a is expected to be ~a" (car ,fail) (cdr ,fail))
                       ,(format nil "~{~a~^/~} -> ~{~a~^/~} -> ~{~a~^/~} (~d iterations)"
                                (adjoin from-model `(,from-space))
                                (adjoin to-model `(,to-space))
                                (adjoin from-model `(,from-space))
                                count))))))))))
