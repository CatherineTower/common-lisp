(in-package #:%syntex.wfc.solver)

(u:fn-> enqueue-initial-tile (core:core) null)
(defun enqueue-initial-tile (core)
  (declare (optimize speed))
  (let* ((rng (core:rng core))
         (tile-map (core:tile-map core))
         (grid (tm:grid tile-map))
         (x (rng:int rng 0 (grid:width grid)))
         (y (rng:int rng 0 (grid:height grid)))
         (tile (grid:get-cell grid x y)))
    (pq:enqueue (tm:entropy-queue tile-map) tile (tm:compute-entropy tile))
    nil))

(u:fn-> propagate/neighbor (core:core core:direction list) function)
(defun propagate/neighbor (core direction pattern-ids)
  (declare (optimize speed))
  (let* ((tile-map (core:tile-map core))
         (entropy-queue (tm:entropy-queue tile-map)))
    (lambda (tile)
      (dolist (pattern-id pattern-ids)
        (when (tm:pattern-removable-p core tile pattern-id direction)
          (unless (tm:remove-possible-pattern core tile pattern-id)
            (warn 'cond:wfc-contradiction-warning)
            (ecase (core:strategy core)
              (:backtrack (hist:backtrack core))
              (:none (error 'cond:wfc-contradiction-error)))
            (throw :contradiction nil))
          (pq:enqueue entropy-queue tile (tm:compute-entropy tile))
          (push (cons tile pattern-id) (tm:pattern-removal-stack tile-map)))
        (decf (tm:enabler-count core tile pattern-id direction))))))

(u:fn-> propagate/map (core:core tm:tile u:ub32 &key (:periodic-p boolean)) null)
(defun propagate/map (core tile pattern-id &key periodic-p)
  (declare (optimize speed))
  (let* ((tile-map (core:tile-map core))
         (kernel (tm:neighbor-kernel tile-map))
         (x (grid:x tile))
         (y (grid:y tile))
         (adjacent-patterns (aref (core:adjacencies core) pattern-id)))
    (flet ((%map (direction opposite-direction)
             (let ((pattern-ids (u:href adjacent-patterns direction)))
               (propagate/neighbor core opposite-direction pattern-ids))))
      (declare (inline %map))
      (kernel:align kernel x y)
      (kernel:map/left kernel (%map :left :right) :periodic-p periodic-p)
      (kernel:map/right kernel (%map :right :left) :periodic-p periodic-p)
      (kernel:map/up kernel (%map :up :down) :periodic-p periodic-p)
      (kernel:map/down kernel (%map :down :up) :periodic-p periodic-p))))

(u:fn-> propagate (core:core &key (:periodic-p boolean)) null)
(defun propagate (core &key periodic-p)
  (declare (optimize speed))
  (let ((tile-map (core:tile-map core)))
    (u:while (tm:pattern-removal-stack tile-map)
      (destructuring-bind (tile . pattern-id) (pop (tm:pattern-removal-stack tile-map))
        (catch :contradiction
          (propagate/map core tile pattern-id :periodic-p periodic-p))))))

(u:fn-> update-progress (core:core &key (:show-p boolean)) null)
(defun update-progress (core &key show-p)
  (declare (optimize speed))
  (let* ((tile-map (core:tile-map core))
         (tile-count (tm:tile-count tile-map))
         (current (truncate (- tile-count (core:uncollapsed-count core))
                            (/ tile-count 100)))
         (progress (core:progress core)))
    (declare ((integer 0 100) current))
    (when (/= current progress)
      (when show-p
        (cond
          ((zerop progress)
           (format t "~&0%"))
          ((= current 100)
           (format t "100%~%"))
          ((zerop (mod current 10))
           (format t "~d%" current))
          (t (format t ".")))
        (finish-output))
      (setf (core:progress core) current))
    nil))

(u:fn-> solve (core:core &key (:periodic-p boolean) (:show-progress-p boolean)) null)
(defun solve (core &key periodic-p show-progress-p)
  (declare (optimize speed))
  (enqueue-initial-tile core)
  (u:while (plusp (core:uncollapsed-count core))
    (let ((tile (tm:choose-tile core)))
      (tm:collapse-tile core tile)
      (propagate core :periodic-p periodic-p)
      (hist:advance-time core)
      (update-progress core :show-p show-progress-p)))
  (when (eq (core:strategy core) :backtrack)
    (tg:gc :full t))
  nil)
