(in-package #:mfiano.graphics.tools.image)

(defclass rgba-image (image) ())

(defmethod color-type->image-type ((color-type (eql 'rgba)))
  'rgba-image)

(defmethod pixel-channel-count ((image rgba-image))
  4)

(defmethod alpha-channel-index ((image rgba-image))
  3)

;;;

(u:define-constant +transition-point/srgb+ 0.0404482362771082d0)
(u:define-constant +linear-gain/srgb+ 12.92)
(u:define-constant +linear-domain-threshold/srgb+ 0.00313066844250063d0)
(u:define-constant +offset/srgb+ 1.055d0)

(defun inverse-compand-srgb (in out)
  (flet ((process-channel (value)
           (if (<= value +transition-point/srgb+)
               (/ value +linear-gain/srgb+)
               (expt (/ (+ value #.(1- +offset/srgb+)) +offset/srgb+) 2.4))))
    (declare (inline process-channel))
    (m:with-vector ((3 i in)) ()
      (m:with-vector ((3 o out)) (:read-only nil)
        (setf ox (process-channel ix)
              oy (process-channel iy)
              oz (process-channel iz))))
    out))

(defun srgb->xyz (in out)
  (let ((o (inverse-compand-srgb in out)))
    (m:* +rgb->xyz+ o)))
