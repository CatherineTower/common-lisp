(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (CIE RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.1149655022555951d0 0.0576037201157763d0 0.303681049267886d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.2413972423782203d0 0.120952624168599d0 0.0576037201157763d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 28.799671871572755d0 50.02085706299214d0 -57.191155342843345d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 28.799671871572755d0 75.97969722738786d0 311.1737781949945d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 28.799671871572755d0 12.272175295309388d0 -74.65081610041774d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 28.799671871572755d0 75.65282962941433d0 279.33560249718806d0)
        (i:convert-color
         (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                :space 'i:cie-rgb)
         'i:lchuv)))
