#lang racket

(require "AST.rkt")
(require racket/match)

;; parser básico que recebe lista de tokens (com parênteses) e constrói AST

(define (parse tokens)
  (define-values (expr rest) (parse-expr tokens))
  (if (null? rest)
      expr
      (error "Tokens restantes não processados")))

(define (parse-expr tokens)
  (cond
    [(null? tokens) (error "Fim inesperado de entrada")]
    [(equal? (first tokens) 'nymlet)
     (parse-let tokens)]
    [(equal? (first tokens) 'nymconst)
     (parse-let tokens)]
    [(equal? (first tokens) 'if)
     (parse-if tokens)]
    [(equal? (first tokens) 'func)
     (parse-func tokens)]
    [else
     (parse-call-or-var tokens)]))


;; Parse let (nymlet x 10)
(define (parse-let tokens)
  (match tokens
    [(list 'nymlet name value rest ...)
     (values (Let name (Literal value)) rest)]
    [(list 'nymconst name value rest ...)
     (values (Let name (Literal value)) rest)]
    [_ (error "Let mal formado")]))

;; Parse if (if cond then else)
(define (parse-if tokens)
  (match tokens
    [(list 'if cond then else rest ...)
     (values (If (Literal cond) (Literal then) (Literal else)) rest)]
    [_ (error "If mal formado")]))

;; Parse func (func (params) body)
(define (parse-func tokens)
  (match tokens
    [(list 'func params body rest ...)
     (values (Func params body) rest)]
    [_ (error "Func mal formado")]))

;; Parse chamada de função ou variável
(define (parse-call-or-var tokens)
  (match tokens
    [(list fn arg rest ...)
     (values (Call fn arg) rest)]
    [(list name rest ...)
     (values (Var name) rest)]
    [_ (error "Expressão mal formada")]))

(provide parse)
