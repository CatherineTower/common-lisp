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

;;; cmyk8

(defclass cmyk8 (cmyk) ())

(defun cmyk8 (&optional (c 0) (m 0) (y 0) (k #xff))
  (make-instance 'cmyk8 :bpc 8 :c c :m m :y y :k k))

(defmethod canonicalize-channels ((color cmyk8))
  (with-channels ((c m y k) color)
    (let ((w (- #xffff (* k #x101))))
      (combine-values
        (-> (_ (c m y)) (truncate (* (- #xffff (* _ #x101)) w) #xffff))
        #xffff))))

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

(defmethod canonicalize-channels ((color cmyk16))
  (with-channels ((c m y k) color)
    (let ((w (- #xffff k)))
      (combine-values
        (-> (_ (c m y)) (truncate (* (- #xffff _) w) #xffff))
        #xffff))))

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
