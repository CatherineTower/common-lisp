(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Convert > RGB (Bruce RGB)"
  :parent "Color > Convert"
  (p:is color=
        (i:xyz 0.2809016442314912d0 0.3004759241082804d0 0.8280719105913972d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:xyz))
  (p:is color=
        (i:xyy 0.1992988386107376d0 0.2131867290029728d0 0.3004759241082804d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:xyy))
  (p:is color=
        (i:lab 61.69526442104498d0 -1.8391610392906044d0 -48.59605960773949d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:lab))
  (p:is color=
        (i:lchab 61.69526442104498d0 48.63084949625509d0 267.83262472411974d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:lchab))
  (p:is color=
        (i:luv 61.69526442104498d0 -34.747141059184756d0 -77.37194388690675d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:luv))
  (p:is color=
        (i:lchuv 61.69526442104498d0 84.81616303880723d0 245.81552070689162d0)
        (i:convert-color
         (i:rgb 0.2979828292665525d0 0.6006607749291795d0 0.9075950974778275d0
                :space 'i:bruce-rgb)
         'i:lchuv)))
