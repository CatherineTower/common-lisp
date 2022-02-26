(in-package #:%mfiano.graphics.image.color)

;; From HSL

(defmethod base:convert ((from hsl) (to hsl))
  (with-pool-color (rgb1 'rgb :space (space-name from))
    (with-pool-color (rgb2 'rgb :space (space-name to))
      (hsl->rgb from rgb1)
      (hsl->rgb to rgb2)
      (base:convert rgb1 rgb2)
      (rgb->hsl rgb2 to))))

(defmethod base:convert ((from hsl) (to rgb))
  (with-pool-color (hsl 'hsl :space (space-name to))
    (base:convert from hsl)
    (hsl->rgb hsl to)))

;;; From XYZ

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

(defmethod base:convert ((from xyz) (to xyy))
  (xyz->xyy from to))

;;; From xyY

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

(defmethod base:convert ((from xyy) (to xyz))
  (xyy->xyz from to))

;;; From Lab

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

(defmethod base:convert ((from lab) (to xyy))
  (with-convert (from to)
    (lab xyz xyy)))

(defmethod base:convert ((from lab) (to xyz))
  (lab->xyz from to))

;;; From LCHab

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

(defmethod base:convert ((from lchab) (to xyy))
  (with-convert (from to)
    (lchab lab xyz xyy)))

(defmethod base:convert ((from lchab) (to xyz))
  (with-convert (from to)
    (lchab lab xyz)))

;;; From LCHuv

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

(defmethod base:convert ((from lchuv) (to xyy))
  (with-convert (from to)
    (lchuv luv xyz xyy)))

(defmethod base:convert ((from lchuv) (to xyz))
  (with-convert (from to)
    (lchuv luv xyz)))

;;; From Luv

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

(defmethod base:convert ((from luv) (to xyy))
  (with-convert (from to)
    (luv xyz xyy)))

(defmethod base:convert ((from luv) (to xyz))
  (luv->xyz from to))

;;; From RGB/RGBA

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

(defmethod base:convert ((from rgb) (to hsl))
  (with-pool-color (rgb 'rgb :space (space-name to))
    (base:convert from rgb)
    (rgb->hsl rgb to)))

(defmethod base:convert ((from rgb) (to xyy))
  (with-convert (from to)
    (rgb xyz xyy)))

(defmethod base:convert ((from rgb) (to xyz))
  (rgb->xyz from to))
