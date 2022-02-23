(in-package #:mfiano.graphics.image.test)

(defun compare-func (&key (rel 1d-10) (abs rel))
  (lambda (x y)
    (every
     (lambda (x y)
       (< (abs (- x y)) (max abs (* rel (max (abs x) (abs y))))))
     x y)))

(defun collect-result (result sequence)
  (let ((expected (make-array (length result) :element-type 'u:f64 :initial-element 0d0)))
    (map-into expected (lambda (x) (float x 1d0)) sequence)
    (cons result expected)))

(defun round-trip (from-color to-color)
  (let* ((to-color (i:convert from-color to-color))
         (from-space (c::space-name from-color))
         (out (i:make-color (type-of from-color) :space from-space)))
    (c::channels (i:convert to-color out))))

(defmacro test-round-trip (from to &key (count 100000) (min 0d0) (max 1d0))
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
                               (let ((pass (funcall (compare-func :rel 1d-4) (car x) (cdr x))))
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

(defmacro test-one-way (from to expected)
  (u:with-gensyms (to-binding expected-channels)
    (destructuring-bind (from-model &rest from-args) from
      (destructuring-bind (to-model &optional to-space) (u:ensure-list to)
        `(let* ((,to-binding (i:make-color ',to-model ,@(when to-space `(:space ',to-space))))
                (,expected-channels (make-array (length (c::channels ,from))
                                                :element-type 'u:f64
                                                :initial-element 0d0)))
           (map-into ,expected-channels (lambda (x) (float x 1d0)) ',expected)
           (is (c::channels (i:convert ,from ,to-binding))
               ,expected-channels
               :test (compare-func)
               ,(format nil "~{~a~^/~} -> ~{~a~^/~}"
                        (adjoin (u:make-keyword from-model) `(,@(cdr (member :space from-args))))
                        (adjoin (u:make-keyword to-model) `(,@(u:ensure-list to-space))))))))))

(defmacro define-tests/one-way ((from-model &rest args) &body body)
  (let ((from `(,(u:format-symbol :c "~a" from-model) ,@args)))
    `(progn
       ,@(u:mappend
          (lambda (x)
            (destructuring-bind (to-model expected) x
              (destructuring-bind (to-model &optional to-space) (u:ensure-list to-model)
                (let* ((to-model (u:format-symbol :c "~a" to-model))
                       (to `(,to-model ,@(when to-space `((,@to-space))))))
                  `((test-one-way ,from ,to ,expected))))))
          body))))

(defmacro define-tests/round-trip ((from-model &rest args) &body body)
  (let ((from `(,(u:format-symbol :c "~a" from-model) ,@args)))
    `(progn
       ,@(mapcar
          (lambda (x)
            (destructuring-bind (to-model &optional to-space) (u:ensure-list x)
              (let* ((to-model (u:format-symbol :c "~a" to-model))
                     (to `(,to-model ,@(when to-space `((,@to-space))))))
                `(test-round-trip ,from ,to))))
          body))))
