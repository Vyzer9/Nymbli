#lang racket

;; DEFINIÇÃO DE TIPOS PRIMITIVOS
(struct Type (name) #:transparent)

(define NumberType   (Type 'Number))
(define BooleanType  (Type 'Boolean))
(define StringType   (Type 'String))
(define ListType     (Type 'List))
(define FunctionType (Type 'Function))

;; FUNÇÃO DE VERIFICAÇÃO DE TIPOS
(define (valid-type? t)
  (and (Type? t)
       (member (Type-name t)
               '(Number Boolean String List Function))))

;; INFERÊNCIA DE TIPO SIMPLES
(define (type-of expr)
  (cond
    [(number? expr)  NumberType]
    [(boolean? expr) BooleanType]
    [(string? expr)  StringType]
    [(list? expr)    ListType]
    [(procedure? expr) FunctionType]
    [else (error "Tipo desconhecido para:" expr)]))

(provide Type valid-type?
         NumberType BooleanType StringType ListType FunctionType
         type-of)
