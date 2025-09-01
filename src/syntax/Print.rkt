#lang racket

(define (PrintNym msg)
  (displayln msg))

; Testes com o PrintNym
(PrintNym "Hello, Nymbli!")
(PrintNym (string-append "number " (number->string 1)))
(PrintNym (string-append "I love " (string-append "cats")))
(PrintNym (format "I hate ~a ~a" 2 (string-append "dogs in my house")))
