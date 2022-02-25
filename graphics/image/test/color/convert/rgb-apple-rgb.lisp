(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Apple RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0997907667105796d0 0.0727239043095458d0 0.4162813669652056d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1694827415144151d0 0.1235128968570905d0 0.0727239043095458d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 32.41913777434424d0 27.178185655687304d0 -61.672923887047126d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lch-ab 32.41913777434424d0 67.39587017252997d0 293.78225368971755d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:lch-ab)))
  (p:is color=
        (i:luv 32.41913777434424d0 -14.415258103958493d0 -84.30347709901454d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lch-uv 32.41913777434424d0 85.52704786900932d0 260.2966977457586d0)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:lch-uv)))
  (p:is color=
        (i:rgb 0.1654836693171074d0 0.2718316687197496d0 0.6706771076848413d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.1924146731692412d0 0.3079463031786109d0 0.6590731410952287d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.225474199487315d0 0.2837725012996739d0 0.6466935845427964d0
               :space :best-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.2332800784545396d0 0.286711862280749d0 0.6563278227025818d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.1248383826877425d0 0.2719574365813021d0 0.6701897294616318d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.2135070132269705d0 0.2048634895017481d0 0.6625102389008891d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb -0.1377928683337266d0 0.3258769884241275d0 0.6480752725229747d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.1118272594561575d0 0.189015031566681d0 0.6369832547143264d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.2253235546014556d0 0.2874960478808469d0 0.6504666331794392d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.2164208161139321d0 0.242227397227215d0 0.7016673358053483d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.2436417281786436d0 0.3064066479531024d0 0.6563345343654035d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.2484058007620153d0 0.2139740753621915d0 0.5838384628377971d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.0817671806545912d0 0.2719574365813021d0 0.6819551475619481d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb -0.0728074878241107d0 0.2603568479459183d0 0.6802644291442433d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.0512795967223595d0 0.2647998975882512d0 0.6877829971587036d0
               :space :srgb)
        (i:convert (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                          :space :apple-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
