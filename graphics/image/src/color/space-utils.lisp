(in-package #:%mfiano.graphics.image.color)

(u:define-constant +cie-e+ #.(float 216/24389 1d0))

(u:define-constant +cie-k+ #.(float 24389/27 1d0))

(defmacro with-convert ((from to) &body body)
  `(with-pool-colors (,@(butlast (rest (car body))))
     ,@(loop :with last := (first (last (car body)))
             :for (x y) :on (car body) :by #'cdr
             :for first := from :then nil
             :for op := (u:symbolicate x '#:-> y)
             :unless (or (eq x last) (eq y last))
               :collect `(,op ,(if first from x) ,y)
             :when (and y (eq y last))
               :collect `(,op ,x ,to))))

(declaim (inline lab->lchab))
(defun lab->lchab (lab lchab)
  (declare (optimize speed))
  (let ((lab-channels (channels lab))
        (lchchannels (channels lchab)))
    (declare (v3:vec lab-channels lchchannels))
    (v3:with-components ((lab- lab-channels)
                         (lch lchchannels))
      (let ((arctan (atan lab-z lab-y)))
        (copy-illuminant-name lab lchab)
        (setf lchx lab-x
              lchy (sqrt (+ (expt lab-y 2) (expt lab-z 2)))
              lchz (if (plusp arctan)
                       (u:radians->degrees arctan)
                       (+ (u:radians->degrees arctan) 360)))
        lchab))))

(declaim (inline lab->xyz))
(defun lab->xyz (lab xyz)
  (declare (optimize speed))
  (let ((lab-channels (channels lab))
        (xyz-channels (channels xyz))
        (white-point (get-white-point (illuminant-name lab))))
    (declare (v3:vec xyz-channels white-point))
    (v3:with-components ((xyz- xyz-channels)
                         (w white-point))
      (let* ((L (v3:x lab-channels))
             (a (v3:y lab-channels))
             (b (v3:z lab-channels))
             (fy (* (+ L 16) #.(/ 116)))
             (fx (+ (* a #.(/ 500)) fy))
             (fz (- fy (* b #.(/ 200))))
             (fx^3 (expt fx 3))
             (fz^3 (expt fz 3))
             (rx (if (> fx^3 +cie-e+)
                     fx^3
                     (* (- (* fx 116) 16) #.(/ +cie-k+))))
             (ry (if (> L #.(* +cie-k+ +cie-e+))
                     (expt (* (+ L 16) #.(/ 116)) 3)
                     (* L #.(/ +cie-k+))))
             (rz (if (> fz^3 +cie-e+)
                     fz^3
                     (* (- (* fz 116) 16) #.(/ +cie-k+)))))
        (copy-illuminant-name lab xyz)
        (setf xyz-x (* rx wx)
              xyz-y (* ry wy)
              xyz-z (* rz wz))
        xyz))))

(declaim (inline lchab->lab))
(defun lchab->lab (lchab lab)
  (declare (optimize speed))
  (let ((lchchannels (channels lchab))
        (lab-channels (channels lab)))
    (declare (v3:vec lchchannels lab-channels))
    (v3:with-components ((lch lchchannels)
                         (lab- lab-channels))
      (let ((h (u:degrees->radians lchz)))
        (copy-illuminant-name lchab lab)
        (setf lab-x lchx
              lab-y (* lchy (cos h))
              lab-z (* lchy (sin h)))
        lab))))

(declaim (inline lchuv->luv))
(defun lchuv->luv (lchuv luv)
  (declare (optimize speed))
  (let ((lchchannels (channels lchuv))
        (luv-channels (channels luv)))
    (declare (v3:vec lchchannels luv-channels))
    (v3:with-components ((lch lchchannels)
                         (luv- luv-channels))
      (let ((h (u:degrees->radians lchz)))
        (copy-illuminant-name lchuv luv)
        (setf luv-x lchx
              luv-y (* lchy (cos h))
              luv-z (* lchy (sin h)))
        luv))))

(declaim (inline luv->lchuv))
(defun luv->lchuv (luv lchuv)
  (declare (optimize speed))
  (let ((luv-channels (channels luv))
        (lchchannels (channels lchuv)))
    (declare (v3:vec luv-channels lchchannels))
    (v3:with-components ((luv- luv-channels)
                         (lch lchchannels))
      (let ((arctan (atan luv-z luv-y)))
        (copy-illuminant-name luv lchuv)
        (setf lchx luv-x
              lchy (sqrt (+ (expt luv-y 2) (expt luv-z 2)))
              lchz (if (plusp arctan)
                       (u:radians->degrees arctan)
                       (+ (u:radians->degrees arctan) 360)))
        lchuv))))

(declaim (inline luv->xyz))
(defun luv->xyz (luv xyz)
  (declare (optimize speed))
  (let ((luv-channels (channels luv))
        (xyz-channels (channels xyz))
        (white-point (get-white-point (illuminant-name luv))))
    (declare (v3:vec luv-channels xyz-channels white-point))
    (v3:with-components ((luv- luv-channels)
                         (xyz- xyz-channels)
                         (w white-point))
      (when (zerop luv-x)
        (v3:zero! xyz-channels)
        (return-from luv->xyz xyz))
      (let* ((div (+ wx (* wy 15) (* wz 3)))
             (a (* (1- (/ (* 52 luv-x) (+ luv-y (* 13 luv-x (/ (* wx 4) div))))) #.(/ 3)))
             (y (if (> luv-x #.(* +cie-k+ +cie-e+))
                    (expt (* (+ luv-x 16) #.(/ 116)) 3)
                    (* luv-x #.(/ +cie-k+))))
             (d (* (- (/ (* 39 luv-x) (+ luv-z (* 13 luv-x (/ (* wy 9) div)))) 5) y))
             (-5y (* y -5)))
        (copy-illuminant-name luv xyz)
        (setf xyz-x (/ (- d -5y) (- a -1/3))
              xyz-y y
              xyz-z (+ (* xyz-x a) -5y))
        xyz))))

(declaim (inline rgb->xyz))
(defun rgb->xyz (rgb xyz)
  (declare (optimize speed))
  (with-pool-color (temp-rgb (type-of rgb) :space (space-name rgb) :copy rgb)
    (let* ((illuminant-name (illuminant-name temp-rgb))
           (transform (get-rgb-transform temp-rgb xyz illuminant-name))
           (rgb-channels (v3:zero)))
      (declare (dynamic-extent rgb-channels))
      (linearize-rgb temp-rgb)
      (replace rgb-channels (the (or v3:vec v4:vec) (channels temp-rgb)))
      (m3:*v3! (channels xyz) transform rgb-channels)
      (setf (%illuminant-name xyz) illuminant-name)
      xyz)))

(declaim (inline xyy->xyz))
(defun xyy->xyz (xyy xyz)
  (declare (optimize speed))
  (let ((xyy-channels (channels xyy))
        (xyz-channels (channels xyz)))
    (declare (v3:vec xyy-channels xyz-channels))
    (v3:with-components ((xyy- xyy-channels)
                         (xyz- xyz-channels))
      (copy-illuminant-name xyy xyz)
      (if (zerop xyy-y)
          (v3:zero! xyz-channels)
          (setf xyz-x (/ (* xyy-x xyy-z) xyy-y)
                xyz-y xyy-z
                xyz-z (/ (* (- 1 xyy-x xyy-y) xyy-z) xyy-y)))
      xyz)))

(declaim (inline xyz->lab))
(defun xyz->lab (xyz lab)
  (declare (optimize speed))
  (let* ((lab-channels (channels lab))
         (r (v3:/ (channels xyz) (get-white-point (illuminant-name xyz))))
         (rx (v3:x r))
         (ry (v3:y r))
         (rz (v3:z r))
         (fx (if (> rx +cie-e+)
                 (expt rx #.(/ 3d0))
                 (* (+ (* +cie-k+ rx) 16) #.(/ 116))))
         (fy (if (> ry +cie-e+)
                 (expt ry #.(/ 3d0))
                 (* (+ (* +cie-k+ ry) 16) #.(/ 116))))
         (fz (if (> rz +cie-e+)
                 (expt rz #.(/ 3d0))
                 (* (+ (* +cie-k+ rz) 16) #.(/ 116)))))
    (declare (v3:vec lab-channels)
             (dynamic-extent r))
    (v3:with-components ((lab- lab-channels))
      (copy-illuminant-name xyz lab)
      (setf lab-x (- (* fy 116) 16)
            lab-y (* (- fx fy) 500)
            lab-z (* (- fy fz) 200))
      lab)))

(declaim (inline xyz->rgb))
(defun xyz->rgb (xyz rgb)
  (declare (optimize speed))
  (with-pool-color (temp-xyz 'xyz :copy xyz)
    (let* ((illuminant-name (illuminant-name rgb))
           (transform (get-rgb-transform temp-xyz rgb illuminant-name))
           (rgb-channels (v3:zero)))
      (declare (dynamic-extent rgb-channels))
      (adapt-chromaticity temp-xyz illuminant-name)
      (m3:*v3! rgb-channels transform (channels temp-xyz))
      (replace (the (or v3:vec v4:vec) (channels rgb)) rgb-channels)
      (delinearize-rgb rgb)
      (setf (%illuminant-name rgb) illuminant-name)
      rgb)))

(declaim (inline xyz->luv))
(defun xyz->luv (xyz luv)
  (declare (optimize speed))
  (let ((xyz-channels (channels xyz))
        (luv-channels (channels luv))
        (white-point (get-white-point (illuminant-name xyz))))
    (declare (v3:vec xyz-channels luv-channels white-point))
    (v3:with-components ((xyz- xyz-channels)
                         (luv- luv-channels)
                         (w white-point))
      (let ((reference-y (/ xyz-y wy))
            (div-uv (+ xyz-x (* xyz-y 15) (* xyz-z 3)))
            (div-w (+ wx (* wy 15) (* wz 3))))
        (copy-illuminant-name xyz luv)
        (if (zerop div-uv)
            (v3:zero! luv-channels)
            (setf luv-x (if (> reference-y +cie-e+)
                            (- (* 116 (expt reference-y #.(/ 3d0))) 16)
                            (* +cie-k+ reference-y))
                  luv-y (* luv-x 13 (- (/ (* xyz-x 4) div-uv) (/ (* wx 4) div-w)))
                  luv-z (* luv-x 13 (- (/ (* xyz-y 9) div-uv) (/ (* wy 9) div-w)))))
        luv))))

(declaim (inline xyz->xyy))
(defun xyz->xyy (xyz xyy)
  (declare (optimize speed))
  (let ((xyz-channels (channels xyz))
        (xyy-channels (channels xyy)))
    (declare (v3:vec xyz-channels xyy-channels))
    (v3:with-components ((xyz- xyz-channels)
                         (xyy- xyy-channels))
      (let ((x+y+z (+ xyz-x xyz-y xyz-z)))
        (copy-illuminant-name xyz xyy)
        (setf xyy-x (if (zerop x+y+z) 0d0 (/ xyz-x x+y+z))
              xyy-y (if (zerop x+y+z) 0d0 (/ xyz-y x+y+z))
              xyy-z xyz-y)
        xyy))))
