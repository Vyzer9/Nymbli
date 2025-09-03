#lang racket

(provide ==>)

(define-syntax-rule (==> (params ...) body ...)
  (lambda (params ...) body ...))

;; Exemplo de uso
(define add (==> (x y) (+ x y)))
(add 2 3) ;; Deve retornar 5
