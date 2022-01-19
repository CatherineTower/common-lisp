(in-package #:mfiano.graphics.tools.color)

(defclass color ()
  ((%bpc :reader bpc
         :initarg :bpc
         :initform 8)))

(defmethod initialize-instance :after ((color color) &key (bpc nil bpc-p))
  (when bpc-p
    (case bpc
      ((8 16))
      (t (error "Bits per channel must be 8 or 16.")))))

(defclass palette ()
  ((%colors :reader colors
            :type simple-vector
            :initarg :colors
            :initform #())))
