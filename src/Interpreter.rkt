#lang racket

(require "AST.rkt")

(provide interpret make-env)

;; Cria um ambiente vazio (hash table)
(define (make-env)
  (make-hash))

;; Busca variável no ambiente, erro se não encontrar
(define (env-get env key)
  (hash-ref env key (lambda () (error "Variável não definida:" key))))

;; Atualiza ou adiciona variável no ambiente
(define (env-set! env key val)
  (hash-set! env key val))

;; Interpreta uma expressão AST dentro do ambiente
(define (interpret expr env)
  (cond
    ;; Literal: retorna seu valor direto
    [(Literal? expr)
     (Literal-value expr)]

    ;; Variável: busca valor no ambiente
    [(Var? expr)
     (env-get env (Var-name expr))]

    ;; Let: avalia o valor, armazena no ambiente, interpreta o corpo com esse ambiente atualizado
    [(Let? expr)
     (let ([val (interpret (Let-value expr) env)])
       (env-set! env (Let-name expr) val)
       (interpret (Let-body expr) env))]

    ;; If: avalia a condição, interpreta então ou else conforme resultado
    [(If? expr)
     (if (interpret (If-cond expr) env)
         (interpret (If-then expr) env)
         (interpret (If-else expr) env))]

    ;; Função: simplesmente retorna a struct da função para aplicação posterior
    [(Func? expr)
     expr]

    ;; Chamada de função
    [(Call? expr)
     (let* ([func (interpret (Call-fn expr) env)]
            [arg (interpret (Call-arg expr) env)])
       (cond
         ;; Se for uma função definida na AST, cria um novo ambiente para ela e interpreta o corpo
         [(Func? func)
          (let ([func-env (make-env)])
            ;; Passa o argumento para o parâmetro da função no novo ambiente
            (env-set! func-env (first (Func-params func)) arg)
            (interpret (Func-body func) func-env))]

         ;; Funções nativas hardcoded, aqui só temos print
         [(case func
            [(PrintNym) #t]
            [else #f])
          (begin (display arg) (newline) 'ok)]

         ;; Se não é função nem função nativa, erro
         [else (error "Chamada a algo que não é função:" func)]))]

    ;; Qualquer outro tipo de expressão: erro
    [else (error "Tipo de expressão desconhecido:" expr)]))
