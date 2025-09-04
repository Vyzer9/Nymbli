#lang racket

(require racket/list) ;; Para foldl

(provide
  nymbl-map
  nymbl-filter
  nymbl-reduce
  nymbl-for-each
  nymbl-any?
  nymbl-all?
  nymbl-find)

;; Define map
(define (nymbl-map f lst)
  (map f lst))

;; Define filter
(define (nymbl-filter pred lst)
  (filter pred lst))

;; Define reduce (left fold)
(define (nymbl-reduce f init lst)
  (foldl f init lst))

;; Define for-each
(define (nymbl-for-each f lst)
  (for-each f lst))

;; Define any? (some)
(define (nymbl-any? pred lst)
  (cond
    [(empty? lst) #f]
    [(pred (first lst)) #t]
    [else (nymbl-any? pred (rest lst))]))

;; Define all? (every)
(define (nymbl-all? pred lst)
  (cond
    [(empty? lst) #t]
    [(pred (first lst)) (nymbl-all? pred (rest lst))]
    [else #f]))

;; Define find
(define (nymbl-find pred lst)
  (cond
    [(empty? lst) #f]
    [(pred (first lst)) (first lst)]
    [else (nymbl-find pred (rest lst))]))
(displayln "✅ Todos os testes passaram!")
