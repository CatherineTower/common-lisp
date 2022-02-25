(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (SMPTE-C RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0823155282116541d0 0.0956155623166773d0 0.0610563915700192d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.3444344761864088d0 0.4000860692667099d0 0.0956155623166773d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 37.04374562703637d0 -7.416979461526169d0 14.90488896372768d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lch-ab 37.04374562703637d0 16.64834224040797d0 116.45588273645843d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:lch-ab)))
  (p:is color=
        (i:luv 37.04374562703637d0 -1.9810450557442587d0 18.27640628719308d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lch-uv 37.04374562703637d0 18.383459040328606d0 96.18634182312512d0)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:lch-uv)))
  (p:is color=
        (i:rgb 0.3395674198575419d0 0.3543575638434276d0 0.260209320889864d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.3419087169021957d0 0.3472504236771083d0 0.2646439661858273d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.2636528018365561d0 0.2833236142406359d0 0.1848569334311715d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.3373939299851995d0 0.3500806300304663d0 0.2696995348175857d0
               :space :best-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.3373415123933127d0 0.3515089009420719d0 0.2657862249804934d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.3361248190613375d0 0.3544881375507857d0 0.260588234284764d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.3375770779221015d0 0.3597732948548963d0 0.2630751518183229d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.3432936903582515d0 0.3451832419031514d0 0.2691162862712328d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.2619938554975265d0 0.2838748227419169d0 0.1848313106655216d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.3373649819506488d0 0.3509886965614721d0 0.2683050812279183d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.363522860229848d0 0.3854707844476029d0 0.273559037247404d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.3339003167442552d0 0.349002659282136d0 0.2658035288439676d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.2591422505368965d0 0.2773071855043771d0 0.2025610237254209d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.3335853708688173d0 0.3544881375507857d0 0.2553364932696587d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.3306489974039644d0 0.3527437919297797d0 0.2468370922440968d0
               :space :srgb)
        (i:convert (i:rgb 0.33305567309949025d0 0.3562644125718484d0 0.256029016232886d0
                          :space :smpte-c-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
