(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > XYZ"
  :parent "Color > Convert"
  (p:is color=
        (i:xyy 0.0666666666666667d0 0.3333333333333333d0 0.5d0)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 76.06926101415557d0 -164.77082131141094d0 -34.357771724305984d0)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 76.06926101415557d0 168.3148241644105d0 191.7784589134084d0)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 76.06926101415557d0 -169.78565769536613d0 -36.382640934721316d0)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 76.06926101415557d0 173.64004757092442d0 192.09475707701208d0)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb -0.6736754584571568d0 0.9599892636483003d0 0.9694763728683282d0
               :space 'i:adobe-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb -0.4714769965672789d0 0.8709942567984879d0 0.9587101446485923d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.9003766733271247d0 0.9761424165890683d0 0.9647357920730901d0
               :space 'i:apple-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb -0.5829326261753534d0 0.8674757718794868d0 0.9545119205269107d0
               :space 'i:best-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb -0.5512984380145708d0 0.9199903868988205d0 0.9552656747406622d0
               :space 'i:beta-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb -0.8674889353650704d0 0.9600031839952312d0 0.9694661774457546d0
               :space 'i:bruce-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb -1.1475414691717838d0 0.8868534279755660d0 0.9502659163977112d0
               :space 'i:bt2020)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb -0.6208445026098688d0 0.9444625789104951d0 0.9532914722811549d0
               :space 'i:bt470-ntsc)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb -0.9522948993452187d0 0.9684370280595173d0 0.9763590421822035d0
               :space 'i:bt470-pal/secam)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:bt470-pal/secam)))
  (p:is color=
        (i:rgb -0.8125307085209895d0 0.8728897826791688d0 0.9540052732266994d0
               :space 'i:cie-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb -0.8306990658793454d0 0.9793487839045173d0 0.9704922735322846d0
               :space 'i:colormatch-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb -0.8744909971038077d0 0.9393117374605819d0 0.9610429207523697d0
               :space 'i:dci-p3)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb -0.6607502148283199d0 0.9014881702362776d0 0.9559786426596123d0
               :space 'i:dci-p3+)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb -0.584937227271212d0 0.907318439911677d0 0.9572442544236508d0
               :space 'i:don-rgb-4)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb -2.9053770957489564d0 0.9541232746227598d0 0.9607928969781688d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb -0.6629934905146967d0 0.91329308590711d0 0.955664430853978d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb -0.228257890055187d0 0.840405769252342d0 0.9435393927776975d0
               :space 'i:prophoto-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.9773097100953217d0 0.9600031839952313d0 0.9698917642989654d0
               :space 'i:simple-srgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -1.0324975617621581d0 0.9771299794914254d0 0.9683956054217155d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -12.283818302071468d0 0.9612543329666813d0 0.9708458957869069d0
               :space 'i:srgb)
        (i:convert (i:xyz 0.1d0 0.5d0 0.9d0)
                   (i:make-color 'i:rgb :space 'i:srgb))))
