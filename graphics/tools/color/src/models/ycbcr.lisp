(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass ycbcr (color)
  ((%y :accessor y
       :initarg :y)
   (%cb :accessor cb
        :initarg :cb)
   (%cr :accessor cr
        :initarg :cr)))

(defmethod initialize-instance :after ((instance ycbcr) &key)
  (with-slots (%bpc %y %cb %cr) instance
    (%check-bpc-values %bpc %y %cb %cr)))

(defmethod decompose ((color ycbcr))
  (values (y color) (cb color) (cr color)))

(defmethod convert ((source color) (target ycbcr))
  (let ((color (%rgb->ycbcr (canonicalize source))))
    (setf (y target) (y color)
          (cb target) (cb color)
          (cr target) (cr color))
    target))

;;; ycbcr8

(defclass ycbcr8 (ycbcr) ())

(defun ycbcr8 (&optional (y 0) (cb 0) (cr 0))
  (make-instance 'ycbcr8 :bpc 8 :y y :cb cb :cr cr))

(defmethod canonicalize-components ((color ycbcr8))
  (%canonicalize-ycbcr-components
   (* (y color) #x10101)
   (- (cb color) 128)
   (- (cr color) 128)))

;;; ycbcr16

(defclass ycbcr16 (ycbcr) ())

(defun ycbcr16 (&optional (y 0) (cb 0) (cr 0))
  (make-instance 'ycbcr16 :bpc 16 :y y :cb cb :cr cr))

(defmethod canonicalize-components ((color ycbcr16))
  (%canonicalize-ycbcr-components
   (* (truncate (y color) #x101) #x10101)
   (- (truncate (cb color) #x101) 128)
   (- (truncate (cr color) #x101) 128)))

;;;

(defun %canonicalize-ycbcr-components (y cb cr)
  (values (%clamp-ycbcr-channel (+ y (* cr 91881)))
          (%clamp-ycbcr-channel (- y (* cb 22554) (* cr 46802)))
          (%clamp-ycbcr-channel (+ y (* cb 116130)))
          #xffff))

(defun %clamp-ycbcr-channel (value)
  (if (logtest value #xff000000)
      (logand (lognot (ash value -31)) #xffff)
      (ash value -8)))

(defun %rgb->ycbcr (rgb)
  (let* ((rgb (ash rgb -8))
         (r (r rgb))
         (g (g rgb))
         (b (b rgb))
         (y (ash (+ (* r 19595) (* g 38470) (* b 7471) #x8000) -16))
         (cb (+ (- (* r -11056) (* g 21712)) (* b 32768) #x808000))
         (cr (+ (- (* r 32768) (* g 27440) (* b 5328)) #x808000)))
    (if (logtest #xff000000 cb)
        (setf cb (%wrap (lognot (ash cb -31)) 8))
        (setf cb (%wrap (ash cb -16) 8)))
    (if (logtest #xff000000 cr)
        (setf cr (%wrap (lognot (ash cr -31)) 8))
        (setf cr (%wrap (ash cr -16) 8)))
    (ycbcr8 y cb cr)))
