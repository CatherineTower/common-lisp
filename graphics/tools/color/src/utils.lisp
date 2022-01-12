(in-package #:mfiano.graphics.tools.color)

(declaim (inline %or-shift))
(defun %or-shift (value)
  (declare (u:ub8 value))
  (logior value (ash value 8)))
