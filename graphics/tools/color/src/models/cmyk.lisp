(in-package #:mfiano.graphics.tools.color)

(defclass cmyk (color)
  ((%c :accessor c
       :initarg :c
       :initform 0)
   (%m :accessor m
       :initarg :m
       :initform 0)
   (%y :accessor y
       :initarg :y
       :initform 0)
   (%k :accessor k
       :initarg :k
       :initform 0)))

(defun cmyk (c m y k)
  (make-instance 'cmyk :c c :m m :y y :k k))

(defun %rgb->cmyk (rgb)
  (let* ((rgb (shift rgb -8))
         (r (r rgb))
         (g (g rgb))
         (b (b rgb))
         (w (max r g b)))
    (if (zerop w)
        (cmyk 0 0 0 #xff)
        (cmyk (truncate (* (- w r) #xff) w)
              (truncate (* (- w g) #xff) w)
              (truncate (* (- w b) #xff) w)
              (- #xff w)))))

(defmethod canonicalize ((color cmyk))
  (or-shift color 8)
  (let ((w (- #xffff (%or-shift (k color) 8))))
    (rgba (truncate (* (- #xffff (c color)) w) #xffff)
          (truncate (* (- #xffff (m color)) w) #xffff)
          (truncate (* (- #xffff (y color)) w) #xffff)
          #xffff
          :bpc 16
          :pma t)))

(defmethod convert ((source color) (target cmyk))
  (let ((color (%rgb->cmyk (canonicalize source))))
    (setf (c target) (c color)
          (m target) (m color)
          (y target) (y color)
          (k target) (k color))
    target))
