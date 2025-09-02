#lang racket


;; Structs existentes
(struct func (name params body) #:transparent)
(struct call (name args) #:transparent)

;; Ambiente global (hash mutável)
(define env (make-hash))

;; Mini interpretador
(define (interpret expr env)
  (cond
    ;; Literais
    [(number? expr) expr]
    
    ;; Variáveis
    [(symbol? expr)
     (hash-ref env expr (lambda () (error "Variável não encontrada:" expr)))]
    
    ;; Operações matemáticas
    [(and (list? expr) (symbol? (first expr))
          (member (first expr) '(+ - * /)))
     (apply (eval (first expr))
            (map (lambda (e) (interpret e env)) (rest expr)))]
    
    ;; Chamada de função
    [(call? expr)
     (define f (hash-ref env (call-name expr)
                         (lambda () (error "Função não encontrada:" (call-name expr)))))
     (define arg-vals (map (lambda (e) (interpret e env)) (call-args expr)))
     (define new-env
       (for/fold ([acc env])
                 ([param (func-params f)]
                  [arg arg-vals])
         (hash-set acc param arg)))
     (interpret (func-body f) new-env)]

    [else (error "Expressão inválida:" expr)]))

;; =========================
;; Criando uma função soma
;; =========================
(define soma-func
  (func 'soma '(a b)
    '(+ a b)))

;; Adiciona função ao ambiente
(hash-set! env 'soma soma-func)

;; Teste de chamada: (soma 3 4)
(define resultado
  (interpret (call 'soma '(3 4)) env))

(displayln (string-append "Resultado da soma: " (number->string resultado)))
