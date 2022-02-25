(in-package #:%mfiano.graphics.image.color)

;;; Macro helper

(defmacro with-convert ((from to) &body body)
  `(with-pool-colors (,@(butlast (rest (car body))))
     ,@(loop :with last := (first (last (car body)))
             :for (x y) :on (car body) :by #'cdr
             :for first := from :then nil
             :for op := (u:symbolicate x '#:-> y)
             :unless (or (eq x last) (eq y last))
               :collect `(,op ,(if first from x) ,y)
             :when (and y (eq y last))
               :collect `(,op ,x ,to))))

;;; From XYZ

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

(defmethod base:convert ((from xyz) (to lab))
  (xyz->lab from to))

(defmethod base:convert ((from xyz) (to lchab))
  (with-convert (from to)
    (xyz lab lchab)))

(defmethod base:convert ((from xyz) (to lchuv))
  (with-convert (from to)
    (xyz luv lchuv)))

(defmethod base:convert ((from xyz) (to luv))
  (xyz->luv from to))

(defmethod base:convert ((from xyz) (to rgb))
  (xyz->rgb from to))

;;; From xyY

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))

(defmethod base:convert ((from xyy) (to lab))
  (with-convert (from to)
    (xyy xyz lab)))

(defmethod base:convert ((from xyy) (to lchab))
  (with-convert (from to)
    (xyy xyz lab lchab)))

(defmethod base:convert ((from xyy) (to lchuv))
  (with-convert (from to)
    (xyy xyz luv lchuv)))

(defmethod base:convert ((from xyy) (to luv))
  (with-convert (from to)
    (xyy xyz luv)))

(defmethod base:convert ((from xyy) (to rgb))
  (with-convert (from to)
    (xyy xyz rgb)))

;;; From Lab

(defmethod base:convert ((from lab) (to xyz))
  (lab->xyz from to))

(defmethod base:convert ((from lab) (to xyy))
  (with-convert (from to)
    (lab xyz xyy)))

(defmethod base:convert ((from lab) (to lchab))
  (lab->lchab from to))

(defmethod base:convert ((from lab) (to lchuv))
  (with-convert (from to)
    (lab xyz luv lchuv)))

(defmethod base:convert ((from lab) (to luv))
  (with-convert (from to)
    (lab xyz luv)))

(defmethod base:convert ((from lab) (to rgb))
  (with-convert (from to)
    (lab xyz rgb)))

;;; From LCHab

(defmethod base:convert ((from lchab) (to xyz))
  (with-convert (from to)
    (lchab lab xyz)))

(defmethod base:convert ((from lchab) (to xyy))
  (with-convert (from to)
    (lchab lab xyz xyy)))

(defmethod base:convert ((from lchab) (to lab))
  (lchab->lab from to))

(defmethod base:convert ((from lchab) (to lchuv))
  (with-convert (from to)
    (lchab lab xyz luv lchuv)))

(defmethod base:convert ((from lchab) (to luv))
  (with-convert (from to)
    (lchab lab xyz luv)))

(defmethod base:convert ((from lchab) (to rgb))
  (with-convert (from to)
    (lchab lab xyz rgb)))

;;; From LCHuv

(defmethod base:convert ((from lchuv) (to xyz))
  (with-convert (from to)
    (lchuv luv xyz)))

(defmethod base:convert ((from lchuv) (to xyy))
  (with-convert (from to)
    (lchuv luv xyz xyy)))

(defmethod base:convert ((from lchuv) (to lab))
  (with-convert (from to)
    (lchuv luv xyz lab)))

(defmethod base:convert ((from lchuv) (to lchab))
  (with-convert (from to)
    (lchuv luv xyz lab lchab)))

(defmethod base:convert ((from lchuv) (to luv))
  (lchuv->luv from to))

(defmethod base:convert ((from lchuv) (to rgb))
  (with-convert (from to)
    (lchuv luv xyz rgb)))

;;; From Luv

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

(defmethod base:convert ((from luv) (to xyy))
  (with-convert (from to)
    (luv xyz xyy)))

(defmethod base:convert ((from luv) (to lab))
  (with-convert (from to)
    (luv xyz lab)))

(defmethod base:convert ((from luv) (to lchab))
  (with-convert (from to)
    (luv xyz lab lchab)))

(defmethod base:convert ((from luv) (to lchuv))
  (luv->lchuv from to))

(defmethod base:convert ((from luv) (to rgb))
  (with-convert (from to)
    (luv xyz rgb)))

;;; From RGB/RGBA

(defmethod base:convert ((from rgba) to)
  (with-pool-color (rgba 'rgba :space (space-name from) :copy from)
    (when (pre-multiplied-alpha-p from)
      (un-pre-multiply-alpha rgba))
    (call-next-method rgba to)))

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))

(defmethod base:convert ((from rgb) (to xyy))
  (with-convert (from to)
    (rgb xyz xyy)))

(defmethod base:convert ((from rgb) (to lab))
  (with-convert (from to)
    (rgb xyz lab)))

(defmethod base:convert ((from rgb) (to lchab))
  (with-convert (from to)
    (rgb xyz lab lchab)))

(defmethod base:convert ((from rgb) (to lchuv))
  (with-convert (from to)
    (rgb xyz luv lchuv)))

(defmethod base:convert ((from rgb) (to luv))
  (with-convert (from to)
    (rgb xyz luv)))

(defmethod base:convert ((from rgb) (to rgb))
  (with-pool-color (xyz 'xyz)
    (rgb->xyz from xyz)
    (xyz->rgb xyz to)))
