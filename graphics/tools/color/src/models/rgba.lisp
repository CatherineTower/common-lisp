(in-package #:mfiano.graphics.tools.color)

(defclass rgba (rgb alpha)
  ((%pma :reader pma
         :initarg :pma
         :initform nil)))

(declaim (inline %rgba))
(defun %rgba (r g b a &key bpc pma)
  (%check-bpc-values bpc r g b a)
  (make-instance 'rgba :bpc bpc :pma pma :r r :g g :b b :a a))

(defun rgba8 (&optional (r 0) (g 0) (b 0) (a #xff))
  (%rgba r g b a :bpc 8))

(defun rgba16 (&optional (r 0) (g 0) (b 0) (a #xffff))
  (%rgba r g b a :bpc 16))

(defun rgba8-pma (&optional (r 0) (g 0) (b 0) (a #xff))
  (%rgba r g b a :bpc 8 :pma t))

(defun rgba16-pma (&optional (r 0) (g 0) (b 0) (a #xffff))
  (%rgba r g b a :bpc 16 :pma t))

(defmethod decompose ((color rgba))
  (values (r color) (g color) (b color) (a color)))

(defmethod canonicalize ((source rgba))
  (u:mvlet* ((r g b a (decompose source))
             (r (%or-shift r 8))
             (g (%or-shift g 8))
             (b (%or-shift b 8)))
    (unless (pma source)
      (let ((bound (1- (expt 2 (bpc source)))))
        (setf r (truncate (* r a) bound)
              g (truncate (* g a) bound)
              b (truncate (* b a) bound))))
    (rgba16-pma r g b (%or-shift-8bpc source a 8))))

(defmethod convert ((source color) (target rgba))
  (u:mvlet* ((color (canonicalize source))
             (r g b a (decompose color)))
    (cond
      ((pma target)
       (setf (r color) (%or-shift-8bpc target r -8)
             (g color) (%or-shift-8bpc target g -8)
             (b color) (%or-shift-8bpc target b -8)
             (a color) (%or-shift-8bpc target a -8)))
      ((zerop a)
       (setf (r color) 0
             (g color) 0
             (b color) 0
             (a color) 0))
      ((= a #xffff)
       (setf (r target) (%shift r -8)
             (g target) (%shift g -8)
             (b target) (%shift b -8)
             (a target) (%shift a -16)))
      (t
       (let ((bpc (bpc target)))
         (setf (r color) (%wrap (%or-shift-8bpc target (truncate (* r #xffff) a) -8) bpc)
               (g color) (%wrap (%or-shift-8bpc target (truncate (* g #xffff) a) -8) bpc)
               (b color) (%wrap (%or-shift-8bpc target (truncate (* b #xffff) a) -8) bpc)))))
    target))
