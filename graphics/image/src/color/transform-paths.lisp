(in-package :%mfiano.graphics.image.color)

(defun find-transform-path (destination paths)
  (labels ((%find-transform-path (node result)
             (cond ((null node) nil)
                   ((and (consp node) (atom (car node))
                         (let ((current (car node)))
                           (if (eq destination current)
                               (cons current result)
                               (%find-transform-path (cdr node)
                                                     (cons current result))))))
                   ((and (consp node) (consp (car node)))
                    (or (%find-transform-path (car node) result)
                        (%find-transform-path (cdr node) result)))
                   (t (if (eq destination node)
                          (cons node result)
                          nil)))))
    (nreverse (%find-transform-path paths nil))))

(defparameter *rgb-transform-paths*
  '(rgb (xyz (xyy) (luv lchuv) (cielab lchab))))

(defparameter *xyz-transform-paths*
  '(xyz (cielab lchab) (luv lchuv) (rgb) (xyy)))

(defparameter *xyy-transform-paths*
  '(xyy (xyz (rgb) (cielab lchab) (luv lchuv))))

(defparameter *cielab-transform-paths*
  '(cielab (lchab) (xyz (luv lchuv) (xyy) (rgb))))

(defparameter *luv-transform-paths*
  '(luv (lchuv) (xyz (cielab lchab) (xyy) (rgb))))

(defparameter *lchab-transform-paths*
  '(lchab (cielab (xyz (luv lchuv) (xyy) (rgb)))))

(defparameter *lchuv-transform-paths*
  '(lchuv (luv (xyz (cielab lchab) (xyy) (rgb)))))

(defparameter *transform-paths*
  `((rgb . ,*rgb-transform-paths*)
    (xyz . ,*xyz-transform-paths*)
    (xyy . ,*xyy-transform-paths*)
    (cielab . ,*cielab-transform-paths*)
    (luv . ,*luv-transform-paths*)
    (lchab . ,*lchab-transform-paths*)
    (lchuv . ,*lchuv-transform-paths*)))

(defun transform-paths-for (model)
  (cdr (assoc model *transform-paths* :test #'eq)))

(defparameter *conversion-functions*
  `(((rgb xyz) . ,#'rgb->xyz)
    ((xyz rgb) . ,#'xyz->rgb)
    ((luv xyz) . ,#'luv->xyz)
    ((xyz luv) . ,#'xyz->luv)
    ((cielab xyz) . ,#'cielab->xyz)
    ((xyz cielab) . ,#'xyz->cielab)))

(defun conversion-function-for (from-type to-type)
  (cdr (assoc (list from-type to-type)
              *conversion-functions*
              :test #'equal)))

(defmethod base:convert ((from model) (to model))
  (let* ((from-name (class-name (class-of from)))
         (to-name (class-name (class-of to)))
         (path (find-transform-path to-name (transform-paths-for from-name))))
    (loop for sublist on path
          for current-model = (first sublist)
          for next-model = (second sublist)
          for current-color = from then temp-color
          for temp-color = (default-color next-model)
          for converter = (conversion-function-for current-model next-model)
          when (eq next-model to-name) do
            (return (funcall converter current-color to))
          do (funcall converter current-color temp-color))))
