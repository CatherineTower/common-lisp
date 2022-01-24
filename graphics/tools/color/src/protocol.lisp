(in-package #:mfiano.graphics.tools.color)

(defgeneric decompose (color))

(defgeneric %canonicalize (color)
  (:method ((color color))
    (u:mvlet ((r g b a (canonicalize color)))
      (rgba16-pma r g b a))))

(defgeneric canonicalize (color))

(defgeneric convert (source target)
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
