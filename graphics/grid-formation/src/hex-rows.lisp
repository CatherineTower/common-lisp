(in-package #:mfiano.graphics.grid-formation)

(defclass hex-grid/rows (hex-grid) ())

(defmethod initialize-instance :after ((instance hex-grid/rows) &key)
  (with-slots (%forward %inverse %edge-directions %corner-directions) instance
    (setf %forward (v4:vec #.(sqrt 3f0) #.(/ (sqrt 3f0) 2f0) 0f0 #.(/ 3f0 2f0))
          %inverse (v4:vec #.(/ (sqrt 3f0) 3f0) #.(/ -1f0 3f0) 0f0 #.(/ 2f0 3f0))
          %edge-directions '(:ne :nw :w :sw :se :e)
          %corner-directions '(:ne :n :nw :sw :s :se))))

(defmethod neighbor-directions ((grid hex-grid/rows))
  '(:e :ne :nw :w :sw :se))

(defmethod to-cell ((grid hex-grid/rows) hex)
  (v3:with-components ((h hex))
    (let ((x (+ hx (/ (+ hy (* (hex-offset grid) (mod hy 2))) 2))))
      (v2:vec x hy))))

(defmethod from-cell ((grid hex-grid/rows) cell)
  (v2:with-components ((c cell))
    (let ((x (- cx (/ (+ cy (* (hex-offset grid) (mod cy 2))) 2))))
      (make-hex x cy))))
