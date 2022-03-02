(in-package #:%mfiano.graphics.image.base)

(defclass context ()
  ((%color-models
    :type list
    :accessor color-models
    :initform nil)
   (%color-spaces
    :type list
    :accessor color-spaces
    :initform nil)
   (%color-space-data
    :type hash-table
    :reader color-space-data
    :initform (u:dict #'eq))
   (%color-space-graph
    :type graph:digraph
    :reader color-space-graph
    :initform (make-instance 'graph:digraph))
   (%cone-responses
    :type hash-table
    :reader cone-responses
    :initform (u:dict #'eq))
   (%illuminants
    :type hash-table
    :reader illuminants
    :initform (u:dict #'eq))))

(u:define-printer (context stream :type nil :identity t)
  (format stream "CONTEXT"))

(defun make-context ()
  (make-instance 'context))

(defvar *context* (make-context))
