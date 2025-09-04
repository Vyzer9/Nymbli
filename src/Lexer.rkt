#lang racket

(require racket/string)
(require racket/base)

(provide lexer)

(define (lexer input)
  (define tokens '())
  (define len (string-length input))
  (define i 0)
  
  (define (peek) (if (< i len) (string-ref input i) #\null))
  (define (advance) (set! i (+ i 1)))
  
  (define (is-space? c) (char-whitespace? c))
  (define (is-digit? c) (char-numeric? c))
  (define (is-alpha? c) (or (char-alphabetic? c) (char=? c #\_)))
  
  (define (read-while pred)
    (let loop ((start i))
      (if (and (< i len) (pred (peek)))
          (begin (advance) (loop start))
          (substring input start i))))
  
  (define (read-string)
    (advance) ;; pular a primeira aspas
    (let loop ((start i))
      (cond
        [(>= i len) (error "String não fechada")]
        [(char=? (peek) #\") (begin (advance) (substring input start i))]
        [else (advance) (loop start)])))
  
  (let loop ()
    (when (< i len)
      (let ([c (peek)])
        (cond
          [(is-space? c) (advance) (loop)]
          [(or (char=? c #\() (char=? c #\))) 
           (set! tokens (append tokens (list (string c)))) 
           (advance) 
           (loop)]
          [(member c (list #\+ #\- #\* #\/ #\=)) 
           (set! tokens (append tokens (list (string c)))) 
           (advance) 
           (loop)]
          [(char=? c #\") 
           (set! tokens (append tokens (list (read-string)))) 
           (loop)]
          [(is-digit? c)
           (let ([num (read-while is-digit?)])
             (set! tokens (append tokens (list (string->number num))))
             (loop))]
          [(is-alpha? c)
           (let ([id (read-while (lambda (ch) (or (is-alpha? ch) (is-digit? ch))))])
             (set! tokens (append tokens (list id)))
             (loop))]
          [else (error "Caractere inesperado:" c)])))
    tokens))
