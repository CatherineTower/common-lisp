(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Ekta Space PS 5)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2778475987785322d0 0.5668716729513777d0 0.5595321876489582d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:xyz)))
  (p:is color=
        (i:xyy 0.1978617126746163d0 0.4036824524306478d0 0.5668716729513777d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:xyy)))
  (p:is color=
        (i:lab 80.00331755111789d0 -83.55343638626772d0 -10.183340124011032d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lab)))
  (p:is color=
        (i:lchab 80.00331755111789d0 84.17171227933633d0 186.9488334723535d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lchab)))
  (p:is color=
        (i:luv 80.00331755111789d0 -107.02334170545666d0 -0.3170151632470488d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:luv)))
  (p:is color=
        (i:lchuv 80.00331755111789d0 107.0238112216934d0 180.1697160402891d0)
        (i:convert (i:rgb 0.09574184262171914d0 0.8854733764856817d0 0.8354879062437013d0
                          :space 'i:ekta-space-ps5)
                   (i:make-color 'i:lchuv))))
