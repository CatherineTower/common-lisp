(in-package #:mfiano.graphics.tools.color)

(declaim (inline %write-rgba))
(defun %write-rgba (data r g b a)
  (setf (aref data 0) r
        (aref data 1) g
        (aref data 2) b
        (aref data 3) a)
  (values))

(declaim (inline %decompose-rgba))
(defun %decompose-rgba (data)
  (values (aref data 0)
          (aref data 1)
          (aref data 2)
          (aref data 3)))

(declaim (inline %or-shift))
(defun %or-shift (value)
  (declare (u:ub8 value))
  (logior value (ash value 8)))

(defmacro %check-ub8 (&rest values)
  `(progn
     ,@(loop :for v :in values
             :collect `(check-type ,v u:ub8 "an 8-bit unsigned integer"))))

(defmacro %check-ub16 (&rest values)
  `(progn
     ,@(loop :for v :in values
             :collect `(check-type ,v u:ub16 "a 16-bit unsigned integer"))))
