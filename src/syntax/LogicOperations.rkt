#lang racket

(provide eval-op)

(define (eval-op expr interpret env)
  (define op (first expr))
  (define args (map (λ (e) (interpret e env)) (rest expr)))
  (apply
   (case op
     [(+) +]
     [(-) -]
     [(*) *]
     [(/) /]
     [(=) =]
     [(>) >]
     [(<) <]
     [(<=) <=]
     [(>=) >=])
   args))
