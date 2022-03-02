(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (DCI-P3+)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.1903238767955199d0 0.2217914110186268d0 0.7317511687686392d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:xyz))
  (p:is color=
        (i:xyy 0.1663864480859925d0 0.1938962452673118d0 0.2217914110186268d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:xyy))
  (p:is color=
        (i:lab 54.2165624006329239d0 -4.1695699673716113d0 -61.9878838084014134d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:lab))
  (p:is color=
        (i:lchab 54.2165624006329239d0 62.1279570946661721d0 266.1518376809750066d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:lchab))
  (p:is color=
        (i:luv 54.2165624006329239d0 -40.5240187756801689d0 -91.8837442237113180d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:luv))
  (p:is color=
        (i:lchuv 54.2165624006329239d0 100.4231972718459218d0 246.2008044852906892d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                :space 'i:dci-p3+)
         'i:lchuv)))
