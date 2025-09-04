#lang racket

(require (file "../../Nymbli.rkt"))

(define code "(nymlet x 42)")
(define tokens (lexer code))
(define ast (parse tokens))
(define env (make-env))
(interpret ast env)
(displayln (env-get env 'x)) ;; Deve imprimir 42
