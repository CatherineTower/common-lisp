(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ECI RGB v2)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2344341010019042d0 0.2346344082677029d0 0.5082984979049704d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.2398629166740734d0 0.2400678624767538d0 0.2346344082677029d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 55.5465267993102d0 3.6803258639943603d0 -46.814803026877485d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 55.5465267993102d0 46.95924382813807d0 274.49503843677337d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 55.5465267993102d0 -22.7598212930054d0 -63.57617195445309d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 55.5465267993102d0 67.52732117944358d0 250.3029907003886d0)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.4133686793871365d0 0.5197668495727334d0 0.8274440077998565d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.4353363389020815d0 0.5341271997207917d0 0.8163805824428785d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.2931293542165513d0 0.4450028752682342d0 0.8150940286724576d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.4461843296659539d0 0.5197068946051165d0 0.8049332243680224d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.4518320730403082d0 0.5250779722012682d0 0.8136998922252799d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.3833998408413509d0 0.5198876457088907d0 0.8269663911430682d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.4380814106107951d0 0.4864328359769542d0 0.8192377489724546d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.3476968524571325d0 0.5454180120118438d0 0.8061601278802932d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.3255034777218868d0 0.442560684677081d0 0.8160006462468286d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.4484024495375760d0 0.5721905807627267d0 0.8405330028609383d0
               :space 'i:dci-p3)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb 0.5261129417523157d0 0.6189974980685172d0 0.8286137895682472d0
               :space 'i:dci-p3+)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb 0.4460038524724222d0 0.5246137413511469d0 0.8084718190214509d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.4516012808740412d0 0.536123229858147d0 0.8137238684197389d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.4415362681240105d0 0.4490177468969475d0 0.7639977816574187d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.3604136247012826d0 0.5198876457088907d0 0.8377645488622609d0
               :space 'i:simple-srgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb 0.3396335774249186d0 0.5150888594322199d0 0.8361459982461842d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.3589871806779134d0 0.5242101522293497d0 0.8419762418535232d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.4757157961828884d0 0.5382394522451406d0 0.8456712379120774d0
                          :space 'i:eci-rgb-v2)
                   (i:make-color 'i:rgb :space 'i:srgb))))
