(in-package #:mfiano.graphics.tools.color.test)

(defun test/canonicalize (color expected)
  (let ((result (multiple-value-list (c:decompose (c::canonicalize color)))))
    (is result
        expected
        (format nil "~a ~dbpc: ~{~d~^, ~} -> RGBA 16bpc PMA: ~{~d~^, ~}"
                (class-name (class-of color))
                (c::bpc color)
                (multiple-value-list (c:decompose color))
                expected))))

(plan nil)

;;; Test that each color model can be converted to the canonical form.

(subtest "Canonicalize: Alpha 8bpc"
  (dotimes (i 16)
    (let* ((a (random #x100))
           (out (make-list 4 :initial-element (* a #x101))))
      (test/canonicalize (c:alpha8 a) out))))

(subtest "Canonicalize: Alpha 16bpc"
  (dotimes (i 16)
    (let* ((a (random (1+ (* i #x1000))))
           (out (make-list 4 :initial-element a)))
      (test/canonicalize (c:alpha16 a) out))))

(let ((ins '((21 56 221 179) (244 114 231 42) (192 201 181 14) (71 9 72 54)
             (119 209 233 50) (230 51 150 43) (79 22 223 94) (239 106 84 161)
             (68 156 197 19) (235 48 138 222) (102 105 159 222) (116 192 19 187)
             (59 89 166 231) (203 59 17 17) (30 250 102 168) (216 62 141 245)))
      (outs '((17923 15242 2604 65535) (2361 30268 5152 65535)
              (15302 13116 17973 65535) (37274 49833 37071 65535)
              (28098 9503 4545 65535) (5341 43587 22434 65535)
              (28558 37807 5192 65535) (1515 14115 16200 65535)
              (44478 23547 13795 65535) (665 6884 3891 65535)
              (5088 4988 3192 65535) (9526 4317 16173 65535)
              (4740 4015 2152 65535) (12473 47013 57088 65535)
              (19728 438 13415 65535) (393 1945 1148 65535))))
  (subtest "Canonicalize: CMYK 8bpc"
    (loop :for (c m y k) :in ins
          :for out :in outs
          :do (test/canonicalize (c:cmyk8 c m y k) out)))
  (subtest "Canonicalize: CMYK 16bpc"
    (loop :for in :in ins
          :for out :in outs
          :for (c m y k) := (mapcar (lambda (x) (* x #x101)) in)
          :do (test/canonicalize (c:cmyk16 c m y k) out))))

(subtest "Canonicalize: Gray 8bpc"
  (dotimes (i 16)
    (let* ((v (random #x100))
           (out (list (* v #x101) (* v #x101) (* v #x101) #xffff)))
      (test/canonicalize (c:gray8 v) out))))

(subtest "Canonicalize: Gray 16bpc"
  (dotimes (i 16)
    (let* ((v (random (1+ (* i #x1000))))
           (out (list v v v #xffff)))
      (test/canonicalize (c:gray16 v) out))))

(subtest "Canonicalize: Gray-Alpha 8bpc"
  (dotimes (i 16)
    (let* ((v (random #x100))
           (a (random #x100))
           (out (list (* v #x101) (* v #x101) (* v #x101) (* a #x101))))
      (test/canonicalize (c:gray-alpha8 v a) out))))

(subtest "Canonicalize: Gray-Alpha 16bpc"
  (dotimes (i 16)
    (let* ((v (random (1+ (* i #x1000))))
           (a (random (1+ (* i #x1000))))
           (out (list v v v a)))
      (test/canonicalize (c:gray-alpha16 v a) out))))

(subtest "Canonicalize: Indexed"
  (skip 1 "Indexed colors contain a palette of RGB colors, and so will be tested for RGB."))

(subtest "Canonicalize: RGB 8bpc"
  (dotimes (i 16)
    (let* ((r (random #x100))
           (g (random #x100))
           (b (random #x100))
           (out (list (* r #x101) (* g #x101) (* b #x101) #xffff)))
      (test/canonicalize (c:rgb8 r g b) out))))

(subtest "Canonicalize: RGB 16bpc"
  (dotimes (i 16)
    (let* ((r (random (1+ (* i #x1000))))
           (g (random (1+ (* i #x1000))))
           (b (random (1+ (* i #x1000))))
           (out (list r g b #xffff)))
      (test/canonicalize (c:rgb16 r g b) out))))

(subtest "Canonicalize: RGBA 8bpc"
  (dotimes (i 16)
    (let* ((r (random #x100))
           (g (random #x100))
           (b (random #x100))
           (a (random #x100))
           (out (list (truncate (* r a #x101) #xff)
                      (truncate (* g a #x101) #xff)
                      (truncate (* b a #x101) #xff)
                      (* a #x101))))
      (test/canonicalize (c:rgba8 r g b a) out))))

(subtest "Canonicalize: RGBA 16bpc"
  (dotimes (i 16)
    (let* ((r (random (1+ (* i #x1000))))
           (g (random (1+ (* i #x1000))))
           (b (random (1+ (* i #x1000))))
           (a (random (1+ (* i #x1000))))
           (out (list (truncate (* r a) #xffff)
                      (truncate (* g a) #xffff)
                      (truncate (* b a) #xffff)
                      a)))
      (test/canonicalize (c:rgba16 r g b a) out))))

(subtest "Canonicalize: RGBA 8bpc, pre-multiplied alpha"
  (dotimes (i 16)
    (let* ((r (random #x100))
           (g (random #x100))
           (b (random #x100))
           (a (random #x100))
           (out (mapcan (lambda (x) (list (* x #x101))) (list r g b a))))
      (test/canonicalize (c:rgba8-pma r g b a) out))))

(subtest "Canonicalize: RGBA 16bpc, pre-multiplied alpha"
  (dotimes (i 16)
    (let* ((r (random (1+ (* i #x1000))))
           (g (random (1+ (* i #x1000))))
           (b (random (1+ (* i #x1000))))
           (a (random (1+ (* i #x1000))))
           (out (list r g b a)))
      (test/canonicalize (c:rgba16-pma r g b a) out))))

(finalize)
