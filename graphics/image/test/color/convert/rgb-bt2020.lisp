(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (bt.2020)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.3788085526665987d0 0.6568010860107291d0 0.0389731737708227d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:xyz))
  (p:is color=
        (i:xyy 0.3525168542418656d0 0.6112149556108969d0 0.6568010860107291d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:xyy))
  (p:is color=
        (i:lab 84.8329817467053147d0 -66.6625244920945335d0 107.9392780056162735d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:lab))
  (p:is color=
        (i:lchab 84.8329817467053147d0 126.8652036928677376d0 121.6991806538143948d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:lchab))
  (p:is color=
        (i:luv 84.8329817467053147d0 -56.6832963059008748d0 113.5072317102631700d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:luv))
  (p:is color=
        (i:lchuv 84.8329817467053147d0 126.8735107523628329d0 116.5366476178675299d0)
        (i:convert-color
         (i:rgb 0.6341989171505094d0 0.9004444986238855d0 0.06889215813209582d0
                :space 'i:bt2020)
         'i:lchuv)))
