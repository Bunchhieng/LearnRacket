;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;    ;;;      ;;;;;;; ;;  ;;; ;;;;;;;; ;;;;;;;;;; ;;  
;; ;;   ;;    ;; ;;     ;;      ;; ;;   ;;       ;;;;;;;;;; ;;
;; ;;  ;;    ;;   ;;    ;;      ;;;     ;;           ;;     ;;
;; ;; ;;    ;; ;;; ;;   ;;      ;;;     ;;;;;;;;     ;;     ;;
;; ;;  ;;  ;;       ;;  ;;      ;; ;;   ;;           ;;     ;;
;; ;;   ;;;;         ;; ;;;;;;; ;;  ;;; ;;;;;;;;     ;;     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; if statement
(define (no-good n)
  (if (> n 1) "No Good" 'Good))

(no-good 2)

;; Anoynymous function
(define inc (lambda (x) (+ x 1)))
(inc 5)

(define x 3)
x

;; cube function
(define cube1
  (lambda (x)
    (* x x x)))
(cube1 3)

;; power function
(define (pow1 x y)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))
(pow1 2 5)

;; sum a list
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))
(sum (list 1 2 3 4 5))

;; Append list
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))
(my-append (list 1 2 3) (list 4))

;; map function
(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (my-map f (cdr xs)))))
(my-map (lambda (x) (+ x 1)) (list 3 4 5))
