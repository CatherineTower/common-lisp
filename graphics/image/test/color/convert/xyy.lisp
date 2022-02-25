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
               :space :adobe-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.5469066086254852d0 0.7677687419254872d0 0.954371708901213d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.2335480788155702d0 0.7509820969108089d0 0.9713560178573449d0
               :space :apple-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.527436142269029d0 0.7596089109968638d0 0.945983001263529d0
               :space :best-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.5391820159723474d0 0.7773500978142132d0 0.9517896646950188d0
               :space :beta-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.3590906131068887d0 0.7868479820733549d0 0.963773499899909d0
               :space :bruce-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.5113841187947094d0 0.7666538854631929d0 0.9548854353941129d0
               :space :bt470-ntsc)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.3672484332048480d0 0.7740133628418490d0 0.9466453841339852d0
               :space :cie-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.3043192555472190d0 0.7506880463113186d0 0.9733446248590530d0
               :space :colormatch-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.5267771037951173d0 0.7734190124829580d0 0.9489116891183200d0
               :space :don-rgb-4)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.5579177119642573d0 0.8010089372701620d0 0.9637233373757265d0
               :space :eci-rgb-v2)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.5069450728143874d0 0.7808046339867004d0 0.9519012856594345d0
               :space :ekta-space-ps5)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.5562697081271205d0 0.7143778026606519d0 0.9320871940901260d0
               :space :prophoto-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.2325918013208214d0 0.7868479820733549d0 0.9708774301119986d0
               :space :simple-srgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.0434774097026900d0 0.7898649815254276d0 0.9694659090756381d0
               :space :smpte-c-rgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.2220962583913887d0 0.7918745050429686d0 0.9718015078049395d0
               :space :srgb)
        (i:convert (i:xyy 0.22882279463372762d0 0.2756865588051985d0 0.49140627521213487d0)
                   (i:make-color 'i:rgb :space :srgb))))
