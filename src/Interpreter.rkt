#lang racket

(require "syntax/LogicOperations.rkt"
         "syntax/Conditional.rkt")

;; Ambiente global
(define global-env (make-hash))

;; Definir constante
(define (define-const! env name value)
  (hash-set! env name value))

;; Procurar valor de variável
(define (lookup env name)
  (hash-ref env name (lambda () (error "Variável não encontrada:" name))))

;; Interpretador principal
(define (interpret expr env)
  (cond
    ;; Literais
    [(number? expr) expr]
    [(string? expr) expr]

    ;; Variáveis
    [(symbol? expr) (lookup env expr)]

    ;; Operações lógicas/matemáticas simples
    [(and (list? expr) (symbol? (first expr))
          (member (first expr) '(+ - * / = > < <= >=)))
     (eval-op expr interpret env)]

    ;; If (delegado ao módulo Conditional.rkt)
    [(and (list? expr) (eq? (first expr) 'if))
     (eval-if expr interpret env)]

    ;; nymconst (definição de variável)
    [(and (list? expr) (eq? (first expr) 'nymconst))
     (define name (second expr))
     (define val (interpret (third expr) env))
     (define-const! env name val)
     val]

    ;; PrintNym
    [(and (list? expr) (eq? (first expr) 'PrintNym))
     (define val (interpret (second expr) env))
     (displayln val)
     val]

    ;; Expressão não reconhecida
    [else (error "Expressão inválida:" expr)]))

;; =======================
;; Testes
;; =======================

(interpret '(nymconst x 10) global-env)                       ; Define x = 10
(interpret '(PrintNym x) global-env)                          ; Deve imprimir 10
(interpret '(PrintNym (+ 2 3)) global-env)                    ; Deve imprimir 5
(interpret '(PrintNym (if (> x 5) 100 200)) global-env)       ; Deve imprimir 100
