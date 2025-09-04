#lang racket

(require "Lexer.rkt")
(require "ParserTokensToSexpr.rkt")
(require "Parser.rkt")
(require "Interpreter.rkt")
(require (file "../Nymbli.rkt"))

(define (repl env)
  (display "Nymbli> ")
  (flush-output)
  (let ([input (read-line)])
    (unless (eof-object? input)
      (with-handlers ([exn:fail? (λ (e) 
                                  (displayln (exn-message e))
                                  (repl env))])
        (define tokens (lexer input))
        (define sexpr (parse-tokens tokens))   ;; converte tokens para S-expressions
        (define ast (parse sexpr))              ;; seu parser transforma S-expressions em AST
        (define-values (result new-env) (interpret ast env)) ;; interpret retorna resultado e ambiente atualizado?
        (displayln result)
        (repl new-env)))))

(module+ main
  (repl '())) ;; inicia o REPL com ambiente vazio
