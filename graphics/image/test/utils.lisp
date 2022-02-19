(in-package #:mfiano.graphics.image.test)

(defun color (model &optional space)
  (i:default-color model :space (or space model)))

(defun compare-channels (result sequence string)
  (let ((channels (c::channels result)))
    (flet ((compare (expected test-func)
             (map-into expected (lambda (x) (float x 1d0)) sequence)
             (is channels expected string :test test-func))
           (cmp (func)
             (lambda (x y)
               (funcall func x y :abs 1d-4))))
      (etypecase channels
        (v2:vec (compare (v2:zero) (cmp #'v2:=)))
        (v3:vec (compare (v3:zero) (cmp #'v3:=)))
        (v4:vec (compare (v4:zero) (cmp #'v4:=)))))))

(defun convert (from-color to-color)
  (i:convert from-color to-color))

(defun convert/round-trip (from-color to-color)
  (let ((to-color (convert from-color to-color))
        (from-space (c::space-name from-color)))
    (i:convert to-color (i:default-color (type-of from-color) :space from-space))))

(defun test (from-color to-color expected)
  (let* ((from-model/space (remove-duplicates
                            (list (type-of from-color)
                                  (c::space-name from-color))))
         (to-model/space (remove-duplicates
                          (list (type-of to-color)
                                (c::space-name to-color))))
         (result (convert from-color to-color))
         (string (format nil "~{~a~^/~} -> ~{~a~^/~}"
                         from-model/space
                         to-model/space)))
    (compare-channels result expected string)))

(defun test/round-trip (from-color to-color expected)
  (let* ((from-model/space (remove-duplicates
                            (list (type-of from-color)
                                  (c::space-name from-color))))
         (to-model/space (remove-duplicates
                          (list (type-of to-color)
                                (c::space-name to-color))))
         (result (convert/round-trip from-color to-color))
         (string (format nil "~{~a~^/~} -> ~{~a~^/~} -> ~{~a~^/~}"
                         from-model/space
                         to-model/space
                         from-model/space)))
    (compare-channels result expected string)))
