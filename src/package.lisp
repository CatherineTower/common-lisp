(in-package :defpackage+-user-1)

(defpackage+ #:umbra.common
  (:inherit #:cl #:shadow #:box.math.vari))

(defpackage+ #:umbra.math
  (:use #:umbra.common)
  (:export #:+epsilon+
           #:+pi+
           #:+half-pi+
           #:log10
           #:saturate))

(defpackage+ #:umbra.color
  (:use #:umbra.common #:umbra.math)
  ;; color space conversion
  (:export #:rgb->grayscale
           #:hue->rgb
           #:rgb->hcv
           #:rgb->hsv
           #:hsv->rgb
           #:rgb->hcy
           #:hcy->rgb
           #:rgb->hsl
           #:hsl-rgb
           #:rgb->srgb-approx
           #:rgb->srgb
           #:srgb->rgb-approx
           #:srgb->rgb
           #:rgb->xyz
           #:xyz->rgb
           #:xyy->xyz
           #:xyz->xyy
           #:rgb->xyy
           #:xyy->rgb)
  ;; color grading
  (:export #:set-exposure
           #:set-saturation
           #:set-contrast
           #:set-brightness
           #:set-gamma
           #:color-filter
           #:tone-map-linear
           #:tone-map-reinhard
           #:tone-map-haarm-peter-duiker
           #:tone-map-hejl-burgess-dawson
           #:tone-map-uncharted2))

(defpackage+ #:umbra.shaping
  (:use #:umbra.common #:umbra.math)
  (:export #:linear
           #:sine-out
           #:sine-in
           #:sine-in-out
           #:quadratic-out
           #:quadratic-in
           #:quadratic-in-out
           #:cubic-out
           #:cubic-in
           #:cubic-in-out
           #:quartic-out
           #:quartic-in
           #:quartic-in-out
           #:quintic-out
           #:quintic-in
           #:quintic-in-out
           #:exponential-out
           #:exponential-in
           #:exponential-in-out
           #:circular-out
           #:circular-in
           #:circular-in-out
           #:back-out
           #:back-in
           #:back-in-out
           #:elastic-out
           #:elastic-in
           #:elastic-in-out
           #:bounce-out
           #:bounce-in
           #:bounce-in-out
           #:almost-identity
           #:impulse
           #:cubic-pulse
           #:exponential-step
           #:gain
           #:parabola
           #:power-curve
           #:sinc-curve
           #:exponential-emphasis
           #:double-exponential-seat
           #:double-exponential-sigmoid
           #:logistic-sigmoid
           #:double-circle-seat
           #:double-circle-sigmoid
           #:double-elliptical-seat
           #:double-elliptical-sigmoid
           #:blinn-wyvill-raised-inverted-cosine
           #:double-cubic-seat
           #:double-cubic-seat/linear-blend
           #:double-odd-polynomial-seat
           #:quadratic-point
           #:hermite-curve
           #:quintic-curve
           #:quintic-curve/interpolate-derivative
           #:quintic-curv/derivative
           #:quintic-curve/fast
           #:quintic-hermite
           #:quintic-hermite/derivative
           #:falloff-squared-c1
           #:falloff-squared-c2))

(defpackage+ #:umbra.graph
  (:use #:umbra.common)
  (:export #:graph))

(defpackage+ #:umbra.hashing
  (:use #:umbra.common)
  (:export #:blum-blum-shub
           #:blum-blum-shub/hq
           #:permutation-polynomial
           #:fast32
           #:fast32-2))
