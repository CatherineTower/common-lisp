(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ColorMatch RGB)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.5179242219875918d0 0.2754318573941936d0 0.6717742601938942d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.3535004415631645d0 0.187991368381575d0 0.2754318573941936d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 59.473770370696954d0 81.1265086151769d0 -56.61972287275818d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 59.473770370696954d0 98.93080116059056d0 325.0880841065256d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 59.473770370696954d0 78.61939020823655d0 -89.79003203581168d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 59.473770370696954d0 119.3451229406005d0 311.20511462915954d0)
        (i:convert-color
         (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                :space 'i:colormatch-rgb)
         'i:lchuv)))
