(in-package #:mfiano.graphics.dungen)

(defun filter-carvable (kernel)
  (not (kernel-detect kernel #'carved-p)))

(defun choose-corridor-cell (stage cells)
  (let ((rng (state-rng *state*)))
    (if (> (rng:float rng 0.0 1.0) (stage-wild-factor stage))
        (rng:element rng cells nil)
        (first cells))))

(defun choose-corridor-direction (kernel)
  (let (results)
    (dolist (dir '((0 1) (0 -1) (1 0) (-1 0)))
      (u:when-let ((cell1 (apply #'select kernel dir))
                   (cell2 (apply #'select kernel (mapcar #'+ dir dir))))
        (unless (carved-p cell2)
          (push (list cell1 cell2) results))))
    (rng:element (state-rng *state*) results nil)))

(defun carve-direction (kernel cells)
  (let ((origin (select kernel 0 0)))
    (u:if-let ((choice (choose-corridor-direction kernel)))
      (loop :for cell :in choice
            :do (carve cell :corridor)
            :finally (return (push cell cells)))
      (progn
        (push origin (state-dead-ends *state*))
        (delete origin cells :count 1)))))

(defun carve-corridor-cell (kernel)
  (let ((stage (kernel-stage kernel))
        (origin (select kernel 0 0))
        (layout (layout :orthogonal :max-x 2 :max-y 2)))
    (make-region)
    (carve origin :corridor)
    (labels ((recurse (cells)
               (when cells
                 (let* ((cell (choose-corridor-cell stage cells))
                        (kernel (cell->kernel stage cell layout)))
                   (recurse (carve-direction kernel cells))))))
      (recurse (list origin)))))

(defun carve-corridors (stage)
  (convolve stage (layout :rectangle) #'filter-carvable #'carve-corridor-cell))

(defun filter-dead-end (kernel)
  (let ((dirs (count nil (kernel-map kernel #'carved-p))))
    (and (carved-p (select kernel 0 0))
         (> dirs 2))))

(defun erode-dead-end (kernel)
  (uncarve (select kernel 0 0))
  (remove-connectors kernel)
  (kernel-detect kernel (lambda (x) (when (carved-p x) x))))

(defun erode-dead-ends (stage)
  (process stage nil #'filter-dead-end #'erode-dead-end
           :items (state-dead-ends *state*)
           :generator (lambda (x) (cell->kernel stage x (layout :orthogonal)))))
