(in-package #:cl-user)

;;; Internal interface

(defpackage #:%mfiano.graphics.tools.image.internal.base
  (:local-nicknames
   (#:lp #:lparallel)
   (#:m #:mfiano.math.gfxmath)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; Context
  (:export
   #:*context*
   #:*default-context*
   #:chromatic-adaptation-transforms
   #:color-spaces
   #:cone-responses
   #:context
   #:has-mixin-p
   #:illuminants
   #:make-context
   #:mix
   #:rgb-transforms
   #:unmix
   #:with-context)
  ;; Conditions
  (:export
   #:color-error
   #:final-mixin-removed
   #:mixin-error
   #:mixin-not-present)
  ;; Protocol
  (:export
   #:convert))

(in-package #:%mfiano.graphics.tools.image.internal.base)

;;; Convenience macro for package inheritance.

(defmacro define-package (package &body options)
  `(defpackage ,package
     ,@(remove :inherit-from options :key #'car)
     ,@(u:mappend
        (lambda (x)
          (destructuring-bind (from . symbols) (rest x)
            `((:shadowing-import-from ,from ,@symbols)
              (:export ,@symbols))))
        (remove :inherit-from options :key #'car :test (complement #'eq)))))

;;; Public interface

(define-package #:mfiano.graphics.tools.image.base
  (:use #:cl)
  (:inherit-from
   #:%mfiano.graphics.tools.image.internal.base
   ;; Context
   #:context
   #:make-context
   #:with-context
   ;; Conditions
   #:color-error
   #:final-mixin-removed
   #:mixin-error
   #:mixin-not-present
   ;; Protocol
   #:convert))
