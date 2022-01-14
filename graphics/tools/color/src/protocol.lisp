(in-package #:mfiano.graphics.tools.color)

(defgeneric decompose (model))

(defgeneric convert (source target)
  (:method :around ((source model) target)
    ;; Skip the conversion if the source color is the same type as the target color.
    (if (or (eq source target)
            (eq (class-name (class-of source)) target))
        source
        (call-next-method))))

(defgeneric make-palette (type)
  (:method :around (type)
    (u:if-let ((colors (call-next-method)))
      (progn
        (unless (every #'model-p colors)
          (error "Palette must be a list of colors."))
        (%make-palette :colors (make-array (length colors) :initial-contents colors)))
      (error "Palette must have at least 1 color."))))
