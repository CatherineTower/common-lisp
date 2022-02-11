(in-package #:mfiano.graphics.tools.image.color)

;;; A mixin class that is added to all models with an alpha channel.

(defclass alpha ()
  ((%alpha-index
    :type (integer 0 3)
    :reader alpha-index
    :initarg :alpha-index)
   (%pre-multiply-alpha
    :type boolean
    :reader pre-multiply-alpha-p
    :initarg :pre-multiply-alpha)))

;;; This is called when the ALPHA class is mixed into an instance that already has one of the
;;; COLOR-STORAGE classes mixed in. It modifies the color's storage to multiply every non-alpha
;;; component by the alpha component, if PRE-MULTIPLY-ALPHA is non-NIL.
(defmethod update-instance-for-different-class :after ((previous color-storage) (current alpha)
                                                       &key alpha-index pre-multiply-alpha)
  (when (and (not (b::has-mixin-p previous 'alpha))
             pre-multiply-alpha)
    (let ((data (data current)))
      (dotimes (i (length data))
        (unless (= i alpha-index)
          (setf (aref data i) (* (aref data i) (aref data alpha-index))))))))
