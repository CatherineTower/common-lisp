(in-package #:mfiano.graphics.tools.image.color)

;;; Accessors for reading/writing color channel storage arrays.

(defgeneric channel0 (storage))

(defgeneric (setf channel0) (value storage))

(defgeneric channel1 (storage))

(defgeneric (setf channel1) (value storage))

(defgeneric channel2 (storage))

(defgeneric (setf channel2) (value storage))

(defgeneric channel3 (storage))

(defgeneric (setf channel3) (value storage))

;;; Linearize/delinearize the tonal response curve of a RGB channel.

(defgeneric linearize-rgb-channel (value gamma))

(defgeneric delinearize-rgb-channel (value gamma))
