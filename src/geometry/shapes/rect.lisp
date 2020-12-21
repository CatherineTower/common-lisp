(in-package #:cl-user)

;;;; A 2D axis-aligned rectangle primitive. A rectangle can be represented a
;;;; number of different ways. This package allows constructing a rect from
;;;; two different representations: an origin and size with RECT, and a minimum
;;;; and maximum point with RECT-FROM-MIN/MAX.

(defpackage #:net.mfiano.lisp.origin.geometry.rect
  (:local-nicknames
   (#:point2d #:net.mfiano.lisp.origin.geometry.point2d)
   (#:u #:net.mfiano.lisp.golden-utils)
   (#:v2 #:net.mfiano.lisp.origin.vec2))
  (:use #:cl)
  (:shadow
   #:max
   #:min)
  (:export
   #:max
   #:min
   #:origin
   #:rect
   #:rect-from-min/max
   #:rect-p
   #:size))

(in-package #:net.mfiano.lisp.origin.geometry.rect)

(declaim (inline %rect))
(defstruct (rect
            (:copier nil)
            (:constructor %rect)
            (:conc-name nil))
  (origin (point2d:point) :type point2d:point)
  (size (v2:vec 1) :type v2:vec))

(u:fn-> rect (&key (:origin point2d:point) (:size v2:vec)) rect)
(declaim (inline rect))
(defun rect (&key (origin (point2d:point)) (size (v2:vec 1)))
  "Construct a rect whose bottom-left corner is origined at ORIGIN, extending
to SIZE units."
  (declare (optimize speed))
  (%rect :origin origin :size size))

(u:fn-> rect-from-min/max (&key (:min point2d:point) (:max point2d:point)) rect)
(declaim (inline rect-from-min/max))
(defun rect-from-min/max (&key
                            (min (point2d:point -0.5))
                            (max (point2d:point 0.5)))
  "Construct a rect from a MINIMUM and MAXIMUM points. These correspond to the
bottom-left corner and upper-right corner of the resulting rectangle,
respectively."
  (declare (optimize speed))
  (%rect :origin min :size (v2:- max min)))

(u:fn-> min (rect) point2d:point)
(declaim (inline min))
(defun min (rect)
  "Return the minimum point of a rect."
  (declare (optimize speed))
  (let ((origin (origin rect)))
    (v2:min origin (v2:+ origin (size rect)))))

(u:fn-> max (rect) point2d:point)
(declaim (inline max))
(defun max (rect)
  "Return the maximum point of a rect."
  (declare (optimize speed))
  (let ((origin (origin rect)))
    (v2:max origin (v2:+ origin (size rect)))))

(u:fn-> vertices (rect) vector)
(declaim (inline vertices))
(defun vertices (rect)
  "Get a list of a rect's vertices."
  (declare (optimize speed))
  (v2:with-components ((min- (min rect))
                       (max- (max rect)))
    (vector min-
            max-
            (v2:vec min-x max-y)
            (v2:vec max-x min-y))))

(u:fn-> interval (rect v2:vec) v2:vec)
(defun interval (rect axis)
  "Get the interval of the rect along the given AXIS. This is used to test if
two intervals overlap in a separating axis theorem test. AXIS is expected to be
normalized."
  (declare (optimize speed))
  (let ((vertices (vertices rect)))
    (v2:with-components ((r (v2:vec (v2:dot axis (aref vertices 0)))))
      (map nil
           (lambda (x)
             (let ((projection (v2:dot axis x)))
               (setf rx (u:clamp rx rx projection)
                     ry (u:clamp ry projection ry))))
           vertices)
      r)))
