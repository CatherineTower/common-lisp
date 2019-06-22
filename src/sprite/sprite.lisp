(in-package #:umbra.sprite)

(define-struct sprite-data
  (sampler :sampler-2d :accessor sampler)
  (index :int :accessor index))

(define-struct spritesheet-data
  (pos (:vec2 2048) :accessor pos)
  (size (:vec2 2048) :accessor size))

(define-function sprite/v ()
  (values))

(define-function sprite/g (&uniform
                           (model :mat4)
                           (view :mat4)
                           (proj :mat4)
                           (sprite sprite-data)
                           (spritesheet spritesheet-data :ssbo :std-430))
  (declare (output-primitive :kind :triangle-strip :max-vertices 6))
  (let* ((mvp (* proj view model))
         (extents (vec4 (aref (pos spritesheet) (index sprite))
                        (aref (size spritesheet) (index sprite))))
         (size (.xyxy (texture-size (sampler sprite) 0)))
         (offsets (* size (vec4 (* 0.5 (.zw extents)) (* -0.5 (.zw extents))))))
    (setf (.zw extents) (+ (.xy extents) (.zw extents)))
    (emit ()
          (* mvp (vec4 (.xy offsets) 0 1))
          (.xw extents))
    (emit ()
          (* mvp (vec4 (.zy offsets) 0 1))
          (.zw extents))
    (emit ()
          (* mvp (vec4 (.xw offsets) 0 1))
          (.xy extents))
    (emit ()
          (* mvp (vec4 (.zw offsets) 0 1))
          (.zy extents))
    (end-primitive))
  (values))

(define-function sprite/f ((uv :vec2)
                           &uniform
                           (opacity :float)
                           (sprite sprite-data))
  (let ((color (texture (sampler sprite) uv)))
    (if (zerop (.a color))
        (discard)
        (vec4 (.rgb color) opacity))))

(define-shader sprite (:primitive :points)
  (:vertex (sprite/v))
  (:geometry (sprite/g))
  (:fragment (sprite/f :vec2)))
