#lang racket


;; Expressões Aritméticas
(struct add (left right) #:transparent)    ; soma
(struct sub (left right) #:transparent)    ; subtração
(struct mul (left right) #:transparent)    ; multiplicação
(struct div (left right) #:transparent)    ; divisão

;; Constantes (literal numérica ou string, já criado anteriormente)
(struct nymconst (value) #:transparent)

; -------------- Testes -------------- ;
(define expr1 (add (nymconst 5) (nymconst 3)))   ; representa 5 + 3
(define expr2 (mul (nymconst 2) (nymconst 10)))  ; representa 2 * 10

;; Só pra testar visualmente no REPL
(displayln expr1)
(displayln expr2)
