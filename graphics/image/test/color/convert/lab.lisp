(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > Lab"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2325367894129148d0 0.5158764104982997d0 1.3114716274697171d0)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.112888248081606d0 0.2504394438179428d0 0.5158764104982997d0)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lchab 77.03361122337391d0 102.65710239106122d0 210.68540912469328d0)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 77.03361122337391d0 -119.87129199995177d0 -78.4531721942953d0)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 77.03361122337391d0 143.26209154233877d0 213.2038808737796d0)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb -0.5502796755786102d0 0.9019011549416622d0 1.1162614336716492d0
               :space 'i:adobe-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:adobe-rgb)))
  (p:is color=
        (i:rgb -0.3263149947569894d0 0.8423845154170478d0 1.101225694291733d0
               :space 'i:adobe-wide-gamut-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.7531763220661702d0 0.8977066458869535d0 1.1628186949742798d0
               :space 'i:apple-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:apple-rgb)))
  (p:is color=
        (i:rgb -0.4317738260411526d0 0.8305977805715036d0 1.089822909348072d0
               :space 'i:best-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:best-rgb)))
  (p:is color=
        (i:rgb -0.3913513196830801d0 0.8740077481314388d0 1.0969769886518748d0
               :space 'i:beta-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:beta-rgb)))
  (p:is color=
        (i:rgb -0.741642669293111d0 0.9019342243011916d0 1.1157973696989494d0
               :space 'i:bruce-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:bruce-rgb)))
  (p:is color=
        (i:rgb -0.5246151043165246d0 0.8367604811789244d0 1.1018824034614390d0
               :space 'i:bt2020)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:bt2020)))
  (p:is color=
        (i:rgb -0.4786156475127524d0 0.8711402221571389d0 1.1000210876830037d0
               :space 'i:bt470-ntsc)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:bt470-ntsc)))
  (p:is color=
        (i:rgb -0.7115623616417792d0 0.8509509744387163d0 1.090445689530492d0
               :space 'i:cie-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:cie-rgb)))
  (p:is color=
        (i:rgb -0.6763996482174581d0 0.8986628524924409d0 1.1671480204949018d0
               :space 'i:colormatch-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:colormatch-rgb)))
  (p:is color=
        (i:rgb -0.7637823264683474d0 0.8939702681041434d0 1.0813320498065844d0
               :space 'i:dci-p3)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3)))
  (p:is color=
        (i:rgb -0.4971719608374370d0 0.8921247431644669d0 1.0695905281483331d0
               :space 'i:dci-p3+)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:dci-p3+)))
  (p:is color=
        (i:rgb -0.4340514970565485d0 0.8640134393869846d0 1.0941990678433564d0
               :space 'i:don-rgb-4)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:don-rgb-4)))
  (p:is color=
        (i:rgb -1.5794933972972915d0 0.896591085226016d0 1.0869135441598854d0
               :space 'i:eci-rgb-v2)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:eci-rgb-v2)))
  (p:is color=
        (i:rgb -0.5073056290968285d0 0.8755319400441034d0 1.0972392459339544d0
               :space 'i:ekta-space-ps5)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.2423874319788346d0 0.7967293377039927d0 1.1076500299528618d0
               :space 'i:prophoto-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:prophoto-rgb)))
  (p:is color=
        (i:rgb -0.8466678886605812d0 0.9019342243011919d0 1.1243374392909486d0
               :space 'i:simple-srgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:simple-srgb)))
  (p:is color=
        (i:rgb -0.9013694248498753d0 0.9126305048946557d0 1.1221871779016124d0
               :space 'i:smpte-c-rgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:smpte-c-rgb)))
  (p:is color=
        (i:rgb -8.958417712535429d0 0.9047602393330232d0 1.1196479977069764d0
               :space 'i:srgb)
        (i:convert (i:lab 77.03361122337391d0 -88.2832867107874d0 -52.38837618088325d0)
                   (i:make-color 'i:rgb :space 'i:srgb))))
