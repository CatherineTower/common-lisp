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
  '(rgb (xyz (xyy) (luv lchuv) (lab lchab))))

(defparameter *xyz-transform-paths*
  '(xyz (lab lchab) (luv lchuv) (rgb) (xyy)))

(defparameter *xyy-transform-paths*
  '(xyy (xyz (rgb) (lab lchab) (luv lchuv))))

(defparameter *lab-transform-paths*
  '(lab (lchab) (xyz (luv lchuv) (xyy) (rgb))))

(defparameter *luv-transform-paths*
  '(luv (lchuv) (xyz (lab lchab) (xyy) (rgb))))

(defparameter *lchab-transform-paths*
  '(lchab (lab (xyz (luv lchuv) (xyy) (rgb)))))

(defparameter *lchuv-transform-paths*
  '(lchuv (luv (xyz (lab lchab) (xyy) (rgb)))))

(defparameter *transform-paths*
  `((rgb . ,*rgb-transform-paths*)
    (xyz . ,*xyz-transform-paths*)
    (xyy . ,*xyy-transform-paths*)
    (lab . ,*lab-transform-paths*)
    (luv . ,*luv-transform-paths*)
    (lchab . ,*lchab-transform-paths*)
    (lchuv . ,*lchuv-transform-paths*)))

(defun transform-paths-for (model)
  (cdr (assoc model *transform-paths* :test #'eq)))

(defparameter *conversion-functions*
  `(((rgb xyz) . ,#'%rgb-xyz)
    ((xyz rgb) . ,#'%xyz->rgb)
    ((luv xyz) . ,#'luv->xyz)
    ((xyz luv) . ,#'xyz->luv)))

(defun conversion-function-for (from-type to-type)
  (cdr (assoc (list from-type to-type)
              *conversion-functions*
              :test #'equal)))
