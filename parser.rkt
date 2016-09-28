#lang plai-typed

;; Define a type call Arithc which has
;; three sub classes numC, plusC and multC
;; numC has a constructor which takes one argument n
;; plusC and multC take two args, both are ArithC type
(define-type ArithC
  [numC (n : number)]
  [plusC (l : ArithC) (r : ArithC)]
  [multC (l : ArithC) (r : ArithC)])

;; A new data type which allow us to add bminusS
(define-type ArithS
  [numS (n : number)]
  [plusS (l : ArithS) (r : ArithS)]
  [bminusS (l : ArithS) (r : ArithS)]
  [multS (l : ArithS) (r : ArithS)]
  [uminusS (e : ArithS)])

;; desugar function translates ArithS values into ArithC ones
(define (desugar [as : ArithS]) : ArithC
  (type-case ArithS as
    [numS (n) (numC n)]
    [plusS (l r) (plusC (desugar l) (desugar r))]
    [multS (l r) (multC (desugar l) (desugar r))]
    ;; Because a - b = a + (-1) x b
    [bminusS (l r) (plusC (desugar l) (multC (numC -1) (desugar r)))]
    ;; -b = -1 x b
    [uminusS (e) (desugar (multS (numS -1) e))]))

;; Convert s-exp to appropriate data type of list
(define (parse [s : s-expression]) : ArithC
  (cond
    ;; base case for input of number, return the number
    [(s-exp-number? s) (numC (s-exp->number s))]
    ;; if s is list
    [(s-exp-list? s)
     ;; convert s(s-expression) as list then store in sl
     (let ([sl (s-exp->list s)])
       ;; switch on the first element of the list sl
       (case (s-exp->symbol (first sl))
         [(+) (plusC (parse (second sl)) (parse (third sl)))]
         [(*) (multC (parse (second sl)) (parse (third sl)))]
         [else (error 'parse "invalid list input")]))]
    ;; if not number or list, error invalid input
    [else (error 'parse "invalid input")]))

;; (plusC (multC (numC 1) (numC 2)) (plusC (numC 2) (numC 3)))
(parse '(+ (* 1 2) (+ 2 3)))

;; Interpret the output from parse func
;; This function take an instance of ArithC type and return number
(define (interp [a : ArithC]) : number
  ;; switch case for each type of instance a
  (type-case ArithC a
    ;; if a is a number, return the constructor value n
    [numC (n) n]
    ;; plus and multiply both left and right 
    ;; then recursive through the parse output
    [plusC (l r) (+ (interp l) (interp r))]
    [multC (l r) (* (interp l) (interp r))]))

;; output: 7
(interp (parse '(+ (* 1 2) (+ 2 3))))
(test (interp (parse '(+ (* 1 2) (+ 2 3)))) 7)