#lang racket

(require (file "../../Nymbli.rkt"))

(displayln (nymbl-map (lambda (x) (* x x)) '(1 2 3)))
(displayln (nymbl-filter (lambda (x) (> x 2)) '(1 2 3 4)))
(displayln (nymbl-find (lambda (x) (= x 42)) '(10 20 42)))

