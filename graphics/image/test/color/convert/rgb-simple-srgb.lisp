(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Simple sRGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.0614782149106999d0 0.0309306377550514d0 0.1261300056825786d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.2813147985458473d0 0.1415338122877488d0 0.0309306377550514d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 20.412817193922066d0 43.75893463334951d0 -34.712274927707156d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 20.412817193922066d0 55.85504803419725d0 321.5763886449412d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 20.412817193922066d0 19.703440067714386d0 -42.54775066251186d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 20.412817193922066d0 46.888555500690046d0 294.84838523966806d0)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.2876542769400003d0 0.0781822304212126d0 0.3887953704162372d0
               :space 'i:adobe-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb 0.2663386375324392d0 0.1672358856491565d0 0.3829565680843262d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.2489040890233142d0 -0.0136492587536192d0 0.3281382563316814d0
               :space 'i:apple-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb 0.2878429789249191d0 0.1513720048149254d0 0.3756017185297374d0
               :space 'i:best-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb 0.2859174605791998d0 0.1266393840309854d0 0.3817977758591126d0
               :space 'i:beta-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb 0.3150735925273944d0 0.0782530238377109d0 0.3885458198705337d0
               :space 'i:bruce-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb 0.2899623816052956d0 -0.0773367493847649d0 0.3861722753796183d0
               :space 'i:bt470-ntsc)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb 0.2896382414778719d0 0.1792049951720205d0 0.3765948086812049d0
               :space 'i:cie-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb 0.2476248326961818d0 -0.026812589555126d0 0.3277805498532157d0
               :space 'i:colormatch-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb 0.288063805301829d0 0.1345719822666806d0 0.3776183219584009d0
               :space 'i:don-rgb-4)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb 0.3046842441296443d0 -4.01239576381d-5 0.4201773110356812d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.3033976669551046d0 0.1472971559897402d0 0.381735794336485d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.2219340420103455d0 0.0992037672046835d0 0.3004729638389997d0
               :space 'i:prophoto-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb 0.3399066025444107d0 -0.0160673326713856d0 0.3953440913240998d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.3296868836439915d0 0.0470849751482451d0 0.396528916484171d0
               :space 'i:srgb)
        (i:convert (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                          :space 'i:simple-srgb)
                   (i:make-color 'i:rgb :space 'i:srgb))))
