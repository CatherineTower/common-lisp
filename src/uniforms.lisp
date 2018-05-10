(in-package :shadow)

(defgeneric get-uniform-data (type parts)
  (:method (type parts)
    (list (list (reverse parts) (varjo:type->type-spec type)))))

(defmethod get-uniform-data ((type varjo:v-user-struct) parts)
  (cons
   (list (reverse parts) (varjo:type->type-spec type))
   (loop :for (slot-name slot-type . nil) :in (varjo.internals:v-slots type)
         :append (get-uniform-data slot-type (cons slot-name parts)))))

(defmethod get-uniform-data ((type varjo:v-array) parts)
  (loop :with dimensions = (first (varjo:v-dimensions type))
        :with element-type = (varjo:v-element-type type)
        :for i :below dimensions
        :when (zerop i)
          :collect (list (reverse parts) (cons (varjo:type->type-spec element-type) dimensions))
        :append (get-uniform-data element-type (cons i parts))))

(defun store-uniforms (program stage)
  (flet ((%get-uniforms (stage)
           (loop :for uniform :in (varjo:uniform-variables stage)
                 :for type = (varjo:v-type-of uniform)
                 :unless (or (has-qualifier-p uniform :ubo)
                             (has-qualifier-p uniform :ssbo))
                   :append (get-uniform-data type (list (varjo:name uniform))))))
    (loop :for (parts type-spec) :in (%get-uniforms stage)
          :for id = (ensure-keyword (parts->string parts))
          :do (setf (au:href (uniforms program) id)
                    (make-stage-variable
                     :name (parts->string parts #'varjo.internals:safe-glsl-name-string)
                     :type type-spec)))))

(defun store-uniform-locations (program)
  (let ((id (id program)))
    (gl:use-program id)
    (au:maphash-values
     (lambda (x)
       (setf (stage-variable-location x) (gl:get-uniform-location id (stage-variable-name x))))
     (uniforms program))
    (gl:use-program 0)))

(defun get-uniform-location (uniform)
  (stage-variable-location (au:href (uniforms *active-shader-program*) uniform)))

(defmacro %uniform-array (location func component-count element-type sequence)
  (au:with-unique-names (count sv)
    `(let ((,count (length ,sequence)))
       (static-vectors:with-static-vector
           (,sv (* ,count ,component-count)
                :element-type ',element-type)
         ,(if (= component-count 1)
              `(replace ,sv ,sequence)
              `(let ((i 0))
                 (map nil
                      (lambda (x)
                        (replace ,sv x :start1 i)
                        (incf i ,component-count))
                      ,sequence)))
         (,func ,location ,count (static-vectors:static-vector-pointer ,sv))))))

(defun uniform-int (uniform value)
  "Specify an integer as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%gl:uniform-1i location value)))

(defun uniform-int-array (uniform value)
  "Specify an array of integers as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%uniform-array location %gl:uniform-1iv 1 (unsigned-byte 32) value)))

(defun uniform-float (uniform value)
  "Specify a float as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%gl:uniform-1f location value)))

(defun uniform-float-array (uniform value)
  "Specify an array of floats as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%uniform-array location %gl:uniform-1fv 1 single-float value)))

(defun uniform-vec2 (uniform value)
  "Specify a vec2 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%gl:uniform-2f location (aref value 0) (aref value 1))))

(defun uniform-vec2-array (uniform value)
  "Specify an array of vec2's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%uniform-array location %gl:uniform-2fv 2 single-float value)))

(defun uniform-vec3 (uniform value)
  "Specify a vec3 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%gl:uniform-3f location (aref value 0) (aref value 1) (aref value 2))))

(defun uniform-vec3-array (uniform value)
  "Specify an array of vec3's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%uniform-array location %gl:uniform-3fv 3 single-float value)))

(defun uniform-vec4 (uniform value)
  "Specify a vec4 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%gl:uniform-4f location (aref value 0) (aref value 1) (aref value 2) (aref value 3))))

(defun uniform-vec4-array (uniform value)
  "Specify an array of vec4's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (%uniform-array location %gl:uniform-4fv 4 single-float value)))

(defun uniform-mat2 (uniform value)
  "Specify a mat2 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix-2fv location value nil)))

(defun uniform-mat2-array (uniform value)
  "Specify an array of mat2's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix location 2 value nil)))

(defun uniform-mat3 (uniform value)
  "Specify a mat3 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix-3fv location value nil)))

(defun uniform-mat3-array (uniform value)
  "Specify an array of mat3's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix location 3 value nil)))

(defun uniform-mat4 (uniform value)
  "Specify a mat4 as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix-4fv location value nil)))

(defun uniform-mat4-array (uniform value)
  "Specify an array of mat4's as the VALUE for the uniform variable, UNIFORM."
  (let ((location (get-uniform-location uniform)))
    (gl:uniform-matrix location 4 value nil)))
