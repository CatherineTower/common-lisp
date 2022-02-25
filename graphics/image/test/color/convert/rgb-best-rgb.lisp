(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Best RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2764290244005207d0 0.2106726291896849d0 0.0591884553847105d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.506011402840928d0 0.3856424008573041d0 0.2106726291896849d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 53.02303118387675d0 32.177895650678636d0 35.90708402257808d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 53.02303118387675d0 48.215512560901445d0 48.135103666497386d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 53.02303118387675d0 66.71542638055483d0 25.19652032043792d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 53.02303118387675d0 71.31488451506792d0 20.69012566226302d0)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.6544852703215968d0 0.4024409626803758d0 0.2742571375299723d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.6197880097229231d0 0.440182589858155d0 0.2897310773980831d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.6602446976666017d0 0.3191176035565234d0 0.1931353666076857d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.6293993162754736d0 0.4209431284662767d0 0.2941011473074329d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.698519733958685d0 0.4025710634385055d0 0.2747483944035031d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.642412228503407d0 0.4177547662943373d0 0.2922910841188601d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.6888334798442167d0 0.4370538214226883d0 0.2994015876945799d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.6412415320459589d0 0.3182424358571522d0 0.1888021884393076d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.6354435566500226d0 0.4268327687698423d0 0.2956847744369947d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.6744077581358262d0 0.447333022974278d0 0.30711237864015d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.648516255478045d0 0.4215048381386043d0 0.2937889548033163d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.5265336676950015d0 0.3716995964773097d0 0.2313496593452214d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.7275236242919559d0 0.4025710634385055d0 0.2671788317228748d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 0.7435832226272032d0 0.3946829811393335d0 0.269548661945066d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.7331562097755134d0 0.4031680509157458d0 0.2596451213286143d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.6350939101110611d0 0.4448792502629473d0 0.2997304869722377d0
                          :space 'i:best-rgb)
                   (i:make-color 'i:rgb :space 'i:srgb))))
