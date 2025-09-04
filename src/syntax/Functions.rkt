#lang racket

;; Struct para representar funções definidas pelo usuário
(struct func (name params body) #:transparent)

;; Struct para representar chamadas de função
(struct call (name args) #:transparent)
