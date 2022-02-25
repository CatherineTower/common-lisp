(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Adobe Wide Gamut RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0800630380549832d0 0.0314383010133982d0 0.0109506098598647d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.6538322889568562d0 0.2567398991078559d0 0.0314383010133982d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 20.61095114048863d0 60.32808515366439d0 15.771773771209318d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 20.61095114048863d0 62.35564694715298d0 14.651114427876756d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 20.61095114048863d0 90.76780156957258d0 -1.068183009272207d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 20.61095114048863d0 90.77408670272922d0 359.3257570196789d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space 'i:adobe-wide-gamut-rgb)
                   (i:make-color 'i:lchuv))))
