(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (CIE RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.1149655022555951d0 0.0576037201157763d0 0.303681049267886d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.2413972423782203d0 0.120952624168599d0 0.0576037201157763d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 28.799671871572755d0 50.02085706299214d0 -57.191155342843345d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 28.799671871572755d0 75.97969722738786d0 311.1737781949945d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 28.799671871572755d0 12.272175295309388d0 -74.65081610041774d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 28.799671871572755d0 75.65282962941433d0 279.33560249718806d0)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.332366025894677d0 0.1247793506912742d0 0.6046425792668071d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.310235431383059d0 0.234792522992223d0 0.5944402901744703d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.292040860870308d0 0.0326846188541911d0 0.5628764698598764d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.3442918958936677d0 0.2053209285876961d0 0.5824833140875284d0
               :space :best-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.3437458900420179d0 0.1817639421067817d0 0.5921762368476021d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.3621528580898205d0 0.1248716048844887d0 0.6041607882906272d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.3442742950551053d0 -0.1274549902570533d0 0.5987498237265687d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.2991712591752493d0 -0.0105144733431908d0 0.5628090660084785d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.3445289863398584d0 0.1901683011220877d0 0.5859118284681183d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.3673624232501159d0 -0.0099886569641374d0 0.6403623815455688d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.3674144935729802d0 0.2140691241737967d0 0.5921233612560919d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.3011682204852787d0 0.1438189078108793d0 0.5135821755197187d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.3813703461918966d0 0.1248716048844887d0 0.6160593379749467d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.3868654765289747d0 0.0661553129423351d0 0.6145602896034925d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.3810006505385893d0 0.1016790195767004d0 0.6217160220655478d0
               :space :srgb)
        (i:convert (i:rgb 0.31371992189283615d0 0.2559466505276866d0 0.5839679952923835d0
                          :space :cie-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
