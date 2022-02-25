(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (DCI-P3+)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.1903238767955199d0 0.2217914110186268d0 0.7317511687686392d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1663864480859925d0 0.1938962452673118d0 0.2217914110186268d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 54.2165624006329239d0 -4.1695699673716113d0 -61.9878838084014134d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 54.2165624006329239d0 62.1279570946661721d0 266.1518376809750066d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 54.2165624006329239d0 -40.5240187756801689d0 -91.8837442237113180d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 54.2165624006329239d0 100.4231972718459218d0 246.2008044852906892d0)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.1638460945960222d0 0.5313537444875970d0 0.9175437291299662d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.2777810728309425d0 0.5376846136648981d0 0.9032838086873431d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.2060757767233097d0 0.4591740873103866d0 0.9271250769346102d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.2849366473706947d0 0.5174615498201144d0 0.8890216048990555d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.3030868779098322d0 0.5323622622656470d0 0.8997141213211607d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb -0.2182262666936113d0 0.5314730723289175d0 0.9169260367219287d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.2574858283361294d0 0.4836918955703155d0 0.9062615683096881d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb -0.2777864985561105d0 0.5531349346188749d0 0.8904681190880948d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb -0.1091325031997718d0 0.4563670158755894d0 0.9286977761349859d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb -0.2567863924907404d0 0.5775907132159291d0 0.9151098882297618d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.2841504653163271d0 0.5298798657772819d0 0.8935406395476867d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.2819776276161871d0 0.5410466633742542d0 0.9233646418810616d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.2820514640976638d0 0.5462031159089568d0 0.8997759251566703d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.3655069739943592d0 0.4465069495665111d0 0.8622150881686146d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.3042807253664122d0 0.5314730723289175d0 0.9299924809123336d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -0.3511932109723944d0 0.5277936312434366d0 0.9279198268787597d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -0.9429014161555223d0 0.5360310350029058d0 0.9320942235774289d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0
                          :space 'i:dci-p3+)
                   (i:make-color 'i:rgb :space 'i:srgb))))
