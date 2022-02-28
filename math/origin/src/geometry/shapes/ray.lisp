(in-package #:cl-user)

(defpackage #:mfiano.math.origin.geometry.ray
  (:local-nicknames
   (#:point3d #:mfiano.math.origin.geometry.point3d)
   (#:u #:mfiano.misc.utils)
   (#:v3 #:mfiano.math.origin.vec3))
  (:use #:cl)
  (:export
   #:direction
   #:origin
   #:ray
   #:ray-from-points))

(in-package #:mfiano.math.origin.geometry.ray)

(declaim (inline %ray))
(defstruct (ray
            (:predicate nil)
            (:copier nil)
            (:constructor %ray (origin direction))
            (:conc-name nil))
  (origin (point3d:point) :type point3d:point)
  (direction (v3:vec 0f0 0f0 1f0) :type v3:vec))

(u:fn-> ray (&key (:origin point3d:point) (:direction v3:vec)) ray)
(declaim (inline ray))
(defun ray (&key (origin (point3d:point)) (direction (v3:vec 0f0 0f0 1f0)))
  (declare (optimize speed))
  (%ray origin (v3:normalize direction)))

(u:fn-> ray-from-points (&key (:from point3d:point) (:to point3d:point)) ray)
(defun ray-from-points (&key (from (point3d:point)) (to (point3d:point)))
  (declare (optimize speed))
  (%ray from (v3:normalize (v3:- to from))))
