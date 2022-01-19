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

(defun cmyk (c m y k &key (bpc 8))
  (make-instance 'cmyk :bpc bpc :c c :m m :y y :k k))

(defmethod decompose ((color cmyk))
  (values (c color) (m color) (y color) (k color)))

(defun %rgb->cmyk (rgb)
  (let* ((r (%shift (r rgb) -8))
         (g (%shift (g rgb) -8))
         (b (%shift (b rgb) -8))
         (w (max r g b)))
    (if (zerop w)
        (cmyk 0 0 0 #xff)
        (cmyk (truncate (* (- w r) #xff) w)
              (truncate (* (- w g) #xff) w)
              (truncate (* (- w b) #xff) w)
              (- #xff w)))))

(defmethod canonicalize ((source cmyk))
  (u:mvlet* ((c m y k (decompose source))
             (w (- #xffff (%or-shift-8bpc source k 8))))
    (rgba16pma (truncate (* (- #xffff (%or-shift-8bpc source c 8)) w) #xffff)
               (truncate (* (- #xffff (%or-shift-8bpc source m 8)) w) #xffff)
               (truncate (* (- #xffff (%or-shift-8bpc source y 8)) w) #xffff))))

;; TODO: Encode %rgb->cmyk into this function.
(defmethod convert ((source color) (target cmyk))
  (let ((color (%rgb->cmyk (canonicalize source))))
    (setf (c target) (c color)
          (m target) (m color)
          (y target) (y color)
          (k target) (k color))
    target))
