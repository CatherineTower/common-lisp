(in-package #:mfiano.graphics.tools.color)

(defgeneric zero (color)
  (:method ((color color))
    color))

(defgeneric replace (source target)
  (:method ((source color) (target color))
    target))

(defgeneric shift (color bit-count)
  (:method ((color color) (bit-count fixnum))
    color))

(defgeneric or-shift (color bit-count)
  (:method ((color color) (bit-count fixnum))
    color))

(defgeneric scale (color scalar)
  (:method ((color color) (scalar fixnum))
    color))

(defgeneric unscale (color scalar)
  (:method ((color color) (scalar fixnum))
    color))

(defgeneric canonicalize (color))

(defgeneric convert (source target)
  (:method ((source color) (target symbol))
    (convert source (make-instance target)))
  (:method :around ((source color) target)
    ;; Skip the conversion if the source color is the same type as the target color.
    (if (or (eq source target)
            (eq (class-name (class-of source)) target))
        source
        (call-next-method))))

(defgeneric make-palette (name)
  (:method (name)
    (error "No such palette: ~s." name))
  (:method :around (name)
    (u:if-let ((colors (call-next-method)))
      (progn
        (unless (every (lambda (x) (typep x 'color)) colors)
          (error "Palette must be a list of colors."))
        (make-instance 'palette :colors (make-array (length colors) :initial-contents colors)))
      (error "Palette must have at least 1 color."))))
