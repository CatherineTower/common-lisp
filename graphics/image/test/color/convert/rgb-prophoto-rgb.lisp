(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (ProPhoto RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.8101229374759039d0 0.5570439891980326d0 0.1601558982278273d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.5304202387782756d0 0.3647192198766893d0 0.5570439891980326d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 79.44528666338432d0 60.40318922786081d0 48.76491008541643d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 79.44528666338432d0 77.63093278156272d0 38.91475056206659d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 79.44528666338432d0 130.93037997252844d0 32.68725788481887d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 79.44528666338432d0 134.94895786103476d0 14.017569248730414d0)
        (i:convert-color
         (i:rgb 0.9661050361445147d0 0.6029093842410664d0 0.40219699921506d0
                :space 'i:prophoto-rgb)
         'i:lchuv)))
