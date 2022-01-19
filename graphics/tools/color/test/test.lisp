(in-package #:mfiano.graphics.tools.color.test)

(defun to-canonical (color expected)
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
  (loop :for i :below 256 :by 32
        :do (to-canonical (c:alpha i) (make-list 4 :initial-element (* i 257)))))

(subtest "Canonicalize: Alpha 16bpc"
  (loop :for i :below 256 :by 32
        :for a := (* i 256)
        :do (to-canonical (c:alpha a :bpc 16) (make-list 4 :initial-element a))))

(subtest "Canonicalize: CMYK 8bpc"
  (to-canonical (c:cmyk 21 56 221 179) '(17923 15242 2604 65535))
  (to-canonical (c:cmyk 244 114 231 42) '(2361 30268 5152 65535))
  (to-canonical (c:cmyk 192 201 181 14) '(15302 13116 17973 65535))
  (to-canonical (c:cmyk 71 9 72 54) '(37274 49833 37071 65535))
  (to-canonical (c:cmyk 119 209 233 50) '(28098 9503 4545 65535))
  (to-canonical (c:cmyk 230 51 150 43) '(5341 43587 22434 65535))
  (to-canonical (c:cmyk 79 22 223 94) '(28558 37807 5192 65535))
  (to-canonical (c:cmyk 239 106 84 161) '(1515 14115 16200 65535))
  (to-canonical (c:cmyk 68 156 197 19) '(44478 23547 13795 65535))
  (to-canonical (c:cmyk 235 48 138 222) '(665 6884 3891 65535))
  (to-canonical (c:cmyk 102 105 159 222) '(5088 4988 3192 65535))
  (to-canonical (c:cmyk 116 192 19 187) '(9526 4317 16173 65535))
  (to-canonical (c:cmyk 59 89 166 231) '(4740 4015 2152 65535))
  (to-canonical (c:cmyk 203 59 17 17) '(12473 47013 57088 65535))
  (to-canonical (c:cmyk 30 250 102 168) '(19728 438 13415 65535))
  (to-canonical (c:cmyk 216 62 141 245) '(393 1945 1148 65535)))

(subtest "Canonicalize: CMYK 16bpc"
  (to-canonical (c:cmyk (* 21 #x101) (* 56 #x101) (* 221 #x101) (* 179 #x101) :bpc 16)
                '(17923 15242 2604 65535))
  (to-canonical (c:cmyk (* 244 #x101) (* 114 #x101) (* 231 #x101) (* 42 #x101) :bpc 16)
                '(2361 30268 5152 65535))
  (to-canonical (c:cmyk (* 192 #x101) (* 201 #x101) (* 181 #x101) (* 14 #x101) :bpc 16)
                '(15302 13116 17973 65535))
  (to-canonical (c:cmyk (* 71 #x101) (* 9 #x101) (* 72 #x101) (* 54 #x101) :bpc 16)
                '(37274 49833 37071 65535))
  (to-canonical (c:cmyk (* 119 #x101) (* 209 #x101) (* 233 #x101) (* 50 #x101) :bpc 16)
                '(28098 9503 4545 65535))
  (to-canonical (c:cmyk (* 230 #x101) (* 51 #x101) (* 150 #x101) (* 43 #x101) :bpc 16)
                '(5341 43587 22434 65535))
  (to-canonical (c:cmyk (* 79 #x101) (* 22 #x101) (* 223 #x101) (* 94 #x101) :bpc 16)
                '(28558 37807 5192 65535))
  (to-canonical (c:cmyk (* 239 #x101) (* 106 #x101) (* 84 #x101) (* 161 #x101) :bpc 16)
                '(1515 14115 16200 65535))
  (to-canonical (c:cmyk (* 68 #x101) (* 156 #x101) (* 197 #x101) (* 19 #x101) :bpc 16)
                '(44478 23547 13795 65535))
  (to-canonical (c:cmyk (* 235 #x101) (* 48 #x101) (* 138 #x101) (* 222 #x101) :bpc 16)
                '(665 6884 3891 65535))
  (to-canonical (c:cmyk (* 102 #x101) (* 105 #x101) (* 159 #x101) (* 222 #x101) :bpc 16)
                '(5088 4988 3192 65535))
  (to-canonical (c:cmyk (* 116 #x101) (* 192 #x101) (* 19 #x101) (* 187 #x101) :bpc 16)
                '(9526 4317 16173 65535))
  (to-canonical (c:cmyk (* 59 #x101) (* 89 #x101) (* 166 #x101) (* 231 #x101) :bpc 16)
                '(4740 4015 2152 65535))
  (to-canonical (c:cmyk (* 203 #x101) (* 59 #x101) (* 17 #x101) (* 17 #x101) :bpc 16)
                '(12473 47013 57088 65535))
  (to-canonical (c:cmyk (* 30 #x101) (* 250 #x101) (* 102 #x101) (* 168 #x101) :bpc 16)
                '(19728 438 13415 65535))
  (to-canonical (c:cmyk (* 216 #x101) (* 62 #x101) (* 141 #x101) (* 245 #x101) :bpc 16)
                '(393 1945 1148 65535)))

(finalize)
