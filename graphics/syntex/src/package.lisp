(in-package #:cl-user)

(defpackage #:%mfiano.graphics.syntex.conditions
  (:use #:cl)
  (:export
   #:file-not-found
   #:invalid-dimension
   #:invalid-harrison-candidate-count
   #:invalid-harrison-rounds
   #:invalid-harrison-kernel-size
   #:invalid-output-path
   #:invalid-seed
   #:invalid-wfc-backtrack-distance
   #:invalid-wfc-backtrack-retry-count
   #:invalid-wfc-pattern-size
   #:invalid-wfc-strategy
   #:syntex-error
   #:wfc-contradiction-error
   #:wfc-contradiction-warning
   #:wfc-max-backtrack-retries-exceeded))

(defpackage #:%mfiano.graphics.syntex.image
  (:local-nicknames
   (#:png #:mfiano.file-formats.png)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:shadow
   #:write)
  (:export
   #:data
   #:from-rgb
   #:height
   #:make-image
   #:unpack
   #:width
   #:write))

(defpackage #:%mfiano.graphics.syntex.priority-queue
  (:local-nicknames
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:copy
   #:dequeue
   #:enqueue
   #:make-queue
   #:peek
   #:queue))

(defpackage #:%mfiano.graphics.syntex.common
  (:local-nicknames
   (#:cond #:%mfiano.graphics.syntex.conditions))
  (:use #:cl)
  (:export
   #:check-file-exists
   #:check-image-dimension
   #:check-output-path
   #:check-seed))

(defpackage #:%mfiano.graphics.syntex.harrison
  (:local-nicknames
   (#:com #:%mfiano.graphics.syntex.common)
   (#:cond #:%mfiano.graphics.syntex.conditions)
   (#:lp #:lparallel)
   (#:img #:%mfiano.graphics.syntex.image)
   (#:rng #:mfiano.misc.rng)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:harrison))

(defpackage #:%mfiano.graphics.syntex.wfc
  (:local-nicknames
   (#:com #:%mfiano.graphics.syntex.common)
   (#:cond #:%mfiano.graphics.syntex.conditions)
   (#:img #:%mfiano.graphics.syntex.image)
   (#:pq #:%mfiano.graphics.syntex.priority-queue)
   (#:rng #:mfiano.misc.rng)
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  (:export
   #:wfc))

(uiop:define-package #:mfiano.graphics.syntex
  (:use #:cl)
  (:mix-reexport
   #:%mfiano.graphics.syntex.conditions
   #:%mfiano.graphics.syntex.harrison
   #:%mfiano.graphics.syntex.wfc))
