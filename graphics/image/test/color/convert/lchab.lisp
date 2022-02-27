(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > LCHab"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0141773774614284d0 0.0197288255464867d0 0.2056730271393733d0)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         'i:xyz))
  (p:is color=
        (i:xyy 0.0591761541796108d0 0.0823478125977693d0 0.0197288255464867d0)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         'i:xyy))
  (p:is color=
        (i:lab 15.344287349659623d0 -12.022421411529812d0 -60.70998085614615d0)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         'i:lab))
  (p:is color=
        (i:luv 15.34428734965962d0 -27.260880909967028d0 -55.21823189088586d0)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         'i:luv))
  (p:is color=
        (i:lchuv 15.34428734965962d0 61.58091231171433d0 243.7247471151161d0)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         'i:lchuv))
  (p:is color=
        (i:rgb -0.2632138396446138d0 0.2085158037675815d0 0.4882744446633417d0
               :space 'i:adobe-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb -0.2262468013486731d0 0.2083457455243176d0 0.478797662768471d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.247622942466717d0 0.1465749201630559d0 0.4315592169022597d0
               :space 'i:apple-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb -0.2271686633569973d0 0.1883687901021161d0 0.4695506407721215d0
               :space 'i:best-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb -0.2184027322395023d0 0.2066234405663671d0 0.4765011767891986d0
               :space 'i:beta-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb -0.3042591066890263d0 0.2086319222590547d0 0.4879828351843904d0
               :space 'i:bruce-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb -0.1565559619569390d0 0.1125106273684450d0 0.4254463876047152d0
               :space 'i:bt2020)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb -0.2384914433178642d0 0.1584987195070374d0 0.4806817903514822d0
               :space 'i:bt470-ntsc)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb -0.4091977721374944d0 0.2918957284282138d0 0.5788537129113679d0
               :space 'i:bt470-pal/secam)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:bt470-pal/secam)))
  (p:is color=
        (i:rgb -0.3912029593991169d0 0.1339081277754479d0 0.4503614481727313d0
               :space 'i:bt709)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:bt709)))
  (p:is color=
        (i:rgb -0.3159101071602394d0 0.2226732403374511d0 0.4704758163732122d0
               :space 'i:cie-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb -0.2242047894755648d0 0.1446272043781323d0 0.4325611481994455d0
               :space 'i:colormatch-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb -0.3613050612934319d0 0.2540951319610347d0 0.5344969855487135d0
               :space 'i:dci-p3)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb -0.2654961511792777d0 0.3092979626798522d0 0.5238494831810956d0
               :space 'i:dci-p3+)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb -0.2275512508087427d0 0.203393437800504d0 0.4725561383512143d0
               :space 'i:don-rgb-4)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb -0.3697049338439124d0 0.1698072576887741d0 0.5210722360221204d0
               :space 'i:eci-rgb-v2)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb -0.231370047366999d0 0.218926688079961d0 0.4765518120717788d0
               :space 'i:ekta-space-ps5)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb -0.0549707920033401d0 0.1295922930943012d0 0.3947316719518293d0
               :space 'i:prophoto-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.3294681691996134d0 0.2086319222590547d0 0.4963850277033493d0
               :space 'i:simple-srgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -0.3455068908415275d0 0.2064742677621276d0 0.4950171471456092d0
               :space 'i:smpte-c-rgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -1.1231871634303534d0 0.195813835284156d0 0.5001618023558022d0
               :space 'i:srgb)
        (i:convert-color
         (i:lchab 15.344287349659623d0 61.88893594294575d0 258.798618249731d0)
         (i:make-color 'i:rgb :space 'i:srgb))))
