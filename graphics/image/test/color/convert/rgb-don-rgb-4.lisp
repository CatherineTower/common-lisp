(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Don RGB 4)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.6491232576965265d0 0.6923764072250577d0 0.0209305961534372d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.4764451262146348d0 0.50819218201946d0 0.6923764072250577d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 86.62159084835201d0 -4.118456894920075d0 118.17047712295827d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 86.62159084835201d0 118.24222321431088d0 91.99605462476352d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 86.62159084835201d0 27.938681617239677d0 82.69297767523773d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 86.62159084835201d0 87.2851561681988d0 71.33192600384052d0)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.9257853007057055d0 0.8458795851648524d0 -0.257364452843717d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.9116094556359502d0 0.8304225981578973d0 -0.1565158370499335d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.9424951604593172d0 0.8202707570734008d0 -0.2907373437199317d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.9031365730865428d0 0.8451065451176234d0 0.15942915451657d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.8990076970670473d0 0.8403380900812519d0 -0.1157494414658101d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.9433349617314042d0 0.8459298643069504d0 -0.2536483095342282d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.9089350021864326d0 0.8766401399532792d0 -0.1888403815114717d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.9636822495959467d0 0.8186736998550282d0 0.1433382691467082d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.9195543986927629d0 0.8229322629883346d0 -0.294212806519671d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.9498081316318446d0 0.8701626369786567d0 -0.1755058150981344d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.9023931406397894d0 0.8228045266509999d0 0.2591244166995796d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.9202068115877068d0 0.8822213995922145d0 -0.3372038559438881d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.8984979864449134d0 0.8289802545606846d0 -0.1161372216586165d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.8174045325485841d0 0.8144570669349207d0 0.1298554866662557d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.9554252499244476d0 0.8459298643069505d0 -0.3215937892903607d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 0.9657383586085594d0 0.8507931128837547d0 -0.312522147150849d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.9568111198744725d0 0.8499868885884625d0 -1.0649748459501482d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.903261068392325d0 0.8406642841997971d0 0.10535425813413157d0
                          :space 'i:don-rgb-4)
                   (i:make-color 'i:rgb :space 'i:srgb))))
