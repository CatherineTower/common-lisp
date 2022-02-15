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

(defun test-sequential ()
  (img:with-context (*context*)
    (let* ((luv-default (img:default 'img:luv))
           (rgb-default (img:default 'img:rgb))
           (rgb (img:rgb 0.1 0.5 0.9)))
      (sb-ext:gc :full t)
      (time
       (dotimes (i (expt 10 4))
         (let ((luv (img:convert rgb luv-default)))
           (img:convert luv rgb-default)))))))

(defun test-parallel ()
  (progn
    (img:with-context (*context*)
      (let ((luv-default (img:default 'img:luv))
            (rgb-default (img:default 'img:rgb))
            (rgb (img:rgb 0.1 0.5 0.9)))
        (sb-ext:gc :full t)
        (time
         (lparallel:pdotimes (i (expt 10 4))
           (declare (ignorable i))
           (let ((luv (img:convert rgb luv-default)))
             (img:convert luv rgb-default))))))))
