#lang racket


;; Expressões Aritméticas
(struct add (left right) #:transparent)    ; soma
(struct sub (left right) #:transparent)    ; subtração
(struct mul (left right) #:transparent)    ; multiplicação
(struct div (left right) #:transparent)    ; divisão

;; Constantes (literal numérica ou string, já criado anteriormente)
(struct nymconst (value) #:transparent)