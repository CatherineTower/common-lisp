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
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.9060290812588494d0 0.5217613851109847d0 0.1415491114668788d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.8544126690725786d0 0.5783237392516516d0 0.2099128133664664d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.9891758354604271d0 0.4361260777279510d0 -0.0505347630635316d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.8758475526376409d0 0.5873146742344477d0 0.2463247517548255d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.8672046359204943d0 0.5497544253436600d0 0.2248712625116783d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.9709718154045316d0 0.5218819349776526d0 0.1439924701186699d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.8869800992181841d0 0.5499032453328072d0 0.2155534751933050d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.9586646450206581d0 0.5719102622959157d0 0.2446928358444928d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.9578988880580998d0 0.4350298920803006d0 -0.0742325668818811d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.8957363052844707d0 0.6057424179499579d0 0.3267374995670119d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.8763668945678678d0 0.5589324143971542d0 0.2329133630470985d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.8967145526695809d0 0.5802591770662032d0 0.2004202974651010d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.8949821247988422d0 0.5490909183810234d0 0.2239332140703769d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.7700667012737996d0 0.5220144413515991d0 0.1869871074329321d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 1.0136562440596510d0 0.5218819349776526d0 0.0802372270354866d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 1.0375003534592098d0 0.5102227389197289d0 0.1020718587979357d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 1.0131992480616827d0 0.5262465233780319d0 0.0494552753588376d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.9707515698488776d0 0.6005604715628141d0 0.28377247312878073d0
                          :space 'i:dci-p3)
                   (i:make-color 'i:rgb :space 'i:srgb))))
