(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (sRGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.4459474718435258d0 0.2807444148120802d0 0.0358581702754469d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.5848107514912254d0 0.3681652270041914d0 0.2807444148120802d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:xyy))
  (p:is color=
        (i:lab 59.95593209930084d0 61.133911920680404d0 66.85280383185929d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:lab))
  (p:is color=
        (i:lchab 59.95593209930084d0 90.59057658998849d0 47.55847298888456d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:lchab))
  (p:is color=
        (i:luv 59.95593209930084d0 137.60598472010605d0 48.29705364609488d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:luv))
  (p:is color=
        (i:lchuv 59.95593209930084d0 145.8355663810575d0 19.340092048763918d0)
        (i:convert-color
         (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                :space 'i:srgb)
         'i:lchuv)))
