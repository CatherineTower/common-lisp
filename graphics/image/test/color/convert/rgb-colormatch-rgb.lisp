(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ColorMatch RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.5179242219875918d0 0.2754318573941936d0 0.6717742601938942d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.3535004415631645d0 0.187991368381575d0 0.2754318573941936d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 59.473770370696954d0 81.1265086151769d0 -56.61972287275818d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 59.473770370696954d0 98.93080116059056d0 325.0880841065256d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 59.473770370696954d0 78.61939020823655d0 -89.79003203581168d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 59.473770370696954d0 119.3451229406005d0 311.20511462915954d0)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.8040169291723318d0 0.2399206637105419d0 0.9446018189322941d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.7447100572185518d0 0.4512471401228549d0 0.931966964821864d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.8745900591911935d0 0.0765405772452165d0 0.9698335211671977d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.796337217725867d0 0.4192242459706138d0 0.9146848729184889d0
               :space :best-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.7899565660272626d0 0.3522816134384791d0 0.9293348975574234d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.8793375472640071d0 0.2400423117368665d0 0.9437167486722278d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.803775633697953d0 -0.0736718049209771d0 0.9399794206148752d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.822207015870298d0 0.4761105058966368d0 0.9171084354471334d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.796947691694699d0 0.3728503199680194d0 0.9191501969177649d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.8214925508020504d0 0.1604408148441601d0 0.9537609231949752d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.834893041740463d0 0.3972726465657865d0 0.9291396783513114d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.7475848686663634d0 0.3448363843968106d0 0.8920154851706483d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.927929814683202d0 0.2400423117368665d0 0.9619605702798456d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.9494575064361758d0 0.1383004157368292d0 0.9600652941296878d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.9300871664423989d0 0.2302219492046465d0 0.9631535773320546d0
               :space :srgb)
        (i:convert (i:rgb 0.8633025735134483d0 0.030974212758084096d0 0.9681275304682193d0
                          :space :colormatch-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
