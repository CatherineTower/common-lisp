(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (DCI-P3)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.4922299370615421d0 0.3882018745290711d0 0.0468161140916550d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.5308504051916426d0 0.4186602782027606d0 0.3882018745290711d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 68.6208139906571830d0 44.9732253492647871d0 72.6859051396555600d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 68.6208139906571830d0 85.4741586930620798d0 58.2535213013854900d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 68.6208139906571830d0 101.8954666032958016d0 54.7719816459201709d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 68.6208139906571830d0 115.6834304804468871d0 28.2594118230197680d0)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:lchuv))))
