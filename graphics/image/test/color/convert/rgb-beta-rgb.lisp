(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Beta RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.1593144262373026d0 0.054217555686869d0 0.6942450070589394d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1754995204447363d0 0.0597256334373526d0 0.054217555686869d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 27.904055021814735d0 85.12474349785842d0 -113.10969061237684d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 27.904055021814735d0 141.56279195467923d0 306.96459835848066d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 27.904055021814735d0 -0.2123948091575568d0 -119.1161245799626d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 27.904055021814735d0 119.11631393937661d0 269.89783655822373d0)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:lchuv)))
  (p:is color=
        (i:rgb 0.2380250502100414d0 -0.1993438304959273d0 0.9691174080191522d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :adobe-rgb)))
  (p:is color=
        (i:rgb 0.2125155221753397d0 0.237858858879798d0 0.9504112271325325d0
               :space :adobe-wide-gamut-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb 0.1967413104684128d0 -0.1850079596156339d0 1.0042747441071302d0
               :space :apple-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.3132032264734757d0 0.1231380725495632d0 0.929293879981428d0
               :space :best-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.2768056045484173d0 -0.1994580274723692d0 0.968122489687564d0
               :space :bruce-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.3027584725773753d0 -0.3443349954304877d0 0.956925117444361d0
               :space :bt470-ntsc)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb -0.1506319981669584d0 0.2958556999078188d0 0.9317682212001562d0
               :space :cie-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb 0.2488304539833793d0 -0.1984817315409355d0 1.004832517352424d0
               :space :colormatch-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.3134799855902734d0 0.0900138333228997d0 0.9354982826520005d0
               :space :don-rgb-4)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.318787513618165d0 -0.5996328871179669d0 0.9692747778693053d0
               :space :eci-rgb-v2)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.366102962852163d0 0.2017949891408407d0 0.9459079383065938d0
               :space :ekta-space-ps5)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.3676177272940101d0 0.0742026605326733d0 0.9084707573313952d0
               :space :prophoto-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb 0.3005050101041382d0 -0.1994580274723693d0 0.9883963855461455d0
               :space :simple-srgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb 0.2937086093246061d0 -0.2504733347408447d0 0.9856706045848207d0
               :space :smpte-c-rgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb 0.2954423093749218d0 -0.3723367102119606d0 0.9887728894896194d0
               :space :srgb)
        (i:convert (i:rgb 0.31921045514906754d0 0.037190376334251374d0 0.945948736397938d0
                          :space :beta-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
