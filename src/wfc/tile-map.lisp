(in-package #:%syntex.wfc.tile-map)

(declaim (inline %make-tile-map))
(defstruct (tile-map
            (:constructor %make-tile-map)
            (:conc-name nil)
            (:predicate nil)
            (:copier nil))
  (grid nil :type grid:grid)
  (entropy-queue (pq:make-queue) :type pq:queue)
  (pattern-removal-stack nil :type list))

(declaim (inline %make-tile))
(defstruct (tile
            (:include grid:cell)
            (:constructor %make-tile)
            (:conc-name "")
            (:predicate nil)
            (:copier nil))
  (possible-patterns (u:make-bit-vector 0) :type simple-bit-vector)
  (total-weight 0 :type u:non-negative-fixnum)
  (total-weight-log-weight 0.0 :type u:f32)
  (entropy-noise 0.0 :type u:f32)
  (collapsed-p nil :type boolean)
  (enabler-counts (make-array (list 0 4) :element-type 'u:ub32) :type (u:ub32a (* 4))))

(u:fn-> calculate-initial-weights (core:core u:ub32) (values u:ub32 u:f32))
(defun calculate-initial-weights (core pattern-count)
  (let ((total-weight 0)
        (total-weight-log-weight 0.0))
    (declare (u:ub16 total-weight)
             (u:f32 total-weight-log-weight))
    (dotimes (pattern-id pattern-count)
      (let ((frequency (pat:get-frequency core pattern-id)))
        (declare (u:ub16 frequency))
        (incf total-weight frequency)
        (incf total-weight-log-weight (* frequency (log frequency 2)))))
    (values total-weight
            total-weight-log-weight)))

(u:fn-> make-tile-enabler-counts (core:core &optional u:ub32a) (u:ub32a (* 4)))
(defun make-tile-enabler-counts (core &optional enabler-counts)
  (declare (optimize speed))
  (let* ((adjacencies (core:adjacencies core))
         (pattern-count (pat:get-count core))
         (enabler-counts (or enabler-counts
                             (make-array (list pattern-count 4)
                                         :element-type 'u:ub32
                                         :initial-element 0))))
    (dotimes (pattern-id pattern-count)
      (loop :for direction :in '(:left :right :up :down)
            :for i :from 0
            :for count = (list-length (u:href (aref adjacencies pattern-id) direction))
            :do (setf (aref enabler-counts pattern-id i) count)))
    enabler-counts))

(defun make-tile (core x y)
  (u:mvlet* ((rng (core:rng core))
             (pattern-count (pat:get-count core))
             (total-weight total-weight-log-weight (calculate-initial-weights core pattern-count)))
    (%make-tile :x x
                :y y
                :possible-patterns (u:make-bit-vector pattern-count 1)
                :total-weight total-weight
                :total-weight-log-weight total-weight-log-weight
                :entropy-noise (rng:float rng 0.0 0.0001)
                :enabler-counts (make-tile-enabler-counts core))))

(u:fn-> reset-tile (core:core tile) null)
(defun reset-tile (core tile)
  (declare (optimize speed))
  (u:mvlet* ((pattern-count (pat:get-count core))
             (total-weight total-weight-log-weight (calculate-initial-weights core pattern-count)))
    (fill (possible-patterns tile) 1)
    (setf (total-weight tile) total-weight
          (total-weight-log-weight tile) total-weight-log-weight
          (collapsed-p tile) nil
          (enabler-counts tile) (make-tile-enabler-counts core (enabler-counts tile)))
    nil))

(u:fn-> make-tile-map (core:core &key (:width u:ub16) (:height u:ub16)) null)
(defun make-tile-map (core &key width height)
  (declare (optimize speed))
  (let* ((tile-count (* width height))
         (tiles (make-array tile-count))
         (grid (grid:make-grid width height tiles))
         (tile-map (%make-tile-map :grid grid)))
    (dotimes (y height)
      (dotimes (x width)
        (setf (aref tiles (+ (* y width) x)) (make-tile core x y))))
    (setf (core:tile-map core) tile-map
          (core:uncollapsed-count core) tile-count)
    nil))

(u:fn-> compute-entropy (tile) u:f32)
(defun compute-entropy (tile)
  (declare (optimize speed))
  (let ((total-weight (total-weight tile))
        (total-weight-log-weight (total-weight-log-weight tile)))
    (+ (- (log total-weight 2)
          (/ total-weight-log-weight total-weight))
       (entropy-noise tile))))

(u:fn-> possible-pattern-p (tile u:ub32) boolean)
(declaim (inline possible-pattern-p))
(defun possible-pattern-p (tile pattern-id)
  (declare (optimize speed))
  (plusp (sbit (possible-patterns tile) pattern-id)))

(u:fn-> remove-possible-pattern (core:core tile u:ub32) boolean)
(defun remove-possible-pattern (core tile pattern-id)
  (let ((frequency (pat:get-frequency core pattern-id))
        (possible-patterns (possible-patterns tile)))
    (declare (u:non-negative-fixnum frequency))
    (flet ((backtrack/restore-pattern (data)
             (setf (sbit (possible-patterns tile) pattern-id) data))
           (backtrack/restore-weights (data)
             (destructuring-bind (total-weight total-weight-log-weight) data
               (setf (total-weight tile) total-weight
                     (total-weight-log-weight tile) total-weight-log-weight))))
      (hist:record core
                   #'backtrack/restore-pattern
                   (sbit possible-patterns pattern-id))
      (hist:record core
                   #'backtrack/restore-weights
                   (list (total-weight tile)
                         (total-weight-log-weight tile)))
      (setf (sbit possible-patterns pattern-id) 0)
      (when (every #'zerop possible-patterns)
        (warn 'cond:wfc-contradiction)
        (hist:backtrack core)
        (return-from remove-possible-pattern nil))
      (decf (total-weight tile) frequency)
      (decf (total-weight-log-weight tile) (* frequency (log frequency 2))))
    t))

(u:fn-> choose-tile (core:core) tile)
(defun choose-tile (core)
  (declare (optimize speed))
  (let* ((tile-map (core:tile-map core))
         (entropy-queue (entropy-queue tile-map)))
    (u:while (pq:peek entropy-queue)
      (let ((tile (pq:dequeue entropy-queue)))
        (unless (collapsed-p tile)
          (return-from choose-tile tile))))
    (error "Bug: Entropy heap is empty but there are still uncollapsed tiles.")))

(u:fn-> choose-pattern-id (core:core tile) u:ub32)
(defun choose-pattern-id (core tile)
  (let ((possible-patterns (possible-patterns tile))
        (remaining (rng:int (core:rng core) 0 (total-weight tile) nil)))
    (declare (fixnum remaining))
    (dotimes (pattern-id (length possible-patterns))
      (when (possible-pattern-p tile pattern-id)
        (let ((weight (pat:get-frequency core pattern-id)))
          (declare (u:non-negative-fixnum weight))
          (if (>= remaining weight)
              (decf remaining weight)
              (return-from choose-pattern-id pattern-id)))))
    (error "Bug: Inconsistency detected with tile frequencies.")))

(u:fn-> collapse-tile (core:core tile) null)
(defun collapse-tile (core tile)
  (declare (optimize speed))
  (let* ((tile-map (core:tile-map core))
         (possible-patterns (possible-patterns tile))
         (chosen-pattern-id (choose-pattern-id core tile))
         (pushed-pattern-count 0)
         (original-possible-patterns nil))
    (declare (u:ub32 pushed-pattern-count))
    (flet ((backtrack/uncollapse-tile (data)
             (declare (ignore data))
             (setf (collapsed-p tile) nil
                   (grid:value tile) 0))
           (backtrack/restore-possible-patterns (data)
             (declare (ignore data))
             (setf (possible-patterns tile) original-possible-patterns
                   (pattern-removal-stack tile-map) nil)))
      (hist:record core #'backtrack/uncollapse-tile)
      (setf (collapsed-p tile) t
            (grid:value tile) (pat:get-origin-color core chosen-pattern-id))
      (dotimes (pattern-id (length possible-patterns))
        (when (and (possible-pattern-p tile pattern-id)
                   (/= pattern-id chosen-pattern-id))
          (unless original-possible-patterns
            (setf original-possible-patterns (u:copy-array possible-patterns)))
          (setf (sbit possible-patterns pattern-id) 0)
          (push (cons tile pattern-id) (pattern-removal-stack tile-map))
          (incf pushed-pattern-count)))
      (when (plusp pushed-pattern-count)
        (hist:record core #'backtrack/restore-possible-patterns))
      (decf (core:uncollapsed-count core))
      nil)))

(u:fn-> get-neighbor (tile-map tile core:direction &key (:periodic-p boolean)) (or grid:cell null))
(declaim (inline get-neighbor))
(defun get-neighbor (tile-map tile direction &key periodic-p)
  (declare (optimize speed))
  (u:mvlet ((grid (grid tile-map))
            (x (grid:x tile))
            (y (grid:y tile))
            (ox oy (core:direction->offset direction)))
    (grid:get-cell grid (+ x ox) (+ y oy) :periodic-p periodic-p)))

(u:fn-> enabler-count (core:core tile u:ub32 core:direction) u:ub16)
(declaim (inline enabler-count))
(defun enabler-count (core tile pattern-id direction)
  (declare (optimize speed)
           (ignore core))
  (let ((direction-index (core:direction->index direction)))
    (aref (enabler-counts tile) pattern-id direction-index)))

(u:fn-> (setf enabler-count) (u:ub16 core:core tile u:ub32 core:direction) u:ub16)
(declaim (inline (setf enabler-count)))
(defun (setf enabler-count) (value core tile pattern-id direction)
  (declare (optimize speed))
  (let ((direction-index (core:direction->index direction)))
    (flet ((backtrack/restore-enabler-count (count)
             (setf (aref (enabler-counts tile) pattern-id direction-index) count)))
      (hist:record core
                   #'backtrack/restore-enabler-count
                   (aref (enabler-counts tile) pattern-id direction-index))
      (setf (aref (enabler-counts tile) pattern-id direction-index) value))))

(u:fn-> positive-enabler-counts-p (core:core tile u:ub32) boolean)
(declaim (inline positive-enabler-counts-p))
(defun positive-enabler-counts-p (core tile pattern-id)
  (declare (optimize speed))
  (and (plusp (enabler-count core tile pattern-id :left))
       (plusp (enabler-count core tile pattern-id :right))
       (plusp (enabler-count core tile pattern-id :up))
       (plusp (enabler-count core tile pattern-id :down))))
