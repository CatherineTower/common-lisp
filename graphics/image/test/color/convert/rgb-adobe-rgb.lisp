(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Adobe RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2525439766564273d0 0.5964320958261923d0 0.0753622386175564d0)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.2732159574299605d0 0.6452530298309288d0 0.5964320958261923d0)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 81.64387167019585d0 -99.43189896636085d0 86.23725225796892d0)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 81.64387167019585d0 131.61901917679359d0 139.06491190370332d0)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 81.64387167019585d0 -96.21349096356381d0 107.40891719432494d0)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:luv))
  (p:is color=
        (i:rgb 81.64387167019585d0 144.20024735156707d0 131.85297167458134d0
               :space 'i:adobe-rgb)
        (i:convert-color
         (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                :space 'i:adobe-rgb)
         'i:lchuv)))
