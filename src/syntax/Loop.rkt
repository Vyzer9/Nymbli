#lang racket

;; Definindo macro forx que funciona igual ao for padrão
(define-syntax forx
  (syntax-rules ()
    [(_ (var start end) body ...)
     (for ([var (in-range start (+ end 1))])
       body ...)]))

;; Usando forx para imprimir de 1 a 10
(forx (i 1 10)
  (displayln i))

;; Criar uma lista de quadrados usando for/list com forx (usamos o for padrão aqui mesmo)
(define squares
  (for/list ([i (in-range 1 11)])
    (* i i)))

(displayln "Quadrados de 1 a 10:")
(for ([sq squares])
  (displayln sq))
