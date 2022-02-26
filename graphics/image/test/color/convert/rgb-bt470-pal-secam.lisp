(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (bt.470 PAL/SECAM)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.4448637887090678d0 0.2153792272076508d0 0.6664721066089240d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.3353122167343574d0 0.1623402217633861d0 0.2153792272076508d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 53.5332604275371864d0 88.5028678896451169d0 -49.9242866063379438d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 53.5332604275371864d0 101.6129520181544166d0 330.5727440201338823d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 53.5332604275371864d0 80.5421145653261306d0 -88.2161714578490148d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 53.5332604275371864d0 119.4534433381253962d0 312.3963448833558232d0)
        (i:convert (i:rgb 0.9004444986238855d0 0.06889215813209582d0 0.8774882563558897d0
                          :space 'i:bt470-pal/secam)
                   (i:make-color 'i:lchuv))))
