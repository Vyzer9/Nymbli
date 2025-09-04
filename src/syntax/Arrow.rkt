#lang racket

(provide ==>)

(define-syntax-rule (==> (params ...) body ...)
  (lambda (params ...) body ...))
