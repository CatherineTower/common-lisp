(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > HSL"
  :parent "Color > Convert"
  :compile-at :execute
  (p:is color=
        (i:rgb 0.6796412876090989d0 0.8892663015168792d0 0.7112480160606455d0)
        (i:convert-color
         (i:hsl 129.0466479726845d0 0.4862646815859608d0 0.7844537945629892d0)
         'i:rgb))
  (p:is color=
        (i:hsl 221.36110606308378d0 0.1398757896657044d0 0.3615236144757685d0)
        (i:convert-color
         (i:rgb 0.3109552134181708d0 0.3423731822139042d0 0.4120920155333663d0)
         'i:hsl)))
