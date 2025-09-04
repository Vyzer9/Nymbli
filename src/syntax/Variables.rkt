#lang racket

;; Exporta as structs para que fiquem disponíveis para outros módulos
(provide nymconst nymlet nymset)

;; Representa uma constante literal, tipo número ou string
(struct nymconst (value) #:transparent)

;; Representa uma expressão let com um nome, um valor e um corpo
(struct nymlet (name value body) #:transparent)

;; Representa a alteração de valor de uma variável já definida
(struct nymset (name new-value) #:transparent)


;; ------------------------------------
;; Testes
;; ------------------------------------

; Constnym
;(define A (nymconst 12))
;(displayln (string-append "Resultado de A é: " (number->string (nymconst-value A))))

; Letnym
;(define B (nymlet 'x 10 'x))
;(displayln (string-append "Resultado de x é: " (number->string (nymlet-value B))))

; Setnym
;(define C (nymset 'x 99))
;(displayln (string-append "Mudando valor de 'x' para: " (number->string (nymset-new-value C))))
