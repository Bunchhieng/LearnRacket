#lang plai-typed

;; Create new type
;; with two sub-classes caml and yacc
;; which has each constructor that take a number
(define-type Animal
  [caml (humps : number)]
  [yacc (height : number)])

;; Define instant of the type
(define ma1 : Animal (caml 2))
(define ma2 : Animal (yacc 1.9))
;; OR
;; (define ma1 (caml 2))
;; (define ma2 (yacc 1.9))

;; Define a function call good? which take instance of Animal
;; return boolean type
;; check if humps >= 2 and height > 2.1
(define (good? [ma : Animal]) : boolean
  (type-case Animal ma
  [caml (humps) (>= humps 2)]
  [yacc (height) (> height 2.1)]))

;; Type infer, we don't need to tell Racket what is `h`
(define (bad? [ma : Animal]) : boolean
  (type-case Animal ma
    [caml (h) (<= h 2)]
    [yacc (h) (< h 2.1)]))

(test (bad? ma1) #t)
(test (bad? ma2) #t)

(test (good? ma1) #t)
(test (good? ma2) #f)

;; We can also use field descriptor
;; caml and yacc can considered as a class
;; humps and height are field from the constructor
(define (good?? [ma : Animal]) : boolean
  (cond
    [(caml? ma) (>= (caml-humps ma) 2)]
    [(yacc? ma) (> (yacc-height ma) 2.1)]))

(test (good?? ma1) #t)
(test (good?? ma2) #f)

;; s-expression
;; every element inside s-expression list is also s-expression
;; therefore we need to convert it from s-expression as below
(define l '(+ 1 2))
(define f (first (s-exp->list l)))
(symbol->string (s-exp->symbol f))