(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > LCHuv"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 1.1163854349908506d0 0.9486691218359667d0 1.0082636025159788d0)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         'i:xyz))
  (p:is color=
        (i:xyy 0.3632508504194634d0 0.3086791124934595d0 0.9486691218359667d0)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         'i:xyy))
  (p:is color=
        (i:lab 97.98024274406411d0 27.396068927694305d0 -4.031736367628147d0)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         'i:lab))
  (p:is color=
        (i:lchab 97.98024274406411d0 27.69114462836509d0 351.6281718011691d0)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         'i:lchab))
  (p:is color=
        (i:luv 97.98024274406411d0 41.45582958474809d0 -11.379832502778369d0)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         'i:luv))
  (p:is color=
        (i:rgb 1.1102960980210306d0 0.8952899553665923d0 1.0080950281544108d0
               :space 'i:adobe-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 1.0774311207132528d0 0.9348150494390668d0 1.0071788469059115d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 1.2061907563394791d0 0.8613695225652167d0 1.0194885585041937d0
               :space 'i:apple-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 1.0979866535021654d0 0.9319404366333733d0 1.0036601505249125d0
               :space 'i:best-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 1.0934085558635565d0 0.9134687740855695d0 1.0072483450082292d0
               :space 'i:beta-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 1.1537441643250745d0 0.89532512150811d0 1.0078591469386724d0
               :space 'i:bruce-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 1.0989053693758923d0 0.9130897003369753d0 1.0065761456791278d0
               :space 'i:bt2020)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb 1.103712714999937d0 0.8923551537105596d0 1.0104399888747904d0
               :space 'i:bt470-ntsc)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 1.1333589654247325d0 0.9167915573401402d0 1.0109066331591730d0
               :space 'i:bt470-pal/secam)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:bt470-pal/secam)))
  (p:is color=
        (i:rgb 1.1991276505333444d0 0.8860508612353085d0 1.0137074535490302d0
               :space 'i:bt709)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:bt709)))
  (p:is color=
        (i:rgb 1.1335047519950059d0 0.937467523883523d0 1.0043883572110786d0
               :space 'i:cie-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 1.1911878975968702d0 0.8591386555859246d0 1.0177341737798553d0
               :space 'i:colormatch-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 1.1259163253799451d0 0.9212255114993801d0 1.0067500106235470d0
               :space 'i:dci-p3)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 1.0906785208636276d0 0.9488647591576411d0 1.0035412012198437d0
               :space 'i:dci-p3+)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 1.098323804310209d0 0.9183383809126603d0 1.0041979039120954d0
               :space 'i:don-rgb-4)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 1.0835944774464357d0 0.9097641603836656d0 1.0100461238191485d0
               :space 'i:eci-rgb-v2)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 1.1149605932821878d0 0.919405597292578d0 1.0071106687954725d0
               :space 'i:ekta-space-ps5)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 1.0909661592667503d0 0.9173802717307229d0 1.0035066252996514d0
               :space 'i:prophoto-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 1.183178339213763d0 0.89532512150811d0 1.0125994370401443d0
               :space 'i:simple-srgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 1.1982782954758215d0 0.8863912634285516d0 1.012424429953509d0
               :space 'i:smpte-c-rgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 1.1758784052557045d0 0.8983115008666079d0 1.012178337800396d0
               :space 'i:srgb)
        (i:convert-color
         (i:lchuv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
         (i:make-color 'i:rgb :space 'i:srgb))))
