(in-package #:cl-user)

(defpackage #:origin.geometry.plane
  (:local-nicknames
   (#:point3d #:origin.geometry.point3d)
   (#:u #:mfiano-utils)
   (#:v3 #:origin.vec3))
  (:use #:cl)
  (:export
   #:distance
   #:normal
   #:plane
   #:plane-p))

(in-package #:origin.geometry.plane)

(declaim (inline %plane))
(defstruct (plane
            (:copier nil)
            (:constructor %plane)
            (:conc-name nil))
  (normal (v3:vec 0 1 0) :type v3:vec)
  (distance 0.0 :type u:f32))

(u:fn-> plane (&key (:normal v3:vec) (:distance u:f32)) plane)
(declaim (inline plane))
(defun plane (&key (normal (v3:vec 0 1 0)) (distance 0.0))
  (declare (optimize speed))
  (%plane :normal (v3:normalize normal) :distance distance))
