(in-package #:mfiano.graphics.tools.color)

;;; common

(defclass rgba (rgb alpha)
  ((%pma :reader pma
         :initarg :pma
         :initform nil)))

(defmethod decompose ((color rgba))
  (values (r color) (g color) (b color) (a color)))

;;; rgba8

(defclass rgba8 (rgba) ())

(defun rgba8 (&optional (r 0) (g 0) (b 0) (a #xff))
  (make-instance 'rgba8 :bpc 8 :r r :g g :b b :a a))

(defmethod canonicalize-components ((color rgba8))
  (let ((a (a color)))
    (values (truncate (* (r color) a #x101) #xff)
            (truncate (* (g color) a #x101) #xff)
            (truncate (* (b color) a #x101) #xff)
            (* a #x101))))

(defmethod convert ((source color) (target rgba8))
  (u:mvlet* ((color (canonicalize source))
             (r g b a (decompose color)))
    (cond
      ((zerop a)
       (setf (r color) 0
             (g color) 0
             (b color) 0
             (a color) 0))
      ((= a #xffff)
       (setf (r target) (ash r -8)
             (g target) (ash g -8)
             (b target) (ash b -8)
             (a target) (ash a -16)))
      (t
       (setf (r color) (ash (truncate (* r #xffff) a) -8)
             (g color) (ash (truncate (* g #xffff) a) -8)
             (b color) (ash (truncate (* b #xffff) a) -8))))
    target))

;;; rgba16

(defclass rgba16 (rgba) ())

(defun rgba16 (&optional (r 0) (g 0) (b 0) (a #xffff))
  (make-instance 'rgba16 :bpc 16 :r r :g g :b b :a a))

(defmethod canonicalize-components ((color rgba16))
  (let ((a (a color)))
    (values (truncate (* (r color) a) #xffff)
            (truncate (* (g color) a) #xffff)
            (truncate (* (b color) a) #xffff)
            a)))

(defmethod convert ((source color) (target rgba16))
  (u:mvlet* ((color (canonicalize source))
             (r g b a (decompose color)))
    (cond
      ((zerop a)
       (setf (r color) 0
             (g color) 0
             (b color) 0
             (a color) 0))
      ((= a #xffff)
       (setf (r target) (ash r -8)
             (g target) (ash g -8)
             (b target) (ash b -8)
             (a target) (ash a -16)))
      (t
       (setf (r color) (ash (truncate (* r #xffff) a) -8)
             (g color) (ash (truncate (* g #xffff) a) -8)
             (b color) (ash (truncate (* b #xffff) a) -8))))
    target))

;;; rgba8-pma

(defclass rgba8-pma (rgba) ())

(defun rgba8-pma (&optional (r 0) (g 0) (b 0) (a #xff))
  (make-instance 'rgba8-pma :bpc 8 :pma t :r r :g g :b b :a a))

(defmethod canonicalize-components ((color rgba8-pma))
  (values (* (r color) #x101)
          (* (g color) #x101)
          (* (b color) #x101)
          (* (a color) #x101)))

(defmethod convert ((source color) (target rgba8-pma))
  (u:mvlet* ((color (canonicalize source))
             (r g b a (decompose color)))
    (cond
      ((pma target)
       (setf (r color) (ash r -8)
             (g color) (ash g -8)
             (b color) (ash b -8)
             (a color) (ash a -8))))
    target))

;;; rgba16-pma

(defclass rgba16-pma (rgba) ())

(defun rgba16-pma (&optional (r 0) (g 0) (b 0) (a #xffff))
  (make-instance 'rgba16-pma :bpc 16 :pma t :r r :g g :b b :a a))

(defmethod canonicalize-components ((color rgba16-pma))
  (decompose color))

(defmethod convert ((source color) (target rgba8-pma))
  (u:mvlet* ((color (canonicalize source))
             (r g b a (decompose color)))
    (cond
      ((pma target)
       (setf (r color) (ash r -8)
             (g color) (ash g -8)
             (b color) (ash b -8)
             (a color) (ash a -8))))
    target))
