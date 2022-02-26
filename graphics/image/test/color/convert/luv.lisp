(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > Luv"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.6001147326277835d0 0.1678371175242143d0 0.8027960034800804d0)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.3820566943574831d0 0.1068517248876836d0 0.1678371175242143d0)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 47.98634843876273d0 145.9399852546689d0 -75.55830974201243d0)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 47.98634843876273d0 164.33970143335074d0 332.6277937488115d0)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:lchuv 47.986348438762725d0 187.4057692017771d0 318.17433027866224d0)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.9071683821203013d0 -0.519878583578963d0 0.9426836719996199d0
               :space 'i:adobe-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.8115589048819002d0 -0.1924678890543115d0 0.9280683192276026d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 1.061924838221104d0 -0.50365408451938d0 0.9793891641323093d0
               :space 'i:apple-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.8859065527257592d0 -0.278586302378961d0 0.9057186623984529d0
               :space 'i:best-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.8745265497894879d0 -0.414022147256472d0 0.9252747871414934d0
               :space 'i:beta-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 1.0230586654120395d0 -0.5199993659908473d0 0.9414979115207861d0
               :space 'i:bruce-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.8545328308409006d0 -0.5540575279834123d0 0.9108503949860984d0
               :space 'i:bt2020)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb 0.8995020885206997d0 -0.5720790846795014d0 0.9399395254162966d0
               :space 'i:bt470-ntsc)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 1.0549480976544494d0 -0.5982178311461979d0 0.9781618772143771d0
               :space 'i:bt470-pal/secam)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:bt470-pal/secam)))
  (p:is color=
        (i:rgb 1.1042868444633331d0 -1.0676249261730817d0 0.9627117836233114d0
               :space 'i:bt709)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:bt709)))
  (p:is color=
        (i:rgb 0.949830656302994d0 0.0519152695231464d0 0.9091011250200721d0
               :space 'i:cie-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 1.0366034156466544d0 -0.5147891619966637d0 0.9759464879292264d0
               :space 'i:colormatch-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 1.0129970081961222d0 -0.5199149635524124d0 0.9387592387427478d0
               :space 'i:dci-p3)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.9399338007964519d0 0.3007644273817010d0 0.9168990084288642d0
               :space 'i:dci-p3+)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.8868748754648104d0 -0.3823849581829863d0 0.9111440695322907d0
               :space 'i:don-rgb-4)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.9028683322028582d0 -2.3585322478052917d0 0.9553062479904398d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.9412862947778035d0 -0.3515300522591714d0 0.9249270177259638d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.8197871353752993d0 -0.2111213289591053d0 0.8798889110662239d0
               :space 'i:prophoto-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 1.0958955611120855d0 -0.5199993659908475d0 0.9657339970126865d0
               :space 'i:simple-srgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 1.1294360097392313d0 -0.5655441555433881d0 0.963527247946144d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 1.0923806729967236d0 -3.065269788034714d0 0.9668140105962776d0
               :space 'i:srgb)
        (i:convert (i:luv 47.986348438762725d0 139.65052589061844d0 -124.97460921556608d0)
                   (i:make-color 'i:rgb :space 'i:srgb))))
