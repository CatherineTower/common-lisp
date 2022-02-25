(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > xyY"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.4078724682186829d0 0.4914062752121349d0 0.8832030625079514d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 75.53873122580802d0 -23.75916286870483d0 -34.06364765330996d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 75.53873122580802d0 41.53107164124821d0 235.1044884123536d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 75.53873122580802d0 -53.10885770821632d0 -48.701521684779d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 75.53873122580802d0 72.05823326646697d0 222.5212331959971d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.477759635648462d0 0.7867809784027634d0 0.9641106893604173d0
               :space 'i:adobe-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.5469066086254852d0 0.7677687419254872d0 0.954371708901213d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.2335480788155702d0 0.7509820969108089d0 0.9713560178573449d0
               :space 'i:apple-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.527436142269029d0 0.7596089109968638d0 0.945983001263529d0
               :space 'i:best-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.5391820159723474d0 0.7773500978142132d0 0.9517896646950188d0
               :space 'i:beta-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.3590906131068887d0 0.7868479820733549d0 0.963773499899909d0
               :space 'i:bruce-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.5007008228916607d0 0.7449517462801802d0 0.9448078455088786d0)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb 0.5113841187947094d0 0.7666538854631929d0 0.9548854353941129d0
               :space 'i:bt470-ntsc)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.3672484332048480d0 0.7740133628418490d0 0.9466453841339852d0
               :space 'i:cie-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.3043192555472190d0 0.7506880463113186d0 0.9733446248590530d0
               :space 'i:colormatch-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.4330912324885453d0 0.8068900631098457d0 0.9592018887931187d0
               :space 'i:dci-p3)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.5875624783876848d0 0.8179216554932087d0 0.9505165973837105d0
               :space 'i:dci-p3+)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.5267771037951173d0 0.7734190124829580d0 0.9489116891183200d0
               :space 'i:don-rgb-4)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.5579177119642573d0 0.8010089372701620d0 0.9637233373757265d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.5069450728143874d0 0.7808046339867004d0 0.9519012856594345d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.5562697081271205d0 0.7143778026606519d0 0.9320871940901260d0
               :space 'i:prophoto-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.2325918013208214d0 0.7868479820733549d0 0.9708774301119986d0
               :space 'i:simple-srgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 0.0434774097026900d0 0.7898649815254276d0 0.9694659090756381d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.2220962583913887d0 0.7918745050429686d0 0.9718015078049395d0
               :space 'i:srgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space 'i:srgb))))
