(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Apple RGB)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.0997907667105796d0 0.0727239043095458d0 0.4162813669652056d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.1694827415144151d0 0.1235128968570905d0 0.0727239043095458d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 32.41913777434424d0 27.178185655687304d0 -61.672923887047126d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 32.41913777434424d0 67.39587017252997d0 293.78225368971755d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 32.41913777434424d0 -14.415258103958493d0 -84.30347709901454d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 32.41913777434424d0 85.52704786900932d0 260.2966977457586d0)
        (i:convert-color
         (i:rgb 0.04330031119736d0 0.1934597870725685d0 0.636296334766828d0
                :space 'i:apple-rgb)
         'i:lchuv)))
