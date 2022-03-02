(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ECI RGB v2)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.2344341010019042d0 0.2346344082677029d0 0.5082984979049704d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:xyz))
  (p:is color=
        (i:xyy 0.2398629166740734d0 0.2400678624767538d0 0.2346344082677029d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:xyy))
  (p:is color=
        (i:lab 55.5465267993102d0 3.6803258639943603d0 -46.814803026877485d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:lab))
  (p:is color=
        (i:lchab 55.5465267993102d0 46.95924382813807d0 274.49503843677337d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:lchab))
  (p:is color=
        (i:luv 55.5465267993102d0 -22.7598212930054d0 -63.57617195445309d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:luv))
  (p:is color=
        (i:lchuv 55.5465267993102d0 67.52732117944358d0 250.3029907003886d0)
        (i:convert-color
         (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                :space 'i:eci-rgb-v2)
         'i:lchuv)))
