(in-package #:mfiano.graphics.tools.color)

(defstruct (color
            (:constructor nil)
            (:conc-name nil)
            (:predicate nil)
            (:copier nil)))

(defstruct (rgb8
            (:include color)
            (:constructor rgb8 (r g b))
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub8)
  (g 0 :type u:ub8)
  (b 0 :type u:ub8))

(defstruct (rgb16
            (:include color)
            (:constructor rgb16 (r g b))
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub16)
  (g 0 :type u:ub16)
  (b 0 :type u:ub16))

(defstruct (rgba8
            (:include rgb8)
            (:constructor rgba8 (r g b a))
            (:predicate nil)
            (:copier nil))
  (a 0 :type u:ub8))

(defstruct (rgba8-pma
            (:include rgba8)
            (:constructor rgba8-pma (r g b a))
            (:predicate nil)
            (:copier nil)))

(defstruct (rgba16
            (:include rgb16)
            (:constructor rgba16 (r g b a))
            (:predicate nil)
            (:copier nil))
  (a 0 :type u:ub16))

(defstruct (rgba16-pma
            (:include rgba16)
            (:constructor rgba16-pma (r g b a))
            (:predicate nil)
            (:copier nil)))

(defstruct (gray8
            (:include color)
            (:constructor gray8 (value))
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub8))

(defstruct (gray16
            (:include color)
            (:constructor gray16 (value))
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub16))

(defstruct (alpha8
            (:include color)
            (:constructor alpha8 (alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xff :type u:ub8))

(defstruct (alpha16
            (:include color)
            (:constructor alpha16 (alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xffff :type u:ub16))

(defstruct (gray-alpha8
            (:include gray8)
            (:constructor gray-alpha8 (value alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xff :type u:ub8))

(defstruct (gray-alpha16
            (:include gray16)
            (:constructor gray-alpha16 (value alpha))
            (:predicate nil)
            (:copier nil))
  (alpha #xffff :type u:ub16))
