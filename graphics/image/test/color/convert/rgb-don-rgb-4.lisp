(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Don RGB 4)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.6491232576965265d0 0.6923764072250577d0 0.0209305961534372d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.4764451262146348d0 0.50819218201946d0 0.6923764072250577d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 86.62159084835201d0 -4.118456894920075d0 118.17047712295827d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 86.62159084835201d0 118.24222321431088d0 91.99605462476352d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 86.62159084835201d0 27.938681617239677d0 82.69297767523773d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 86.62159084835201d0 87.2851561681988d0 71.33192600384052d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lchuv))))
