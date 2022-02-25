(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > LCHuv"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 1.1163854349908506d0 0.9486691218359667d0 1.0082636025159788d0)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.3632508504194634d0 0.3086791124934595d0 0.9486691218359667d0)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 97.98024274406411d0 27.396068927694305d0 -4.031736367628147d0)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lch-ab 97.98024274406411d0 27.69114462836509d0 351.6281718011691d0)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:lch-ab)))
  (p:is color=
        (i:luv 97.98024274406411d0 41.45582958474809d0 -11.379832502778369d0)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:rgb 1.1102960980210306d0 0.8952899553665923d0 1.0080950281544108d0
               :space :adobe-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 1.0774311207132528d0 0.9348150494390668d0 1.0071788469059115d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 1.2061907563394791d0 0.8613695225652167d0 1.0194885585041937d0
               :space :apple-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 1.0979866535021654d0 0.9319404366333733d0 1.0036601505249125d0
               :space :best-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 1.0934085558635565d0 0.9134687740855695d0 1.0072483450082292d0
               :space :beta-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 1.1537441643250745d0 0.89532512150811d0 1.0078591469386724d0
               :space :bruce-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 1.103712714999937d0 0.8923551537105596d0 1.0104399888747904d0
               :space :bt470-ntsc)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 1.1335047519950059d0 0.937467523883523d0 1.0043883572110786d0
               :space :cie-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 1.1911878975968702d0 0.8591386555859246d0 1.0177341737798553d0
               :space :colormatch-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 1.098323804310209d0 0.9183383809126603d0 1.0041979039120954d0
               :space :don-rgb-4)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 1.0835944774464357d0 0.9097641603836656d0 1.0100461238191485d0
               :space :eci-rgb-v2)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 1.1149605932821878d0 0.919405597292578d0 1.0071106687954725d0
               :space :ekta-space-ps5)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 1.0909661592667503d0 0.9173802717307229d0 1.0035066252996514d0
               :space :prophoto-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 1.183178339213763d0 0.89532512150811d0 1.0125994370401443d0
               :space :simple-srgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 1.1982782954758215d0 0.8863912634285516d0 1.012424429953509d0
               :space :smpte-c-rgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 1.1758784052557045d0 0.8983115008666079d0 1.012178337800396d0
               :space :srgb)
        (i:convert (i:lch-uv 97.98024274406411d0 42.98937536590833d0 344.65011946118125d0)
                   (i:make-color 'i:rgb :space :srgb))))
