(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ProPhoto RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.8101229374759039d0 0.5570439891980326d0 0.1601558982278273d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.5304202387782756d0 0.3647192198766893d0 0.5570439891980326d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 79.44528666338432d0 60.40318922786081d0 48.76491008541643d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 79.44528666338432d0 77.63093278156272d0 38.91475056206659d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 79.44528666338432d0 130.93037997252844d0 32.68725788481887d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 79.44528666338432d0 134.94895786103476d0 14.017569248730414d0)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 1.084417203283795d0 0.5603868057016215d0 0.4357276389476412d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 1.0172032691772268d0 0.6546628380856466d0 0.45952700105107d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 1.241736061995703d0 0.4648859685082677d0 0.3491710965395265d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 1.0494533519341873d0 0.6608744116196866d0 0.4719287043689514d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 1.0387701883537794d0 0.606769621378102d0 0.4665304750838632d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 1.1687314878662833d0 0.5605020646039182d0 0.4361801263171963d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 1.063076072976126d0 0.5867413236710008d0 0.4669361807578622d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 1.1459505857373526d0 0.6507838097552525d0 0.4721346491200243d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 1.2036983054680246d0 0.4615782718353925d0 0.3399257774545742d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 1.1354007657800518d0 0.6479266952621838d0 0.5259788307611305d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 1.0484923516317326d0 0.6807135526449497d0 0.5407301639063891d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 1.0501326308045487d0 0.6205282758240805d0 0.4659376053329365d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 1.0462125551441765d0 0.6194537090217427d0 0.5001274585560501d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 1.0771628109809435d0 0.6117421218144136d0 0.4658879384190834d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 1.223907745254498d0 0.5605020646039183d0 0.4295140350958414d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 1.253758261835738d0 0.5390198404779315d0 0.4330541816859003d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 1.214663844219434d0 0.5655568513914941d0 0.4312000949968212d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                          :space 'i:prophoto-rgb)
                   (i:make-color 'i:rgb :space 'i:srgb))))
