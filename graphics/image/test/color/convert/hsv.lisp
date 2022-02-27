(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > HSV"
  :parent "Color > Convert"
  (p:is color=
        (i:rgb 0.5212434243086167d0 0.6051541197010493d0 0.6469162196190497d0)
        (i:convert-color
         (i:hsv 199.93849177055742d0 0.1942644062695449d0 0.6469162196190497d0)
         'i:rgb))
  (p:is color=
        (i:hsv 211.27472639485947d0 0.5672613464262009d0 0.9004444986238855d0)
        (i:convert-color
         (i:rgb 0.3896571399524349d0 0.6341989171505094d0 0.9004444986238855d0)
         'i:hsv)))
