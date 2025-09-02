#lang racket

(require "syntax/LogicOperations.rkt"
         "syntax/Conditional.rkt"
         "syntax/Lambda.rkt")

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

    ;; nymlambda (função anônima)
[(and (list? expr) (eq? (first expr) 'nymlambda))
 (eval-lambda expr env interpret)] ; ✅ novo


    ;; Chamada de função
    [(and (list? expr) (not (member (first expr) '(nymconst PrintNym if + - * / = > < <= >= nymlambda))))
     (let ([func (interpret (first expr) env)]
           [args (map (lambda (e) (interpret e env)) (rest expr))])
       (apply func args))]

    ;; Expressão inválida
    [else (error "Expressão inválida:" expr)]))

;; =====================
;; Exemplo de Lambda.rkt
;; =====================

(provide eval-lambda)

(define (eval-lambda expr env)
  ;; Espera: (nymlambda (params...) body...)
  (let* ([params (second expr)]
         [body (cddr expr)])
    (lambda args
      (define new-env (for/fold ([acc-env env])
                                 ([param params]
                                  [arg args])
                        (hash-set acc-env param arg)))
      (define results (map (lambda (e) (interpret e new-env)) body))
      (if (null? (cdr results))
          (car results)
          (last results)))))

;; =====================
;; Exemplos de uso
;; =====================

;; Definindo variável
(interpret '(nymconst x 10) global-env)

;; Printando x (10)
(interpret '(PrintNym x) global-env)

;; Printando soma (5)
(interpret '(PrintNym (+ 2 3)) global-env)

;; If simples (100)
(interpret '(PrintNym (if (> x 5) 100 200)) global-env)

;; Definindo função dobro
(interpret '(nymconst dobro (nymlambda (x) (* x 2))) global-env)

;; Usando função dobro (20)
(interpret '(PrintNym (dobro 10)) global-env)
