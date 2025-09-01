#lang racket


;; Representa uma constante literal, tipo número ou string
(struct nymconst (value) #:transparent)

;; Representa uma expressão let com um nome, um valor e um corpo
(struct nymlet (name value body) #:transparent)


; -------------- Testes -------------- ;
; Constnym
(define A (nymconst 12))
(displayln (string-append "Resultado de A é: " (number->string (nymconst-value A))))

; Letnym
(define B (nymlet 'x 10 'x))
(displayln (string-append "Resultado de B é: " (number->string (nymlet-value B))))

