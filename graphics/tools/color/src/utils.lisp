(in-package #:mfiano.graphics.tools.color)

(declaim (inline %or-shift8))
(defun %or-shift8 (value)
  (declare (u:ub8 value))
  (logior value (ash value 8)))
