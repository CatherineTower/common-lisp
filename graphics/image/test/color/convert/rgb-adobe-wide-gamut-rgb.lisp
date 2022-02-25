(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Adobe Wide Gamut RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0800630380549832d0 0.0314383010133982d0 0.0109506098598647d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.6538322889568562d0 0.2567398991078559d0 0.0314383010133982d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 20.61095114048863d0 60.32808515366439d0 15.771773771209318d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lch-ab 20.61095114048863d0 62.35564694715298d0 14.651114427876756d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:lch-ab)))
  (p:is color=
        (i:luv 20.61095114048863d0 90.76780156957258d0 -1.068183009272207d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lch-uv 20.61095114048863d0 90.77408670272922d0 359.3257570196789d0)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:lch-uv)))
  (p:is color=
        (i:rgb 0.401212590292516d0 -0.1599410154697203d0 0.1370645185941288d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.3861358100847623d0 -0.1237725079448818d0 0.096249331425148d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.3851292916309612d0 0.0817000175016046d0 0.140721469437329d0
               :space :best-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.3795991161040187d0 -0.1087595085098683d0 0.1452923643296395d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.4465796454648012d0 -0.1600451558623416d0 0.1368290455740325d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.3920477139131869d0 -0.1544267398373566d0 0.1508345237110902d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.4300250452469282d0 0.0891735432086958d0 0.1420882770488356d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.3721702887471786d0 -0.1262793750190167d0 0.092215320789217d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.3855067669126432d0 -0.0869565749334066d0 0.1397000230051457d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.4187043859291697d0 -0.1434068913412768d0 0.1315766073597695d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.4022061688335193d0 -0.0909636068733093d0 0.1448499317116877d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.2769638177580763d0 0.0467759649617503d0 0.0906063165957486d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.4753472925568803d0 -0.1600451558623416d0 0.1434250298931951d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.4901340932087668d0 -0.1780807560949065d0 0.144147954391313d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.4785550468522818d0 -0.2294014126273451d0 0.1228929196332381d0
               :space :srgb)
        (i:convert (i:rgb 0.3639436099253135d0 0.08486258678927672d0 0.14289086780800808d0
                          :space :adobe-wide-gamut-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
