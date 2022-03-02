(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (bt.709)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.3865168891084855d0 0.5953228934778385d0 0.6460771266792751d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:xyz))
  (p:is color=
        (i:xyy 0.2374303546505052d0 0.3656961175901822d0 0.5953228934778385d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:xyy))
  (p:is color=
        (i:lab 81.5833037125979104d0 -50.1761558266359273d0 0.1879655115843093d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:lab))
  (p:is color=
        (i:lchab 81.5833037125979104d0 50.1765078953527350d0 179.7853645829822256d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:lchab))
  (p:is color=
        (i:luv 81.5833037125979104d0 -64.1199689606252576d0 8.2002653687830911d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:luv))
  (p:is color=
        (i:lchuv 81.5833037125979104d0 64.6422058072743226d0 172.7120376528100394d0)
        (i:convert-color
         (i:rgb 0.06889215813209582d0 0.8774882563558897d0 0.7631170370188469d0
                :space 'i:bt709)
         'i:lchuv)))
