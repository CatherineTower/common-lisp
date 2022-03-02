(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (bt.470 NTSC)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.1665128225170931d0 0.1399745805417191d0 0.6560006934647666d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:xyz))
  (p:is color=
        (i:xyy 0.1730024746472424d0 0.1454299341958564d0 0.1399745805417191d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:xyy))
  (p:is color=
        (i:lab 44.22928591202958d0 17.259132890587615d0 -60.50338225276264d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:lab))
  (p:is color=
        (i:lchab 44.22928591202958d0 62.91690497917771d0 285.9212745525432d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:lchab))
  (p:is color=
        (i:luv 44.22928591202958d0 -25.059046364194185d0 -93.93003522881666d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:luv))
  (p:is color=
        (i:lchuv 44.22928591202958d0 97.21526280769689d0 255.06229759768576d0)
        (i:convert-color
         (i:rgb 0.2663412823714957d0 0.3467776431121068d0 0.7818752452897231d0
                :space 'i:bt470-ntsc)
         'i:lchuv)))
