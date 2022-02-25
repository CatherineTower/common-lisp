(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Ekta Space PS 5)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2778475987785322d0 0.5668716729513777d0 0.5595321876489582d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1978617126746163d0 0.4036824524306478d0 0.5668716729513777d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 80.00331755111789d0 -83.55343638626772d0 -10.183340124011032d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 80.00331755111789d0 84.17171227933633d0 186.9488334723535d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 80.00331755111789d0 -107.02334170545666d0 -0.3170151632470488d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 80.00331755111789d0 107.0238112216934d0 180.1697160402891d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.1121298428636412d0 0.9202557371234645d0 0.8407894292118718d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.4204480925600725d0 0.8577743177037613d0 0.8367422141899158d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.4552978073470462d0 0.9211775211592497d0 0.80212221476949d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.3023212089284199d0 0.858611819351423d0 0.8378759802731597d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.3395039209702375d0 0.8922555840163933d0 0.8351943696366585d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb -0.4641871550852303d0 0.9202828954188496d0 0.8410270398553246d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.2448586950090109d0 0.9160751211601972d0 0.831609293436054d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb -0.3703034811294188d0 0.8565663876125558d0 0.8370413917894806d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb -0.3848527242254483d0 0.92387121324802d0 0.806078264632076d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb -0.5049913754607998d0 0.9144617461288013d0 0.8576769301754718d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.2948572077980861d0 0.8796317993650482d0 0.8581743430841041d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.2995655393048d0 0.8838854988808497d0 0.8386368571158893d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.3017908995159806d0 0.9266988386771046d0 0.8525890279805824d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.4095002141180832d0 0.830033710742952d0 0.8058648915205262d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.5961421321427541d0 0.9202828954188497d0 0.8372263388599066d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -0.6550698699344945d0 0.9328657302988546d0 0.8366991936381368d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -4.140302854565253d0 0.9226431552204883d0 0.8414479988021314d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:rgb :space 'i:srgb))))
