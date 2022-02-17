(in-package #:%mfiano.graphics.tools.image.base)

(define-condition mixin-error (error)
  ((%instance
    :reader instance
    :initarg :instance)
   (%class-name
    :reader %class-name
    :initarg :class-name)))

(define-condition final-mixin-removed (mixin-error) ()
  (:report
   (lambda (condition stream)
     (format stream "Cannot remove the only remaining class ~s of object:~%~%~s"
             (%class-name condition)
             (instance condition)))))

(define-condition mixin-not-present (mixin-error) ()
  (:report
   (lambda (condition stream)
     (format stream "Cannot remove mixin because object:~%~%~
                     ~s~%~%does not contain the mixin class ~s."
             (instance condition)
             (%class-name condition)))))
