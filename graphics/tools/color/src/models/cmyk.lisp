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

(defmethod canonicalize ((color cmyk8))
  (with-channels ((c m y k) color)
    (let ((w (- #xffff (* k #x101))))
      (combine-values
        (-> (_ (c m y)) (truncate (* (- #xffff (* _ #x101)) w) #xffff))
        #xffff))))

(defmethod convert ((source color) (target (eql 'cmyk8)))
  (with-channels ((r g b) (%canonicalize source))
    (->! (_ (r g b)) (ash _ -8))
    (let ((w (max r g b)))
      (if (zerop w)
          (cmyk8)
          (compose (cmyk8)
            (-> (_ (r g b)) (truncate (* (- w _) #xff) w))
            (- #xff w))))))

;;; cmyk16

(defclass cmyk16 (cmyk) ())

(defun cmyk16 (&optional (c 0) (m 0) (y 0) (k #xffff))
  (make-instance 'cmyk16 :bpc 16 :c c :m m :y y :k k))

(defmethod canonicalize ((color cmyk16))
  (with-channels ((c m y k) color)
    (let ((w (- #xffff k)))
      (combine-values
        (-> (_ (c m y)) (truncate (* (- #xffff _) w) #xffff))
        #xffff))))

(defmethod convert ((source color) (target (eql 'cmyk16)))
  (with-channels ((r g b) (%canonicalize source))
    (let ((w (max r g b)))
      (if (zerop w)
          (cmyk16)
          (compose (cmyk16)
            (-> (_ (r g b)) (truncate (* (- w _) #xffff) w))
            (- #xffff w))))))
