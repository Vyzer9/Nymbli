#lang racket

;; Representa uma constante literal, tipo número ou string
(struct constnym (value) #:transparent)

;; Representa uma expressão let com um nome, um valor e um corpo
(struct letnym (name value body) #:transparent)


; Testes
(define A (constnym 12))
(displayln (string-append "Resultado de A é: " (number->string (constnym-value A))))

; Let
(define B (letnym 'x 10 'x))
(displayln (string-append "Resultado de B é: " (number->string (letnym-value B))))

