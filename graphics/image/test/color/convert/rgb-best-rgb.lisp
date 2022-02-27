(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Best RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2764290244005207d0 0.2106726291896849d0 0.0591884553847105d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.506011402840928d0 0.3856424008573041d0 0.2106726291896849d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 53.02303118387675d0 32.177895650678636d0 35.90708402257808d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 53.02303118387675d0 48.215512560901445d0 48.135103666497386d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 53.02303118387675d0 66.71542638055483d0 25.19652032043792d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 53.02303118387675d0 71.31488451506792d0 20.69012566226302d0)
        (i:convert-color
         (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                :space 'i:best-rgb)
         'i:lchuv)))
