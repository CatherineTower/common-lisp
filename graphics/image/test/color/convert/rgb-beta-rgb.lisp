(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Beta RGB)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.1593144262373026d0 0.054217555686869d0 0.6942450070589394d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.1754995204447363d0 0.0597256334373526d0 0.054217555686869d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 27.904055021814735d0 85.12474349785842d0 -113.10969061237684d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 27.904055021814735d0 141.56279195467923d0 306.96459835848066d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 27.904055021814735d0 -0.2123948091575568d0 -119.1161245799626d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 27.904055021814735d0 119.11631393937661d0 269.89783655822373d0)
        (i:convert-color
         (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                :space 'i:beta-rgb)
         'i:lchuv)))
