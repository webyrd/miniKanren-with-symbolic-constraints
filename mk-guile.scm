(import (rnrs sorting (6))
        (rnrs lists (6)))

(define (sub1 n)
  (- n 1))

(define call-with-string-output-port call-with-output-string)

(define (printf format-string . args)
  (display (apply format #f format-string args)))

(load "mk.scm")
