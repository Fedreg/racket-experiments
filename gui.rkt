#lang racket/gui

(require racket/class)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main Window Frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define frame
  (new frame%
       [width 800]
       [height 600]
       [label "Dividend API Runner"]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Widgets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define env-select-list
  (new choice%
       [parent frame]
       [label "1. Select Environment"]
       [choices '("Local" "Dev" "Stage" "Prod")]
       [vert-margin 5]
       [horiz-margin 300]
       [callback
        (lambda (c ev)
          (send c get-string-selection))]))

(define product-select-list
  (new choice%
       [parent frame]
       [label "2. Select Product"]
       [choices '("Home" "Solar")]
       [vert-margin 5]
       [horiz-margin 300]
       [callback
        (lambda (c ev)
          (send c get-string-selection))]))

(define show-env
  (new message%
       [parent frame]
       [label (send env-select-list get-string-selection)]))

(define show-product
  (new message%
       [parent frame]
       [label ""]))

(define le-button
  (new button%
       [parent frame]
       [label (send env-select-list get-string-selection)]
       [callback
        (lambda (btn ev)
          (send show-env set-label (send env-select-list get-string-selection)))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Run
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(send frame show #t)
