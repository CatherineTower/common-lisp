(in-package #:mfiano.graphics.tools.color)

(defclass ycbcr (color)
  ((%y :accessor y
       :initarg :y
       :initform 0)
   (%cb :accessor cb
        :initarg :cb
        :initform 0)
   (%cr :accessor cr
        :initarg :cr
        :initform 0)))

(defun ycbcr (y cb cr)
  (make-instance 'ycbcr :y y :cb cb :cr cr))

(defun %rgb->ycbcr (rgb)
  (let* ((rgb (%shift rgb -8))
         (r (r rgb))
         (g (g rgb))
         (b (b rgb))
         (y (ash (+ (* r 19595) (* g 38470) (* b 7471) #x8000) -16))
         (cb (+ (- (* r -11056) (* g 21712)) (* b 32768) #x808000))
         (cr (+ (- (* r 32768) (* g 27440) (* b 5328)) #x808000)))
    (if (not (logtest #xff000000 cb))
        (setf cb (ldb (byte 8 0) (ash cb -16)))
        (setf cb (ldb (byte 8 0) (lognot (ash cb -31)))))
    (if (not (logtest #xff000000 cr))
        (setf cr (ldb (byte 8 0) (ash cr -16)))
        (setf cr (ldb (byte 8 0) (lognot (ash cr -31)))))
    (ycbcr y cb cr)))

(defmethod canonicalize ((color ycbcr))
  (let* ((y (%or-shift  (y color) 16))
         (cb (- (cb color) 128))
         (cr (- (cr color) 128))
         (r (+ y (* cr 91881)))
         (g (- y (* cb 22554) (* cr 46802)))
         (b (+ y (* cb 116130))))
    (if (not (logtest #xff000000 r))
        (setf r (%shift r -8))
        (setf r (logand (lognot (ash r -31)) #xffff)))
    (if (not (logtest #xff000000 g))
        (setf g (%shift g -8))
        (setf g (logand (lognot (ash g -31)) #xffff)))
    (if (not (logtest #xff000000 b))
        (setf b (%shift b -8))
        (setf b (logand (lognot (ash b -31)) #xffff)))
    (rgba r g b #xffff :bpc 16 :pma t)))

(defmethod convert ((source color) (target ycbcr))
  (let ((color (%rgb->ycbcr (canonicalize source))))
    (setf (y target) (y color)
          (cb target) (cb color)
          (cr target) (cr color))
    target))
