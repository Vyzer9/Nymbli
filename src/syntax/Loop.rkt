#lang racket

;; Definindo macro forx que funciona igual ao for padrão
(define-syntax forx
  (syntax-rules ()
    [(_ (var start end) body ...)
     (for ([var (in-range start (+ end 1))])
       body ...)]))

