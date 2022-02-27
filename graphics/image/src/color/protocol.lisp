(in-package #:%mfiano.graphics.image.base)

;;; Internal protocol

(defgeneric %convert-color (from to))

(defgeneric %linearize-rgb-channel (value gamma))

(defgeneric %delinearize-rgb-channel (value gamma))

;;; External protocol

(defgeneric convert-color (from to))
