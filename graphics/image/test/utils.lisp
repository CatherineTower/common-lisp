(in-package #:mfiano.graphics.image.test)

(defun collect-result (result sequence)
  (let ((expected (make-array (length result) :element-type 'u:f64 :initial-element 0d0)))
    (map-into expected (lambda (x) (float x 1d0)) sequence)
    (cons result expected)))

(defun round-trip (from-color to-color)
  (let* ((to-color (i:convert from-color to-color))
         (from-space (c::space-name from-color))
         (out (i:make-color (type-of from-color) :space from-space)))
    (c::channels (i:convert to-color out))))

(defmacro test-round-trip (from to &key (count 1000) (min 0d0) (max 0d0))
  (u:once-only (min max)
    (u:with-gensyms (from-color from-channels to-color results result fail check)
      (destructuring-bind (from-model &optional from-space) (u:ensure-list from)
        (destructuring-bind (to-model &optional to-space) (u:ensure-list to)
          `(let ((,from-color (i:make-color
                               ',from-model
                               ,@(when from-space `(:space ',from-space))))
                 (,to-color (i:make-color
                             ',to-model
                             ,@(when to-space `(:space ',to-space))))
                 (,results nil))
             (dotimes (#:i ,count)
               (let ((,from-channels (c::channels ,from-color)))
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
                               (let ((pass (v3:= (car x) (cdr x) :rel 1d-5)))
                                 (unless pass
                                   (setf ,fail x))
                                 pass))
                             ,results)))
               (ok ,check
                   (format nil "~{~a~^/~} -> ~{~a~^/~} -> ~{~a~^/~} (~d iterations)"
                           (adjoin ,(u:make-keyword from-model)
                                   (list (c::space-name ,from-color)))
                           (adjoin ,(u:make-keyword to-model)
                                   (list (c::space-name ,to-color)))
                           (adjoin ,(u:make-keyword from-model)
                                   (list (c::space-name ,from-color)))
                           ,count))
               (when ,fail
                 (format t "~a is expected to be ~a" (car ,fail) (cdr ,fail))))))))))

(defun one-way (from-color to-color)
  (let ((out (i:convert from-color to-color)))
    (c::channels out)))

(defmacro test-one-way (from to illuminant expected)
  (u:with-gensyms (from-binding to-binding expected-channels)
    (destructuring-bind (to-model &optional to-space) (u:ensure-list to)
      `(let* ((,from-binding ,(append from `(:illuminant ',illuminant)))
              (,to-binding (i:make-color ',to-model ,@(when to-space `(:space ',to-space))))
              (,expected-channels (make-array (length (c::channels ,from-binding))
                                              :element-type 'u:f64
                                              :initial-element 0d0)))
         (map-into ,expected-channels (lambda (x) (float x 1d0)) ',expected)
         (is (one-way ,from-binding ,to-binding)
             ,expected-channels
             :test (lambda (x y) (v3:= x y :rel 1d-14))
             (format nil "~{~a~^/~} -> ~{~a~^/~} (illuminant: ~a)"
                     (adjoin (u:make-keyword (type-of ,from-binding))
                             (list (c::space-name ,from-binding)))
                     (adjoin ',(u:make-keyword to-model)
                             (list (c::space-name ,to-binding)))
                     ',illuminant))))))

(defmacro define-test/one-way ((from-model &rest args) &body body)
  (let ((from `(,(u:format-symbol :c "~a" from-model) ,@args)))
    `(progn
       ,@(u:mappend
          (lambda (x)
            (destructuring-bind (to-model . expected-specs) x
              (destructuring-bind (to-model &optional to-space) (u:ensure-list to-model)
                (let* ((to-model (u:format-symbol :c "~a" to-model))
                       (to `(,to-model ,@(when to-space `((,@to-space))))))
                  (u:mappend
                   (lambda (y)
                     (destructuring-bind (illuminant expected) y
                       `((test-one-way ,from ,to ,illuminant ,expected))))
                   expected-specs)))))
          body))))
