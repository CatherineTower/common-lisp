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

(defmethod canonicalize ((color rgba8))
  (with-channels ((r g b a) color)
    (combine-values
      (-> (_ (r g b)) (truncate (* _ a #x101) #xff))
      (* a #x101))))

(defmethod convert ((source color) (target (eql 'rgba8)))
  (with-channels ((r g b a) (%canonicalize source))
    (cond
      ((zerop a)
       (rgba8 0 0 0 0))
      ((= a #xffff)
       (compose (rgba8)
         (-> (_ (r g b)) (ash _ -8))
         (ash a -16)))
      (t
       (compose (rgba8)
         (-> (_ (r g b)) (ash (truncate (* _ #xffff) a) -8))
         a)))))

;;; rgba16

(defclass rgba16 (rgba) ())

(defun rgba16 (&optional (r 0) (g 0) (b 0) (a #xffff))
  (make-instance 'rgba16 :bpc 16 :r r :g g :b b :a a))

(defmethod canonicalize ((color rgba16))
  (with-channels ((r g b a) color)
    (combine-values
      (-> (_ (r g b)) (truncate (* _ a) #xffff))
      a)))

(defmethod convert ((source color) (target (eql 'rgba16)))
  (with-channels ((r g b a) (%canonicalize source))
    (cond
      ((zerop a)
       (rgba16 0 0 0 0))
      ((= a #xffff)
       (compose (rgba16)
         (-> (_ (r g b)) (ash _ -8))
         (ash a -16)))
      (t
       (compose (rgba16)
         (-> (_ (r g b)) (ash (truncate (* _ #xffff) a) -8))
         a)))))

;;; rgba8-pma

(defclass rgba8-pma (rgba) ())

(defun rgba8-pma (&optional (r 0) (g 0) (b 0) (a #xff))
  (make-instance 'rgba8-pma :bpc 8 :pma t :r r :g g :b b :a a))

(defmethod canonicalize ((color rgba8-pma))
  (with-channels ((r g b a) color)
    (-> (_ (r g b a)) (* _ #x101))))

(defmethod convert ((source color) (target (eql 'rgba8-pma)))
  (with-channels ((r g b a) (%canonicalize source))
    (compose (rgba8)
      (-> (_ (r g b a)) (ash _ -8)))))

;;; rgba16-pma

(defclass rgba16-pma (rgba) ())

(defun rgba16-pma (&optional (r 0) (g 0) (b 0) (a #xffff))
  (make-instance 'rgba16-pma :bpc 16 :pma t :r r :g g :b b :a a))

(defmethod canonicalize ((color rgba16-pma))
  (decompose color))

(defmethod convert ((source color) (target (eql 'rgba16-pma)))
  (%canonicalize source))
