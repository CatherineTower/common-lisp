(in-package #:%mfiano.graphics.image.color)

;; From HSL

(defmethod convert-color ((from hsl) (to hsl))
  (with-pool-color (rgb1 'rgb :space (space-name from))
    (with-pool-color (rgb2 'rgb :space (space-name to))
      (%convert-color from rgb1)
      (%convert-color to rgb2)
      (convert-color rgb1 rgb2)
      (%convert-color rgb2 to))))

(defmethod convert-color ((from hsl) (to hsv))
  (with-convert (from to)
    (hsl rgb hsv)))

(defmethod convert-color ((from hsl) (to lab))
  (with-convert (from to)
    (hsl rgb xyz lab)))

(defmethod convert-color ((from hsl) (to lchab))
  (with-convert (from to)
    (hsl rgb xyz lab lchab)))

(defmethod convert-color ((from hsl) (to lchuv))
  (with-convert (from to)
    (hsl rgb xyz luv lchuv)))

(defmethod convert-color ((from hsl) (to luv))
  (with-convert (from to)
    (hsl rgb xyz luv)))

(defmethod convert-color ((from hsl) (to rgb))
  (with-pool-color (hsl 'hsl :space (space-name to))
    (convert-color from hsl)
    (%convert-color hsl to)))

(defmethod convert-color ((from hsl) (to xyy))
  (with-convert (from to)
    (hsl rgb xyz xyy)))

(defmethod convert-color ((from hsl) (to xyz))
  (with-convert (from to)
    (hsl rgb xyz)))

;;; From HSV

(defmethod convert-color ((from hsv) (to hsl))
  (with-convert (from to)
    (hsv rgb hsl)))

(defmethod convert-color ((from hsv) (to hsv))
  (with-pool-color (rgb1 'rgb :space (space-name from))
    (with-pool-color (rgb2 'rgb :space (space-name to))
      (%convert-color from rgb1)
      (%convert-color to rgb2)
      (convert-color rgb1 rgb2)
      (%convert-color rgb2 to))))

(defmethod convert-color ((from hsv) (to lab))
  (with-convert (from to)
    (hsv rgb xyz lab)))

(defmethod convert-color ((from hsv) (to lchab))
  (with-convert (from to)
    (hsv rgb xyz lab lchab)))

(defmethod convert-color ((from hsv) (to lchuv))
  (with-convert (from to)
    (hsv rgb xyz luv lchuv)))

(defmethod convert-color ((from hsv) (to luv))
  (with-convert (from to)
    (hsv rgb xyz luv)))

(defmethod convert-color ((from hsv) (to rgb))
  (with-pool-color (hsv 'hsv :space (space-name to))
    (convert-color from hsv)
    (%convert-color hsv to)))

(defmethod convert-color ((from hsv) (to xyy))
  (with-convert (from to)
    (hsv rgb xyz xyy)))

(defmethod convert-color ((from hsv) (to xyz))
  (with-convert (from to)
    (hsv rgb xyz)))

;;; From Lab

(defmethod convert-color ((from lab) (to hsl))
  (with-convert (from to)
    (lab xyz rgb hsl)))

(defmethod convert-color ((from lab) (to hsv))
  (with-convert (from to)
    (lab xyz rgb hsv)))

(defmethod convert-color ((from lab) (to lchuv))
  (with-convert (from to)
    (lab xyz luv lchuv)))

(defmethod convert-color ((from lab) (to luv))
  (with-convert (from to)
    (lab xyz luv)))

(defmethod convert-color ((from lab) (to rgb))
  (with-convert (from to)
    (lab xyz rgb)))

(defmethod convert-color ((from lab) (to xyy))
  (with-convert (from to)
    (lab xyz xyy)))

;;; From LCHab

(defmethod convert-color ((from lchab) (to hsl))
  (with-convert (from to)
    (lchab lab xyz rgb hsl)))

(defmethod convert-color ((from lchab) (to hsv))
  (with-convert (from to)
    (lchab lab xyz rgb hsv)))

(defmethod convert-color ((from lchab) (to lchuv))
  (with-convert (from to)
    (lchab lab xyz luv lchuv)))

(defmethod convert-color ((from lchab) (to luv))
  (with-convert (from to)
    (lchab lab xyz luv)))

(defmethod convert-color ((from lchab) (to rgb))
  (with-convert (from to)
    (lchab lab xyz rgb)))

(defmethod convert-color ((from lchab) (to xyy))
  (with-convert (from to)
    (lchab lab xyz xyy)))

(defmethod convert-color ((from lchab) (to xyz))
  (with-convert (from to)
    (lchab lab xyz)))

;;; From LCHuv

(defmethod convert-color ((from lchuv) (to hsl))
  (with-convert (from to)
    (lchuv luv xyz rgb hsl)))

(defmethod convert-color ((from lchuv) (to hsv))
  (with-convert (from to)
    (lchuv luv xyz rgb hsv)))

(defmethod convert-color ((from lchuv) (to lab))
  (with-convert (from to)
    (lchuv luv xyz lab)))

(defmethod convert-color ((from lchuv) (to lchab))
  (with-convert (from to)
    (lchuv luv xyz lab lchab)))

(defmethod convert-color ((from lchuv) (to rgb))
  (with-convert (from to)
    (lchuv luv xyz rgb)))

(defmethod convert-color ((from lchuv) (to xyy))
  (with-convert (from to)
    (lchuv luv xyz xyy)))

(defmethod convert-color ((from lchuv) (to xyz))
  (with-convert (from to)
    (lchuv luv xyz)))

;;; From Luv

(defmethod convert-color ((from luv) (to hsl))
  (with-convert (from to)
    (luv xyz rgb hsl)))

(defmethod convert-color ((from luv) (to hsv))
  (with-convert (from to)
    (luv xyz rgb hsv)))

(defmethod convert-color ((from luv) (to lab))
  (with-convert (from to)
    (luv xyz lab)))

(defmethod convert-color ((from luv) (to lchab))
  (with-convert (from to)
    (luv xyz lab lchab)))

(defmethod convert-color ((from luv) (to rgb))
  (with-convert (from to)
    (luv xyz rgb)))

(defmethod convert-color ((from luv) (to xyy))
  (with-convert (from to)
    (luv xyz xyy)))

;;; From RGB/RGBA

(defmethod convert-color ((from rgb) (to hsl))
  (with-pool-color (rgb 'rgb :space (space-name to))
    (convert-color from rgb)
    (%convert-color rgb to)))

(defmethod convert-color ((from rgb) (to hsv))
  (with-pool-color (rgb 'rgb :space (space-name to))
    (convert-color from rgb)
    (%convert-color rgb to)))

(defmethod convert-color ((from rgb) (to lab))
  (with-convert (from to)
    (rgb xyz lab)))

(defmethod convert-color ((from rgb) (to lchab))
  (with-convert (from to)
    (rgb xyz lab lchab)))

(defmethod convert-color ((from rgb) (to lchuv))
  (with-convert (from to)
    (rgb xyz luv lchuv)))

(defmethod convert-color ((from rgb) (to luv))
  (with-convert (from to)
    (rgb xyz luv)))

(defmethod convert-color ((from rgb) (to rgb))
  (with-pool-color (xyz 'xyz)
    (%convert-color from xyz)
    (%convert-color xyz to)))

(defmethod convert-color ((from rgb) (to xyy))
  (with-convert (from to)
    (rgb xyz xyy)))

;;; From xyY

(defmethod convert-color ((from xyy) (to hsl))
  (with-convert (from to)
    (xyy xyz rgb hsl)))

(defmethod convert-color ((from xyy) (to hsv))
  (with-convert (from to)
    (xyy xyz rgb hsv)))

(defmethod convert-color ((from xyy) (to lab))
  (with-convert (from to)
    (xyy xyz lab)))

(defmethod convert-color ((from xyy) (to lchab))
  (with-convert (from to)
    (xyy xyz lab lchab)))

(defmethod convert-color ((from xyy) (to lchuv))
  (with-convert (from to)
    (xyy xyz luv lchuv)))

(defmethod convert-color ((from xyy) (to luv))
  (with-convert (from to)
    (xyy xyz luv)))

(defmethod convert-color ((from xyy) (to rgb))
  (with-convert (from to)
    (xyy xyz rgb)))

;;; From XYZ

(defmethod convert-color ((from xyz) (to hsl))
  (with-convert (from to)
    (xyz rgb hsl)))

(defmethod convert-color ((from xyz) (to hsv))
  (with-convert (from to)
    (xyz rgb hsv)))

(defmethod convert-color ((from xyz) (to lchab))
  (with-convert (from to)
    (xyz lab lchab)))

(defmethod convert-color ((from xyz) (to lchuv))
  (with-convert (from to)
    (xyz luv lchuv)))
