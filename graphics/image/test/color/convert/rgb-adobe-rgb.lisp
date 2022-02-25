(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Adobe RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2525439766564273d0 0.5964320958261923d0 0.0753622386175564d0)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.2732159574299605d0 0.6452530298309288d0 0.5964320958261923d0)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 81.64387167019585d0 -99.43189896636085d0 86.23725225796892d0)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lch-ab 81.64387167019585d0 131.61901917679359d0 139.06491190370332d0)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:lch-ab)))
  (p:is color=
        (i:luv 81.64387167019585d0 -96.21349096356381d0 107.40891719432494d0)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:rgb 81.64387167019585d0 144.20024735156707d0 131.85297167458134d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:lch-uv)))
  (p:is color=
        (i:rgb 0.55506328409504d0 0.8640110487601457d0 0.2144188645274893d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :adobe-wide-gamut-rgb)))
  (p:is color=
        (i:rgb -0.208285651516117d0 0.9525019002786511d0 -0.2034182719298832d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :apple-rgb)))
  (p:is color=
        (i:rgb 0.4552836978999552d0 0.8782162556660119d0 0.2963519780044409d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :best-rgb)))
  (p:is color=
        (i:rgb 0.4717482791396977d0 0.9085922392306959d0 0.2280485970443202d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :beta-rgb)))
  (p:is color=
        (i:rgb -0.1563730752638756d0 0.9421960974410715d0 0.1299516113085057d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :bruce-rgb)))
  (p:is color=
        (i:rgb 0.434467064011132d0 0.9639444856951203d0 0.1522642404356368d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :bt470-ntsc)))
  (p:is color=
        (i:rgb 0.3509230717795801d0 0.8519791520109288d0 0.2862142557701493d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :cie-rgb)))
  (p:is color=
        (i:rgb -0.1421335664263123d0 0.9575200854116652d0 -0.1951985575435977d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :colormatch-rgb)))
  (p:is color=
        (i:rgb 0.4537831860478359d0 0.9002421115907301d0 0.2788446151300183d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :don-rgb-4)))
  (p:is color=
        (i:rgb 0.4896959451242547d0 0.9589651980639323d0 0.0289436105083099d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :eci-rgb-v2)))
  (p:is color=
        (i:rgb 0.3489857181948631d0 0.8916327422985367d0 0.2293496272539474d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :ekta-space-ps5)))
  (p:is color=
        (i:rgb 0.4242569386479385d0 0.8535984485941335d0 0.2401834685078588d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :prophoto-rgb)))
  (p:is color=
        (i:rgb -0.4038359067983986d0 0.9421960974410715d0 -0.1967291133853854d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :simple-srgb)))
  (p:is color=
        (i:rgb -0.4737065124141337d0 0.9591172922514462d0 -0.1840265135774567d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :smpte-c-rgb)))
  (p:is color=
        (i:rgb -1.7575729606881998d0 0.9439612733133196d0 -0.361221431995646d0
               :space :adobe-rgb)
        (i:convert (i:rgb 0.4253890484849989d0 0.9421761686631593d0 0.11923785445407287d0
                          :space :adobe-rgb)
                   (i:make-color 'i:rgb :space :srgb))))
