(in-package #:mfiano.graphics.image.test)

(p:define-test "Color > Difference"
  :parent "Color"
  :compile-at :execute
  (p:with-fixtures '(*float-tolerance*)
    (setf *float-tolerance* 1d-4)
    (p:is float=
          2.0424d0
          (i:color-difference (i:lab 50d0 2.6772d0 -79.7751d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          2.8615d0
          (i:color-difference (i:lab 50d0 3.1571d0 -77.2803d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          3.4412d0
          (i:color-difference (i:lab 50d0 2.8361d0 -74.02d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 -1.3802d0 -84.2814d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 -1.1848d0 -84.8006d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 -0.9009d0 -85.5211d0)
                              (i:lab 50d0 0d0 -82.7485d0)))
    (p:is float=
          2.3669d0
          (i:color-difference (i:lab 50d0 0d0 0d0)
                              (i:lab 50d0 -1d0 2d0)))
    (p:is float=
          2.3669d0
          (i:color-difference (i:lab 50d0 -1d0 2d0)
                              (i:lab 50d0 0d0 0d0)))
    (p:is float=
          7.1792d0
          (i:color-difference (i:lab 50d0 2.49d0 -0.001d0)
                              (i:lab 50d0 -2.49d0 -0.0009d0)))
    (p:is float=
          7.1792d0
          (i:color-difference (i:lab 50d0 2.49d0 -0.001d0)
                              (i:lab 50d0 -2.49d0 0.001d0)))
    (p:is float=
          7.2195d0
          (i:color-difference (i:lab 50d0 2.49d0 -0.001d0)
                              (i:lab 50d0 -2.49d0 0.0011d0)))
    (p:is float=
          7.2195d0
          (i:color-difference (i:lab 50d0 2.49d0 -0.001d0)
                              (i:lab 50d0 -2.49d0 0.0012d0)))
    (p:is float=
          4.8045d0
          (i:color-difference (i:lab 50d0 -0.001d0 2.49d0)
                              (i:lab 50d0 0.0009d0 -2.49d0)))
    (p:is float=
          4.8045d0
          (i:color-difference (i:lab 50d0 -0.001d0 2.49d0)
                              (i:lab 50d0 0.001d0 -2.49d0)))
    (p:is float=
          4.7461d0
          (i:color-difference (i:lab 50d0 -0.001d0 2.49d0)
                              (i:lab 50d0 0.0011d0 -2.49d0)))
    (p:is float=
          4.3065d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 50d0 0d0 -2.5d0)))
    (p:is float=
          27.1492d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 73d0 25d0 -18d0)))
    (p:is float=
          22.8977d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 61d0 -5d0 29d0)))
    (p:is float=
          31.9030d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 56d0 -27d0 -3d0)))
    (p:is float=
          19.4535d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 58d0 24d0 15d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 50d0 3.1736d0 0.5854d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 50d0 3.2972d0 0d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 50d0 1.8634d0 0.5757d0)))
    (p:is float=
          1d0
          (i:color-difference (i:lab 50d0 2.5d0 0d0)
                              (i:lab 50d0 3.2592d0 0.335d0)))
    (p:is float=
          1.2644d0
          (i:color-difference (i:lab 60.2574d0 -34.0099d0 36.2677d0)
                              (i:lab 60.4626d0 -34.1751d0 39.4387d0)))
    (p:is float=
          1.263d0
          (i:color-difference (i:lab 63.0109d0 -31.0961d0 -5.8663d0)
                              (i:lab 62.8187d0 -29.7946d0 -4.0864d0)))
    (p:is float=
          1.8731d0
          (i:color-difference (i:lab 61.2901d0 3.7196d0 -5.3901d0)
                              (i:lab 61.4292d0 2.248d0 -4.962d0)))
    (p:is float=
          1.8645d0
          (i:color-difference (i:lab 35.0831d0 -44.1164d0 3.7933d0)
                              (i:lab 35.0232d0 -40.0716d0 1.5901d0)))
    (p:is float=
          2.0373d0
          (i:color-difference (i:lab 22.7233d0 20.0904d0 -46.694d0)
                              (i:lab 23.0331d0 14.973d0 -42.5619d0)))
    (p:is float=
          1.4146d0
          (i:color-difference (i:lab 36.4612d0 47.858d0 18.3852d0)
                              (i:lab 36.2715d0 50.5065d0 21.2231d0)))
    (p:is float=
          1.4441d0
          (i:color-difference (i:lab 90.8027d0 -2.0831d0 1.441d0)
                              (i:lab 91.1528d0 -1.6435d0 0.0447d0)))
    (p:is float=
          1.5381d0
          (i:color-difference (i:lab 90.9257d0 -0.5406d0 -0.9208d0)
                              (i:lab 88.6381d0 -0.8985d0 -0.7239d0)))
    (p:is float=
          0.6377d0
          (i:color-difference (i:lab 6.7747d0 -0.2908d0 -2.4247d0)
                              (i:lab 5.8714d0 -0.0985d0 -2.2286d0)))
    (p:is float=
          0.9082d0
          (i:color-difference (i:lab 2.0776d0 0.0795d0 -1.135d0)
                              (i:lab 0.9033d0 -0.0636d0 -0.5514d0)))))
