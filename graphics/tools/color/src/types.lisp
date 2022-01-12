(in-package #:mfiano.graphics.tools.color)

(defstruct (color
            (:constructor nil)
            (:conc-name nil)
            (:predicate nil)
            (:copier nil)))

(defstruct (rgba
            (:include color)
            (:constructor %rgba)
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub8)
  (g 0 :type u:ub8)
  (b 0 :type u:ub8)
  (a 0 :type u:ub8))

(defstruct (rgba-pma
            (:include rgba)
            (:constructor %rgba-pma)
            (:predicate nil)
            (:copier nil)))

(defstruct (rgba16
            (:include color)
            (:constructor %rgba16)
            (:predicate nil)
            (:copier nil))
  (r 0 :type u:ub16)
  (g 0 :type u:ub16)
  (b 0 :type u:ub16)
  (a 0 :type u:ub16))

(defstruct (rgba16-pma
            (:include rgba16)
            (:constructor %rgba16-pma)
            (:predicate nil)
            (:copier nil)))

(defstruct (alpha
            (:include color)
            (:constructor %alpha)
            (:predicate nil)
            (:copier nil))
  (value #xff :type u:ub8))

(defstruct (alpha16
            (:include color)
            (:constructor %alpha16)
            (:predicate nil)
            (:copier nil))
  (value #xffff :type u:ub16))

(defstruct (gray
            (:include color)
            (:constructor %gray)
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub8))

(defstruct (gray16
            (:include color)
            (:constructor %gray16)
            (:predicate nil)
            (:copier nil))
  (value 0 :type u:ub16))
