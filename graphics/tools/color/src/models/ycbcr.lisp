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

(declaim (inline %ycbcr))
(defun %ycbcr (y cb cr &key bpc)
  (%check-bpc-values bpc y cb cr)
  (make-instance 'ycbcr :y y :cb cb :cr cr))

(defun ycbcr8 (&optional (y 0) (cb 0) (cr 0))
  (%ycbcr y cb cr :bpc 8))

;; TODO: Maybe add YCBCR16

(defmethod decompose ((color ycbcr))
  (values (y color) (cb color) (cr color)))

(defun %rgb->ycbcr (rgb)
  (let* ((rgb (%shift rgb -8))
         (r (r rgb))
         (g (g rgb))
         (b (b rgb))
         (y (ash (+ (* r 19595) (* g 38470) (* b 7471) #x8000) -16))
         (cb (+ (- (* r -11056) (* g 21712)) (* b 32768) #x808000))
         (cr (+ (- (* r 32768) (* g 27440) (* b 5328)) #x808000)))
    (if (not (logtest #xff000000 cb))
        (setf cb (%wrap (%shift cb -16) 8))
        (setf cb (%wrap (lognot (%shift cb -31)) 8)))
    (if (not (logtest #xff000000 cr))
        (setf cr (%wrap (%shift cr -16) 8))
        (setf cr (%wrap (lognot (%shift cr -31)) 8)))
    (ycbcr8 y cb cr)))

(defmethod canonicalize ((color ycbcr))
  (flet ((clamp (value)
           (if (logtest value #xff000000)
               (setf value (logand (lognot (ash value -31)) #xffff))
               (setf value (ash value -8)))))
    (let ((y (* (y color) #x10101))
          (cb (- (cb color) 128))
          (cr (- (cr color) 128)))
      (rgba16-pma (clamp (+ y (* cr 91881)))
                  (clamp (- y (* cb 22554) (* cr 46802)))
                  (clamp (+ y (* cb 116130)))))))

(defmethod convert ((source color) (target ycbcr))
  (let ((color (%rgb->ycbcr (canonicalize source))))
    (setf (y target) (y color)
          (cb target) (cb color)
          (cr target) (cr color))
    target))
