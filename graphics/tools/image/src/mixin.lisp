(in-package #:mfiano.graphics.tools.image)

(gv:define-global-var -mixins- (u:dict #'equal))

(defclass mixin-class (standard-class)
  ((%classes
    :reader classes
    :initarg :classes
    :initform nil)))

(defclass mixin () ())

(defmethod c2mop:validate-superclass ((class mixin-class) (superclass standard-class))
  t)

(u:define-printer (mixin stream :type nil :identity t)
  (format stream
          "MIXIN (~{~a~^, ~})"
          (mapcar #'class-name (cdr (c2mop:class-direct-superclasses (class-of mixin))))))

(u:define-printer (mixin-class stream :type nil :identity t)
  (format stream "MIXIN-CLASS (~{~s~^, ~})"
          (mapcar #'class-name (cdr (c2mop:class-direct-superclasses mixin-class)))))

(defun %find-mixin-class (class)
  (etypecase class
    (symbol (find-class class))
    (class class)))

(defun %find-mixin-class-names (class)
  (etypecase class
    (symbol class)
    (class (class-name class))))

(defun %make-mixin-class-list (classes)
  (mapcar #'%find-mixin-class (mapcar #'%find-mixin-class-names classes)))

(defun %make-mixin-class (classes)
  (let* ((superclasses (cons (find-class 'mixin) classes))
         (class (make-instance 'mixin-class
                               :classes classes
                               :direct-superclasses superclasses)))
    (setf (u:href -mixins- (mapcar #'class-name classes)) class)
    class))

(defun %ensure-mixin-class (classes)
  (if (cdr classes)
      (or (u:href -mixins- (mapcar #'class-name classes))
          (%make-mixin-class classes))
      (car classes)))

(defun add-mixin (instance class-name &rest args)
  (if (has-mixin-p instance class-name)
      instance
      (let ((class (%ensure-mixin-class
                    (%make-mixin-class-list
                     (typecase instance
                       (mixin (list* class-name (classes (class-of instance))))
                       (t (list class-name (class-of instance))))))))
        (apply #'change-class instance class :allow-other-keys t args))))

(defun remove-mixin (instance class-name)
  (cond
    ((typep instance 'mixin)
     (let ((class (%ensure-mixin-class
                   (%make-mixin-class-list
                    (remove (%find-mixin-class class-name)
                            (classes (%find-mixin-class (class-of instance))))))))
       (change-class instance class)))
    ((typep instance class-name)
     (error "Cannot remove the only class of a mixin."))
    (t (error "Mixin does not contain class ~s." class-name))))

(defun has-mixin-p (instance class-name)
  (and (find-class class-name nil)
       (typep instance class-name)))
