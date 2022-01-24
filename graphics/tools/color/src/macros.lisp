(in-package #:mfiano.graphics.tools.color)

(defmacro with-channels ((channels color) &body body)
  `(u:mvlet ((,@channels (decompose ,color)))
     ,@body))

(defmacro compose ((func-name) &body body)
  `(multiple-value-call #',func-name ,@body))

(defmacro combine-values (&body body)
  `(compose (values) ,@body))

(defmacro -> ((placeholder channels) &body body)
  `(values ,@(mapcar (lambda (x) `(symbol-macrolet ((,placeholder ,x)) ,@body))
                     channels)))

(defmacro ->! ((placeholder channels) &body body)
  `(progn
     (multiple-value-setq ,channels
       (-> (,placeholder ,channels) ,@body))
     (values ,@channels)))
