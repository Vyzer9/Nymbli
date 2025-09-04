#lang racket

(provide parse-tokens)

(define (parse-tokens tokens)
  (define (parse-expr toks)
    (match toks
      [(cons "(" rest)
       (define-values (list-expr rest2) (parse-list rest))
       (if (and (pair? rest2) (equal? (first rest2) ")"))
           (values list-expr (rest rest2))
           (error "Parêntese não fechado"))]
      [(cons token rest)
       (values token rest)]
      ['() (error "Expressão vazia inesperada")])) ;; <- trata lista vazia

  (define (parse-list toks)
    (define (loop toks acc)
      (match toks
        [(cons ")" rest)
         (values (reverse acc) rest)]
        [(cons "(" _) (error "Parêntese aberto inesperado")]
        [(cons token rest2)
         (define-values (expr rest3) (parse-expr (cons token rest2)))
         (loop rest3 (cons expr acc))]
        ['() (error "Fim inesperado: parêntese não fechado")]))
    (loop toks '()))

  ;; início do parsing
  (define-values (expr rest) (parse-expr tokens))
  (if (null? rest)
      expr
      (error "Tokens restantes após parse")))
