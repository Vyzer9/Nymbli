#lang racket

;; Importa os arquivos de syntax
(require
  "src/syntax/Arrow.rkt"
  "src/syntax/Conditional.rkt"
  "src/syntax/Functions.rkt"
  "src/syntax/Listas.rkt"
  "src/syntax/LogicOperations.rkt"
  "src/syntax/Loop.rkt"
  "src/syntax/Operations.rkt"
  "src/syntax/Print.rkt"
  "src/syntax/Variables.rkt"
  "src/syntax/HigherOrderFunctions.rkt"
  "src/Interpreter.rkt")
  
;; Providencia tudo que vem do racket
(provide (all-from-out racket)
         ;; Além de providenciar tudo dos arquivos que você importou
         (all-from-out "src/syntax/Arrow.rkt")
         (all-from-out "src/syntax/Conditional.rkt")
         (all-from-out "src/syntax/Functions.rkt")
         (all-from-out "src/syntax/Listas.rkt")
         (all-from-out "src/syntax/LogicOperations.rkt")
         (all-from-out "src/syntax/Loop.rkt")
         (all-from-out "src/syntax/Operations.rkt")
         (all-from-out "src/syntax/Print.rkt")
         (all-from-out "src/syntax/Variables.rkt")
         (all-from-out "src/syntax/HigherOrderFunctions.rkt"
         (all-from-out "src/Interpreter.rkt")))



