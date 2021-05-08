(in-package #:%syntex.synthesizers.wfc.entropy-tracker)

(defclass tracker (tr:tracker rp:picker)
  ((%pattern-count :reader pattern-count
                   :initarg :pattern-count)
   (%frequencies :reader frequencies
                 :initarg :frequencies)
   (%entropy-values :reader entropy-values
                    :initarg :entropy-values)
   (%plogp :reader plogp
           :initarg :plogp)
   (%mask :reader mask
          :initarg :mask)
   (%indices :reader indices
             :initarg :indices)
   (%wave :reader wave
          :initarg :wave)))

(defclass entropy-values ()
  ((%plogp-sum :accessor plogp-sum
               :initform 0d0)
   (%sum :accessor sum
         :initform 0d0)
   (%entropy :accessor entropy
             :initform 0d0)))

(defun recompute-entropy (entropy-values)
  (let ((sum (sum entropy-values)))
    (setf (entropy entropy-values) (- (log sum) (/ (plogp sum) sum)))))

(defun decrement-entropy (entropy-values p plogp)
  (decf (plogp-sum entropy-values) plogp)
  (decf (sum entropy-values) p)
  (recompute-entropy entropy-values))

(defun increment-entropy (entropy-values p plogp)
  (incf (plogp-sum entropy-values) plogp)
  (incf (sum entropy-values) p)
  (recompute-entropy entropy-values))

(defun make-tracker (wave frequencies mask)
  (let* ((pattern-count (length frequencies))
         (plogp (make-array pattern-count :element-type 'u:f64 :initial-element 0d0))
         (indices (wave:indices wave))
         (entropy-values (make-array indices)))
    (dotimes (i pattern-count)
      (let* ((f (aref frequencies i))
             (v (if (plusp f) (* f (log f)) 0d0)))
        (setf (aref plogp i) v)))
    (dotimes (i indices)
      (setf (aref entropy-values i) (make-instance 'entropy-values)))
    (make-instance 'tracker
                   :pattern-count pattern-count
                   :frequencies frequencies
                   :entropy-values entropy-values
                   :plogp plogp
                   :mask mask
                   :indices indices
                   :wave wave)))

(defmethod tr:reset ((tracker tracker))
  (let ((initial (make-instance 'entropy-values))
        (frequencies (frequencies tracker))
        (entropy-array (entropy-values tracker)))
    (dotimes (i (pattern-count tracker))
      (let* ((f (aref frequencies i))
             (v (if (plusp f) (* f (log f)) 0d0)))
        (incf (plogp-sum initial) v)
        (incf (sum initial) f)))
    (recompute-entropy initial)
    (dotimes (i (indices tracker))
      (let ((entropy-values (aref entropy-array i)))
        (setf (plogp-sum entropy-values) (plogp-sum initial)
              (sum entropy-values) (sum initial)
              (entropy entropy-values) (entropy initial))))))

(defmethod tr:ban ((tracker tracker) (index integer) (pattern integer))
  (let ((entropy-values (aref (entropy-values tracker) index)))
    (decrement-entropy entropy-values
                       (aref (frequencies tracker) pattern)
                       (aref (plogp tracker) pattern))))

(defmethod tr:unban ((tracker tracker) (index integer) (pattern integer))
  (let ((entropy-values (aref (entropy-values tracker) index)))
    (increment-entropy entropy-values
                       (aref (frequencies tracker) pattern)
                       (aref (plogp tracker) pattern))))

(defmethod rp:get-index ((picker tracker) (func function) &optional external-priority)
  (let ((indices (indices picker))
        (mask (mask picker))
        (wave (wave picker))
        (entropy-array (entropy-values picker))
        (selected-index -1)
        (min-external-priority #.(- (expt 2 31)))
        (min-entropy most-positive-double-float)
        (min-entropy-count 0))
    (dotimes (i indices)
      (unless (and mask (plusp (aref mask i)))
        (let ((c (wave:get-pattern-count wave i))
              (ep (if external-priority (aref external-priority i) 0))
              (e (entropy (aref entropy-array i))))
          (unless (<= c 1)
            (cond
              ((or (> ep min-external-priority)
                   (and (= ep min-external-priority)
                        (< e min-entropy)))
               (setf min-entropy-count 1
                     min-external-priority ep
                     min-entropy e))
              ((and (= ep min-external-priority)
                    (= e min-entropy))
               (incf min-entropy-count)))))))
    (let ((n (truncate (* min-entropy-count (funcall func)))))
      (dotimes (i indices)
        (unless (and mask (plusp (aref mask i)))
          (let ((c (wave:get-pattern-count wave i))
                (ep (if external-priority (aref external-priority i) 0))
                (e (entropy (aref entropy-array i))))
            (when (and (> c 1)
                       (= ep min-external-priority)
                       (= e min-entropy))
              (when (zerop n)
                (setf selected-index i)
                (return))
              (decf n)))))
      selected-index)))

(defmethod rp:get-pattern ((picker tracker) (index integer) (func function))
  (let ((wave (wave picker))
        (pattern-count (pattern-count picker))
        (frequencies (frequencies picker))
        (s 0d0))
    (dotimes (pattern pattern-count)
      (when (wave:get wave index pattern)
        (incf s (aref frequencies pattern))))
    (let ((r (* (funcall func) s)))
      (dotimes (pattern pattern-count)
        (when (wave:get wave index pattern)
          (decf r (aref frequencies pattern)))
        (unless (plusp r)
          (return-from rp:get-pattern pattern)))
      (1- pattern-count))))
