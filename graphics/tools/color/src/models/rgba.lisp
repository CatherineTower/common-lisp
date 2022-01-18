(in-package #:mfiano.graphics.tools.color)

(defclass rgba (rgb alpha)
  ((%pma :reader pma
         :initarg :pma
         :initform nil)))

(defun rgba (r g b a &key (bpc 8) pma)
  (make-instance 'rgba :bpc bpc :pma pma :r r :g g :b b :a a))

(defmethod canonicalize ((color rgba))
  (let ((color (or-shift color 8))
        (bpc (bpc color)))
    (unless (pma color)
      (scale color (a color))
      (unscale color (if (= bpc 8) #xff #xffff)))
    (rgba (r color) (g color) (b color) (a color) :bpc 16 :pma t)))

(defmethod convert ((source color) (target rgba))
  (let* ((color (canonicalize source))
         (r (r color))
         (g (g color))
         (b (b color))
         (a (a color)))
    (if (pma target)
        (when (= (bpc target) 8)
          (shift target -8))
        (cond
          ((zerop a)
           (zero target))
          ((= a #xffff)
           (replace (shift color 8) target))
          (t
           (%shift color 16)
           (setf (r target) (truncate (- (r color) r) a)
                 (g target) (truncate (- (g color) g) a)
                 (b target) (truncate (- (b color) b) a)
                 (a target) a)))))
  target)
