(in-package #:mfiano.graphics.tools.image)

(u:define-constant +rgb->xyz+
    (m:mat/from-vecs (m:vec 0.4360747 0.2225045 0.0139322)
                     (m:vec 0.3850649 0.7168786 0.0971045)
                     (m:vec 0.1430804 0.0606169 0.7141733))
  :test #'m:=)

(u:define-constant +xyz->rgb+ (m:invert +rgb->xyz+) :test #'m:=)

(defclass xyz-image (image) ())

(defmethod color-type->image-type ((color-type (eql 'xyz)))
  'xyz-image)

(defmethod pixel-channel-count ((image xyz-image))
  3)

(defun xyz (x y z)
  (declare (ignore x y z)))
