(in-package :defpackage+-user-1)

(defpackage+ #:shadow
  (:use #:cl)
  (:inherit #:vari)
  (:export #:defun-gpu
           #:defstruct-gpu
           #:defmacro-gpu
           #:enable-dependency-tracking
           #:disable-dependency-tracking
           #:reset-program-state
           #:define-shader
           #:find-program
           #:view-source
           #:build-shader-program
           #:build-shader-programs
           #:build-shader-dictionary
           #:translate-shader-programs
           #:set-modify-hook
           #:create-block-alias
           #:find-block
           #:bind-block
           #:unbind-block
           #:buffer-name
           #:create-buffer
           #:bind-buffer
           #:unbind-buffer
           #:delete-buffer
           #:write-buffer-path
           #:with-shader-program
           #:uniforms
           #:uniform-int
           #:uniform-int-array
           #:uniform-float
           #:uniform-float-array
           #:uniform-vec2
           #:uniform-vec2-array
           #:uniform-vec3
           #:uniform-vec3-array
           #:uniform-vec4
           #:uniform-vec4-array
           #:uniform-mat2
           #:uniform-mat2-array
           #:uniform-mat3
           #:uniform-mat3-array
           #:uniform-mat4
           #:uniform-mat4-array))

(defpackage+ #:shadow.lang
  (:inherit-except #:box.math.vari #:defun #:defstruct #:defmacro)
  (:export #:defun
           #:defstruct
           #:defmacro))
