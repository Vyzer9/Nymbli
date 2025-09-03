#lang racket

(require (only-in "Arrow.rkt" ==>))


(provide nymlist appendx)

;; Criar uma lista Nymlist a partir de elementos dados
(define (nymlist . elements)
  elements)

;; Appendx concatena duas listas ou duas strings
(define (appendx a b)
  (cond
    [(and (string? a) (string? b)) (string-append a b)]  ; Para strings
    [(and (list? a) (list? b)) (append a b)]             ; Para listas
    [else (error "appendx espera duas listas ou duas strings")]))  ; Caso contrário

;; Exemplos
(require rackunit)

(check-equal? (nymlist 1 2 3) '(1 2 3))
(check-equal? (appendx "Olá, " "mundo!") "Olá, mundo!")
(check-equal? (appendx '(1 2) '(3 4)) '(1 2 3 4))

