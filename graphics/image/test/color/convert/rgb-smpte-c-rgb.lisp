(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (SMPTE-C RGB)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.0823155282116541d0 0.0956155623166773d0 0.0610563915700192d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.3444344761864088d0 0.4000860692667099d0 0.0956155623166773d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 37.04374562703637d0 -7.416979461526169d0 14.90488896372768d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 37.04374562703637d0 16.64834224040797d0 116.45588273645843d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 37.04374562703637d0 -1.9810450557442587d0 18.27640628719308d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 37.04374562703637d0 18.383459040328606d0 96.18634182312512d0)
        (i:convert-color
         (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                :space 'i:smpte-c-rgb)
         'i:lchuv)))
