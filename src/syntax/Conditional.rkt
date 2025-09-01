#lang racket

(provide eval-if)

(define (eval-if expr interpret env)
  (define cond (second expr))
  (define then-branch (third expr))
  (define else-branch (fourth expr))
  (if (interpret cond env)
      (interpret then-branch env)
      (interpret else-branch env)))
