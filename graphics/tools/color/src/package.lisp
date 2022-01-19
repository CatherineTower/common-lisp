(in-package #:cl-user)

(defpackage #:mfiano.graphics.tools.color
  (:local-nicknames
   (#:u #:mfiano.misc.utils))
  (:use #:cl)
  ;; model types
  (:export
   #:alpha
   #:cmyk
   #:gray
   #:gray-alpha
   #:indexed
   #:rgb
   #:rgba
   #:ycbcr)
  ;; model constructors
  (:export
   #:alpha8
   #:alpha16
   #:cmyk8
   #:cmyk16
   #:gray8
   #:gray16
   #:gray-alpha8
   #:gray-alpha16
   #:indexed
   #:rgb8
   #:rgb16
   #:rgba8
   #:rgba8-pma
   #:rgba16
   #:rgba16-pma
   #:ycbcr8)
  ;; palettes
  (:export
   #:3-bit-rgb
   #:3-3-2-bit-rgb
   #:amstrad-cpc
   #:apple-ii-gr
   #:apple-ii-hgr
   #:cga
   #:commodore-16
   #:commodore-64
   #:commodore-vec-20a
   #:commodore-vec-20b
   #:ctia
   #:gtia
   #:mattel-aquarius
   #:open-color
   #:thomson-m05
   #:thomson-t07-1
   #:thomson-t07-2
   #:thomson-t07-3
   #:tms9918
   #:zx-spectrum)
  ;; operations
  (:export
   #:canonicalize
   #:convert
   #:decompose
   #:make-palette))
