(in-package #:cl-user)

(uiop:define-package #:mfiano.graphics.tools.image.dev
  (:mix-reexport
   #:mfiano.graphics.tools.image.base
   #:mfiano.graphics.tools.image.color
   #:mfiano.graphics.tools.image)
  (:use #:cl))

(defpackage #:mfiano.graphics.tools.image.user
  (:local-nicknames
   (#:img #:mfiano.graphics.tools.image.dev))
  (:use #:cl))

(in-package #:mfiano.graphics.tools.image.user)

(defvar *context* (img:make-context))

(defmacro with-profile ((&optional (profile-type :none)) &body body)
  `(case ,profile-type
     (:deterministic
      (sb-profile:reset)
      (sb-profile:profile "MFIANO.MATH.GFXMATH"
                          "%MFIANO.GRAPHICS.TOOLS.IMAGE.INTERNAL.BASE"
                          "MFIANO.GRAPHICS.TOOLS.IMAGE.BASE"
                          "MFIANO.GRAPHICS.TOOLS.IMAGE.COLOR"
                          "MFIANO.GRAPHICS.TOOLS.IMAGE.DEV"
                          "MFIANO.GRAPHICS.TOOLS.IMAGE.USER"
                          "MFIANO.MISC.UTILS"
                          "LPARALLEL"
                          "CLOSER-MOP")
      ,@body
      (sb-profile:report)
      (sb-profile:unprofile)
      (sb-profile:reset))
     (:statistical
      (sb-sprof:with-profiling (:report :graph)
        ,@body))
     (:none
      (progn
        ,@body))))

(defun test-sequential (count &optional (profile-type :none))
  (img:with-context (*context*)
    (let* ((luv-default (img:default 'img:luv))
           (rgb-default (img:default 'img:rgb))
           (rgb (img:rgb 0.1 0.5 0.9)))
      (sb-ext:gc :full t)
      (time
       (with-profile (profile-type)
         (dotimes (i count)
           (let ((luv (img:convert rgb luv-default)))
             (img:convert luv rgb-default))))))))

(defun test-parallel (count &optional (profile-type :none))
  (progn
    (img:with-context (*context*)
      (let ((luv-default (img:default 'img:luv))
            (rgb-default (img:default 'img:rgb))
            (rgb (img:rgb 0.1 0.5 0.9)))
        (sb-ext:gc :full t)
        (time
         (with-profile (profile-type)
           (lparallel:pdotimes (i count)
             (declare (ignorable i))
             (let ((luv (img:convert rgb luv-default)))
               (img:convert luv rgb-default)))))))))
