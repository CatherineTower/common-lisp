(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (sRGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.4459474718435258d0 0.2807444148120802d0 0.0358581702754469d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.5848107514912254d0 0.3681652270041914d0 0.2807444148120802d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 59.95593209930084d0 61.133911920680404d0 66.85280383185929d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 59.95593209930084d0 90.59057658998849d0 47.55847298888456d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 59.95593209930084d0 137.60598472010605d0 48.29705364609488d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 59.95593209930084d0 145.8355663810575d0 19.340092048763918d0)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.8717543497889991d0 0.3444093308775093d0 0.1184316116889793d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.8100131645002422d0 0.4537889736453585d0 0.1811091099712774d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.9647177058206092d0 0.2395189616599386d0 0.0279509143869492d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.8397205782729896d0 0.4606901252035971d0 0.2063969354380437d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.8298864999527187d0 0.4001911258422567d0 0.1955517927381878d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.9484036909890003d0 0.3445397228532495d0 0.119643103478467d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.8522369781592672d0 0.3770649323076106d0 0.1961239723747482d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.9279084480171267d0 0.4494645871343018d0 0.20673865426919d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.931878581620549d0 0.235586291827016d0 -0.0424943174287708d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.8403445958014031d0 0.415961682397081d0 0.1945889598167209d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.8648416724416722d0 0.400191705235814d0 0.1821369790069728d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.8650745630807135d0 0.4058077504068956d0 0.1942657040881554d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.7242569638286198d0 0.3879536784250615d0 0.1498108251329043d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.9980985620085232d0 0.3445397228532495d0 0.0935182799364484d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 1.0248819354417928d0 0.3168383051968562d0 0.107914166376972d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.9981610052232226d0 0.3422419922805373d0 0.06520086530994451d0
                          :space 'i:srgb)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb))))
