(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Bruce RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2809016442314912d0 0.3004759241082804d0 0.8280719105913972d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1992988386107376d0 0.2131867290029728d0 0.3004759241082804d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 61.69526442104498d0 -1.8391610392906044d0 -48.59605960773949d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 61.69526442104498d0 48.63084949625509d0 267.83262472411974d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 61.69526442104498d0 -34.747141059184756d0 -77.37194388690675d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 61.69526442104498d0 84.81616303880723d0 245.81552070689162d0)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.3787913275579068d0 0.6005520203792374d0 0.9081098640031473d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.4285952644270877d0 0.603427679431649d0 0.8959411195391064d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.1878148933519053d0 0.534834436396165d0 0.911664752339521d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.4306039826577839d0 0.5888089509011318d0 0.8838925964985361d0
               :space :best-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.4405589865587527d0 0.6005081535690553d0 0.8928976825793102d0
               :space :beta-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb 0.4165148421520295d0 0.5666098458732474d0 0.8983910098976206d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.2569297496064074d0 0.6147762843113039d0 0.8851019607154464d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.252078943011784d0 0.532823157284757d0 0.9130650702519695d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.430171143600685d0 0.5984730572898519d0 0.8877266660917404d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.4562366985871081d0 0.6182430265717983d0 0.9158542337620393d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.4276880866635887d0 0.610433277461558d0 0.8929547484349345d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.455724655303097d0 0.5230737701637732d0 0.8567200794658008d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.2194608772690253d0 0.6006607749291796d0 0.9186533716918835d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.1316695924236051d0 0.5983674943912592d0 0.9168797691550581d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.2077220220198269d0 0.6061945913744511d0 0.9210562053721705d0
               :space :srgb)
        (i:convert (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                          :space :bruce-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
