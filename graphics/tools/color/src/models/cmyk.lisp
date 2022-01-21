(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass cmyk (color)
  ((%c :accessor c
       :initarg :c)
   (%m :accessor m
       :initarg :m)
   (%y :accessor y
       :initarg :y)
   (%k :accessor k
       :initarg :k)))

(defmethod initialize-instance :after ((instance cmyk) &key)
  (with-slots (%bpc %c %m %y %k) instance
    (%check-bpc-values %bpc %c %m %y %k)))

(defmethod decompose ((color cmyk))
  (values (c color) (m color) (y color) (k color)))

(defmethod canonicalize ((color cmyk))
  (u:mvlet ((r g b a (canonicalize-components color)))
    (rgba16-pma r g b a)))

;;; cmyk8

(defclass cmyk8 (cmyk) ())

(defun cmyk8 (&optional (c 0) (m 0) (y 0) (k #xff))
  (make-instance 'cmyk8 :bpc 8 :c c :m m :y y :k k))

(defmethod canonicalize-components ((color cmyk8))
  (let ((w (- #xffff (* (k color) #x101))))
    (values (truncate (* (- #xffff (* (c color) #x101)) w) #xffff)
            (truncate (* (- #xffff (* (m color) #x101)) w) #xffff)
            (truncate (* (- #xffff (* (y color) #x101)) w) #xffff)
            #xffff)))

;; TODO: Encode %rgb->cmyk into this function.
(defmethod convert ((source color) (target cmyk8))
  (let ((color (%rgb->cmyk (canonicalize source))))
    (setf (c target) (c color)
          (m target) (m color)
          (y target) (y color)
          (k target) (k color))
    target))

;;; cmyk16

(defclass cmyk16 (cmyk) ())

(defun cmyk16 (&optional (c 0) (m 0) (y 0) (k #xffff))
  (make-instance 'cmyk16 :bpc 16 :c c :m m :y y :k k))

(defmethod canonicalize-components ((color cmyk16))
  (let ((w (- #xffff (k color))))
    (values (truncate (* (- #xffff (c color)) w) #xffff)
            (truncate (* (- #xffff (m color)) w) #xffff)
            (truncate (* (- #xffff (y color)) w) #xffff)
            #xffff)))

(defmethod convert ((source color) (target cmyk16))
  (let ((color (%rgb->cmyk (canonicalize source))))
    (setf (c target) (c color)
          (m target) (m color)
          (y target) (y color)
          (k target) (k color))
    target))

;;;

;; TODO: Encode %rgb->cmyk into this function.
(defun %rgb->cmyk (rgb)
  (let* ((r (%shift (r rgb) -8))
         (g (%shift (g rgb) -8))
         (b (%shift (b rgb) -8))
         (w (max r g b)))
    (if (zerop w)
        (cmyk8)
        (cmyk8 (truncate (* (- w r) #xff) w)
               (truncate (* (- w g) #xff) w)
               (truncate (* (- w b) #xff) w)
               (- #xff w)))))

(defmethod convert ((source color) (target cmyk))
  (let ((color (%rgb->cmyk (canonicalize source))))
    (setf (c target) (c color)
          (m target) (m color)
          (y target) (y color)
          (k target) (k color))
    target))
