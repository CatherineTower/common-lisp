(in-package #:mfiano.graphics.image.test)

(defun collect-result (result sequence)
  (let ((expected (make-array (length result) :element-type 'u:f64 :initial-element 0d0)))
    (map-into expected (lambda (x) (float x 1d0)) sequence)
    (cons result expected)))

(defun one-way (from-color to-color)
  (let ((out (i:convert from-color to-color)))
    (c::channels out)))

(defun round-trip (from-color to-color)
  (let* ((to-color (i:convert from-color to-color))
         (from-space (c::space-name from-color))
         (out (i:make-color (type-of from-color) :space from-space)))
    (c::channels (i:convert to-color out))))

(defmacro test-one-way (from to illuminant expected)
  (u:once-only (from)
    (u:with-gensyms (from-channels expected-channels to-color space result)
      (destructuring-bind (to-model &optional to-space) (u:ensure-list to)
        `(let* ((,space ,(or to-space (u:make-keyword to-model)))
                (,from-channels (c::channels ,from))
                (,expected-channels (make-array (length ,from-channels)
                                                :element-type 'u:f64
                                                :initial-element 0d0))
                (,to-color (i:make-color ',to-model :space ,space))
                (,result (one-way ,from ,to-color)))
           (map-into ,expected-channels (lambda (x) (float x 1d0)) ',expected)
           (is ,result ,expected-channels :test (lambda (x y) (v3:= x y :rel 1d-2))
               (format nil "~{~a~^/~} -> ~{~a~^/~} (illuminant: ~a)"
                       (adjoin (u:make-keyword (type-of ,from)) (list (c::space-name ,from)))
                       (adjoin ',(u:make-keyword to-model) (list ,space))
                       ',illuminant)))))))

(defmacro test-round-trip (from to &key (count 100) (min 0d0) (max 0d0))
  (u:once-only (min max)
    (u:with-gensyms (from-color from-channels to-color results result fail check)
      (destructuring-bind (from-model &optional (from-space from-model)) (u:ensure-list from)
        (destructuring-bind (to-model &optional (to-space to-model)) (u:ensure-list to)
          `(let ((,results nil))
             (dotimes (#:i ,count)
               (let* ((,from-color (i:make-color ',from-model :space ',from-space))
                      (,from-channels (c::channels ,from-color))
                      (,to-color (i:make-color ',to-model :space ',to-space)))
                 (map-into ,from-channels
                           (lambda (x)
                             (declare (ignore x))
                             (float (+ ,min (random (1+ (- ,max ,min)))) 1d0))
                           ,from-channels)
                 (let ((,result (round-trip ,from-color ,to-color)))
                   (push (collect-result ,result ,from-channels) ,results))))
             (let* ((,fail)
                    (,check (every
                             (lambda (x)
                               (let ((pass (v3:= (car x) (cdr x))))
                                 (unless pass
                                   (setf ,fail x))
                                 pass))
                             ,results)))
               (ok ,check
                   ,(format nil "~{~a~^/~} -> ~{~a~^/~} -> ~{~a~^/~} (~d iterations)"
                            (adjoin from-model `(,from-space))
                            (adjoin to-model `(,to-space))
                            (adjoin from-model `(,from-space))
                            count))
               (when ,fail
                 (format t "~a is expected to be ~a" (car ,fail) (cdr ,fail))))))))))

(defmacro define-test/one-way ((from-model &rest args) &body body)
  (u:with-gensyms (from)
    `(let ((,from (,(u:format-symbol :c "~a" from-model) ,@args)))
       ,@(u:mappend
          (lambda (x)
            (destructuring-bind (to-model . expected-specs) x
              (let ((to-model (u:format-symbol :c "~a" to-model)))
                (u:mappend
                 (lambda (y)
                   (destructuring-bind (illuminant expected) y
                     `((setf (c::%illuminant-name ,from) ',illuminant)
                       (test-one-way ,from ,to-model ,illuminant ,expected))))
                 expected-specs))))
          body))))
