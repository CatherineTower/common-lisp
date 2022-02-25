(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (bt.470 NTSC)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.1665128225170931d0 0.1399745805417191d0 0.6560006934647666d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1730024746472424d0 0.1454299341958564d0 0.1399745805417191d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 44.22928591202958d0 17.259132890587615d0 -60.50338225276264d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 44.22928591202958d0 62.91690497917771d0 285.9212745525432d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 44.22928591202958d0 -25.059046364194185d0 -93.93003522881666d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 44.22928591202958d0 97.21526280769689d0 255.06229759768576d0)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.2127736407833293d0 0.3992629570865384d0 0.7913624338426983d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.2598849925224914d0 0.4212919827544117d0 0.7785244378080216d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.0352481843253329d0 0.319022075363444d0 0.7762328145181168d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.2818989764680994d0 0.3998430830452255d0 0.765166922941704d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.2923305094035454d0 0.4075096651099243d0 0.7754106694027016d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.1232096684491756d0 0.3993931549121634d0 0.7908085443818803d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb -0.1533442134487462d0 0.4375988801048187d0 0.7666046823585335d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.1210558555563694d0 0.315480554680878d0 0.7772513038552522d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.1888582569680197d0 0.4558860246303746d0 0.8070780823380012d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.3831902993089686d0 0.5263426066791261d0 0.7930509239234604d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.2815678194202645d0 0.4069130495863348d0 0.7692962528853401d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.2849477954170672d0 0.3989305108261461d0 0.8125602249122817d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.2926794367637593d0 0.4238661469960385d0 0.7754371683649722d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.3181760565159d0 0.3256667425869128d0 0.7174641629605231d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.1004840297520557d0 0.3993931549121634d0 0.8033359562529585d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -0.1701355956636326d0 0.391953494059468d0 0.8014660257835224d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -0.0823902857701441d0 0.3998515638295023d0 0.8081273896782726d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                          :space 'i:bt470-ntsc)
                   (i:make-color 'i:rgb :space 'i:srgb))))
