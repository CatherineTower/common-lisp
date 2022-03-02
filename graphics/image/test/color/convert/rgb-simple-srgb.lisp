(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Simple sRGB)"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:xyz 0.0614782149106999d0 0.0309306377550514d0 0.1261300056825786d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.2813147985458473d0 0.1415338122877488d0 0.0309306377550514d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:xyy))
  (p:is color=
        (i:lab 20.412817193922066d0 43.75893463334951d0 -34.712274927707156d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:lab))
  (p:is color=
        (i:lchab 20.412817193922066d0 55.85504803419725d0 321.5763886449412d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:lchab))
  (p:is color=
        (i:luv 20.412817193922066d0 19.703440067714386d0 -42.54775066251186d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:luv))
  (p:is color=
        (i:lchuv 20.412817193922066d0 46.888555500690046d0 294.84838523966806d0)
        (i:convert-color
         (i:rgb 0.3326775911243629d0 0.07825302383771171d0 0.396211455210826d0
                :space 'i:simple-srgb)
         'i:lchuv)))
