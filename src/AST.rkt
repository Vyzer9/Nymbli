#lang racket

;; Representações da AST
(struct Literal (value) #:transparent)
(struct Var (name) #:transparent)
(struct Let (name value body) #:transparent)
(struct If (cond then else) #:transparent)
(struct Func (params body) #:transparent)
(struct Call (fn arg) #:transparent)

(provide (struct-out Literal)
         (struct-out Var)
         (struct-out Let)
         (struct-out If)
         (struct-out Func)
         (struct-out Call))
