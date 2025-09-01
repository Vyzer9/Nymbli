#lang racket

;; Struct para representar funções definidas pelo usuário
(struct func (name params body) #:transparent)

;; Struct para representar chamadas de função
(struct call (name args) #:transparent)

;; ---------------- Exemplos de funções ----------------

;; Função soma: (soma a b) => a + b
(define soma-func
  (func 'soma '(a b)
    '(+ a b)))

;; Função quadrado: (quadrado x) => x * x
(define quadrado-func
  (func 'quadrado '(x)
    '(* x x)))

;; Função fatorial: (fatorial n)
;; if n <= 1 then 1 else n * fatorial(n - 1)
(define fatorial-func
  (func 'fatorial '(n)
    (list 'if
          (list '<= 'n 1)
          1
          (list '* 'n
                (call 'fatorial (list (list '- 'n 1))))))
)
