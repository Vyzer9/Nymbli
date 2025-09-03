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

;; Seus testes aqui
(require rackunit)

;; Teste para nymbl-map
(check-equal?
  (nymbl-map (λ (x) (* x 2)) '(1 2 3))
  '(2 4 6))

;; Teste para nymbl-filter
(check-equal?
  (nymbl-filter (λ (x) (even? x)) '(1 2 3 4))
  '(2 4))

;; Teste para nymbl-reduce
(check-equal?
  (nymbl-reduce + 0 '(1 2 3 4))
  10)

;; Teste para nymbl-for-each (efeito colateral em lista mutável)
(define resultado '())
(nymbl-for-each (λ (x) (set! resultado (append resultado (list (* x 2))))) '(1 2 3))
(check-equal? resultado '(2 4 6))

;; Teste para nymbl-any?
(check-equal?
  (nymbl-any? (λ (x) (> x 3)) '(1 2 3 4 5))
  #t)

(check-equal?
  (nymbl-any? (λ (x) (> x 10)) '(1 2 3))
  #f)

;; Teste para nymbl-all?
(check-equal?
  (nymbl-all? (λ (x) (number? x)) '(1 2 3 4))
  #t)

(check-equal?
  (nymbl-all? (λ (x) (< x 3)) '(1 2 3))
  #f)

;; Teste para nymbl-find
(check-equal?
  (nymbl-find (λ (x) (= x 3)) '(1 2 3 4 5))
  3)

(check-equal?
  (nymbl-find (λ (x) (> x 10)) '(1 2 3))
  #f)

(displayln "✅ Todos os testes passaram!")
