(in-package #:cl-user)

;;;; A 2D circle primitive.

(defpackage #:mfiano.math.origin.geometry.circle
  (:local-nicknames
   (#:point2d #:mfiano.math.origin.geometry.point2d)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:circle
   #:circle-p
   #:origin
   #:radius))

(in-package #:mfiano.math.origin.geometry.circle)

(declaim (inline %circle))
(defstruct (circle
            (:copier nil)
            (:constructor %circle)
            (:conc-name nil))
  (origin (point2d:point) :type point2d:point)
  (radius 1f0 :type u:f32))

(u:fn-> circle (&key (:origin point2d:point) (:radius u:f32)) circle)
(declaim (inline circle))
(defun circle (&key (origin (point2d:point)) (radius 1f0))
  (declare (optimize speed))
  (%circle :origin origin :radius radius))
