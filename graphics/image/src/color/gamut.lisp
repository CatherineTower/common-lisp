(in-package #:%mfiano.graphics.image.color)

(defgeneric in-gamut-p (color))

(defmacro %define-simple-in-gamut-p-method (type (x-lower-bound x-upper-bound)
                                            (y-lower-bound y-upper-bound)
                                            (z-lower-bound z-upper-bound))
  (let ((channels-var (gensym)))
    `(defmethod in-gamut-p ((color ,type))
       (let ((,channels-var (channels color)))
         (and (<= ,x-lower-bound (v3:x ,channels-var) ,x-upper-bound)
              (<= ,y-lower-bound (v3:y ,channels-var) ,y-upper-bound)
              (<= ,z-lower-bound (v3:z ,channels-var) ,z-upper-bound))))))

(%define-simple-in-gamut-p-method rgb
    (0d0 1d0)
    (0d0 1d0)
    (0d0 1d0))

(%define-simple-in-gamut-p-method xyz
    (0d0 1d0)
    (0d0 1d0)
    (0d0 1d0))

(%define-simple-in-gamut-p-method luv
    (0d0 1d0)
    (-1d0 1d0)
    (-1d0 1d0))

(%define-simple-in-gamut-p-method lab
    (0d0 1d0)
    (-1d0 1d0)
    (-1d0 1d0))

(%define-simple-in-gamut-p-method lch-ab
    (0d0 1d0)
    (0d0 #.(* (sqrt 2d0) 200d0))
    (-360d0 360d0))

(%define-simple-in-gamut-p-method lch-uv
    (0d0 1d0)
    (0d0 #.(* (sqrt 2d0) 100d0))
    (-360d0 360d0))
