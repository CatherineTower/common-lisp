(in-package #:mfiano.graphics.patchwork)

(defclass rect (bin:rect)
  ((%file :reader file
          :initarg :file)))

(defmethod binpack:rect-initargs append ((r rect))
  (list :file (file r)))

(defun rect (file id x y w h)
  (make-instance 'rect :file file :id id :x x :y y :w w :h h))

(defun make-id (root file)
  (flet ((replace-tilde (path)
           (let ((namestring (namestring path)))
             (if (char= (char namestring 0) #\~)
                 (uiop:merge-pathnames*
                  (uiop:relativize-pathname-directory
                   (subseq namestring 1))
                  (user-homedir-pathname))
                 (values (parse-namestring path))))))
    (namestring
     (make-pathname
      :defaults
      (uiop/pathname:enough-pathname
       (replace-tilde file)
       (uiop/pathname:ensure-directory-pathname (replace-tilde root)))
      :type nil))))

(defun collect-files (path &key recursive)
  (let ((files))
    (u:map-files
     path
     (lambda (x) (push (cons x (make-id path x)) files))
     :recursive-p recursive)
    (reverse files)))

(defun make-rects (files)
  (loop :for (file . id) :in files
        :for image = (pngload:load-file file :decode nil)
        :for width = (pngload:width image)
        :for height = (pngload:height image)
        :collect (rect file id 0 0 width height)))

(defun add-padding (rects padding)
  (when (and padding (plusp padding))
    (dolist (rect rects)
      (incf (bin:w rect) padding)
      (incf (bin:h rect) padding)))
  rects)

(defun remove-padding (rects padding)
  (when (and padding (plusp padding))
    (loop :with padding/2 = (floor padding 2)
          :for rect :in rects
          :do (incf (bin:x rect) padding/2)
              (incf (bin:y rect) padding/2)
              (decf (bin:w rect) padding)
              (decf (bin:h rect) padding)))
  rects)

(defgeneric make-coords (rect width height normalize flip-y)
  (:method (rect width height normalize flip-y)
    (let ((y (if flip-y (- height (bin:y rect) (bin:h rect)) (bin:y rect))))
      (list :x (bin:x rect)
            :y y
            :w (bin:w rect)
            :h (bin:h rect)
            :normalized nil
            :y-inverted flip-y)))
  (:method (rect width height (normalize (eql t)) flip-y)
    (let ((y (if flip-y (- height (bin:y rect) (bin:h rect)) (bin:y rect))))
      (list :x (float (/ (bin:x rect) width))
            :y (float (/ y height))
            :w (float (/ (bin:w rect) width))
            :h (float (/ (bin:h rect) height))
            :normalized t
            :y-inverted flip-y))))

(defun write-atlas (atlas sprite rect)
  (let ((sprite (opticl:coerce-image sprite 'opticl:rgba-image)))
    (opticl:do-pixels (i j) sprite
      (setf (opticl:pixel atlas (+ i (bin:y rect)) (+ j (bin:x rect)))
            (opticl:pixel sprite i j)))))

(defun write-metadata (data spec-path)
  (let ((data (sort data #'string< :key (lambda (x) (getf x :id)))))
    (u:with-file-output (out spec-path)
      (write data :stream out))))

(defun make-atlas (file-spec &key out-file spec-file (width :auto) (height :auto)
                               normalize flip-y (padding 0) (optimize-pack nil)
                               (auto-size-granularity-x 1)
                               (auto-size-granularity-y 1))
  "Pack the sprites defined by FILE-SPEC into a spritesheet.

OUT-FILE: A pathname specifying where to write the image file.

SPEC-FILE: A pathname specifying where to write the metadata file. If
unspecified, it is written to the same directory as OUT-FILE.

WIDTH: The width in pixels of the spritesheet. :AUTO to calculate width
automatically.

HEIGHT: The height in pixels of the spritesheet. :AUTO to calculate height
automatically.

NORMALIZE: Boolean specifying whether to map the metadata's coordinates to the
[0..1] range.

FLIP-Y: Boolean specifying whether to flip the Y axis when writing the metadata.

PADDING: The padding in pixels to use around each sprite in the spritesheet.

OPTIMIZE-PACK: Calculate size automatically, and try multiple sizes to find a
better size. (ignores WIDTH, HEIGHT if set)

AUTO-SIZE-GRANULARITY-X, AUTO-SIZE-GRANULARITY-Y: Automatically generated sizes
will be multiples of these.

See MAKE-ATLAS-FROM-DIRECTORY if you want to automatically generate FILE-SPEC
from the files under a given filesystem path.
"
  (loop :with rects = (add-padding (make-rects file-spec) padding)
        :with (packed packed-width packed-height)
          = (multiple-value-list
             (binpack:auto-pack rects
                                :width width
                                :height height
                                :auto-size-granularity-x auto-size-granularity-x
                                :auto-size-granularity-y auto-size-granularity-y
                                :optimize-pack optimize-pack))
        :with atlas = (opticl:make-8-bit-rgba-image
                       (if (numberp height) height packed-height)
                       (if (numberp width) width packed-width))
        :with spec-file = (or spec-file
                              (make-pathname :defaults out-file :type "spec"))
        :for rect :in (remove-padding packed padding)
        :for sprite = (opticl:read-png-file (file rect))
        :for coords = (make-coords rect
                                   packed-width
                                   packed-height
                                   normalize
                                   flip-y)
        :do (write-atlas atlas sprite rect)
        :collect `(:id ,(bin:id rect) ,@coords) :into data
        :finally (return
                   (values (write-metadata data spec-file)
                           (opticl:write-image-file out-file atlas)))))

(defun make-atlas-from-directory (path &key recursive out-file spec-file
                                         (width :auto) (height :auto) normalize
                                         flip-y (padding 0)
                                         (auto-size-granularity-x 1)
                                         (auto-size-granularity-y 1)
                                         (optimize-pack nil))
  "Pack the sprites located under the given filesystem path, PATH.

RECURSIVE: Boolean specifying whether to scan recursively for files.

OUT-FILE: A pathname specifying where to write the image file.

SPEC-FILE: A pathname specifying where to write the metadata file. If
unspecified, it is written to the same directory as OUT-FILE.

WIDTH: The width in pixels of the spritesheet. :AUTO to calculate width
automatically.

HEIGHT: The height in pixels of the spritesheet. :AUTO to calculate height
automatically.

NORMALIZE: Boolean specifying whether to normalize the metadata's coordinates in
the [0..1] range.

FLIP-Y: Boolean specifying whether to flip the Y axis when writing the metadata.

PADDING: The padding in pixels to use around each sprite in the spritesheet.

OPTIMIZE-PACK: Calculate size automatically, and try multiple sizes to find a
better size. (ignores WIDTH, HEIGHT if set)

AUTO-SIZE-GRANULARITY-X, AUTO-SIZE-GRANULARITY-Y: Automatically generated sizes
will be multiples of these.

See MAKE-ATLAS if you want to manually specify a file-spec, in case you want to
be in control of the names chosen to identify the sprites written to the
metadata file.
"
  (let ((file-spec (collect-files path :recursive recursive)))
    (make-atlas file-spec
                :out-file out-file
                :spec-file spec-file
                :width width
                :height height
                :normalize normalize
                :flip-y flip-y
                :padding padding
                :auto-size-granularity-x auto-size-granularity-x
                :auto-size-granularity-y auto-size-granularity-y
                :optimize-pack optimize-pack)))
