#|

 Racer

 A retro tron cycle like game bya Racket noob
 Using the excellent r-cade game-engine

 - Fed Reggiardo 2020

|#

#lang racket
(require r-cade)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Globals 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define board-w 228)
(define board-h 128)

(define dot-x 57)
(define dot-y 121)

(define visited null)
(define crash? #f)
(define trail-length 400)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sprites 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define racer '(#b01000000
                #b11100000
                #b01000000
                #b01000000))

(define trail '(#b01000000))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Game 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Adds a point moved through to the 'visited' list
(define (update-visited dir)
  (set! visited
        (append (if (> trail-length (length visited)) 
                    visited
                    (drop visited (- (length visited) trail-length)))
                (list (cons dot-x dot-y))
                (list (cons (match dir
                              ['up    dot-x]
                              ['down  dot-x]
                              ['right (- dot-x 1)]
                              ['left  (+ dot-x 1)])
                            (match dir
                              ['left  dot-y]
                              ['right dot-y]
                              ['up    (+ dot-y 1)]
                              ['down  (- dot-y 1)]))))))

;; Point to check to see if racer 'crashed' into another line
(define (crash dir)
  (member 
   (match dir
     ['up    (cons dot-x dot-y)]
     ['down  (cons dot-x dot-y)]
     ['right (cons (+ dot-x 2) dot-y)]
     ['left  (cons (- dot-x 2) dot-y)])
   visited))
  
;; Controls the moving when a button is pushed
(define (move dir)
  (when (not crash?)
    (match dir
      ['up    (when (> dot-y -3)            (set! dot-y (- dot-y 2)))]
      ['down  (when (< dot-y (- board-h 9)) (set! dot-y (+ dot-y 2)))]
      ['right (when (< dot-x (- board-w 3)) (set! dot-x (+ dot-x 2)))]
      ['left  (when (> dot-x 1)             (set! dot-x (- dot-x 2)))])
    (when (crash dir) (set! crash? #t))
    (update-visited dir)))

(define (draw-trail)
  (map
   (lambda (point)
     (color (random 1 17))
     (draw (car point) (+ (cdr point) 5) trail))
   (remove null visited)))

(define (game)
  (cls) ;; Clear screen / video memory

  ;; (color 5)
  ;; (rect 0 0 board-w board-h #:fill #t)
  (color 8)
  (when crash? (text 4 2 "BOOM!"))

  (when (btn-up)    (move 'up))
  (when (btn-down)  (move 'down))
  (when (btn-right) (move 'right))
  (when (btn-left)  (move 'left))
  (when (btn-start)
    (set! crash? #f)
    (set! visited null))
  (when (btn-quit)  (quit))

  (draw dot-x dot-y racer)
  (draw-trail))

(define (play)
  (run game board-w board-h #:title "wizard"))

#|
visited

(set! dot-x 3)
(update-visited (cons 1 2))

(play)

|#
(define (twice n)
  (* n 2))

(twice 5)

(module+ test
  (require rackunit)
  (check-equal? (twice 0) 0)
  (check-equal? (twice 2) 4))
