;; (load "mk-chibi.scm")
;; (load "test-all.scm")

;; https://srfi.schemers.org/srfi-28/srfi-28.html
(define format
  (lambda (format-string . objects)
    (let ((buffer (open-output-string)))
      (let loop ((format-list (string->list format-string))
                 (objects objects))
        (cond ((null? format-list) (get-output-string buffer))
              ((char=? (car format-list) #\~)
               (if (null? (cdr format-list))
                   (error 'format "Incomplete escape sequence")
                   (case (cadr format-list)
                     ((#\a)
                      (if (null? objects)
                          (error 'format "No value for escape sequence")
                          (begin
                            (display (car objects) buffer)
                            (loop (cddr format-list) (cdr objects)))))
	             ((#\s)
                      (if (null? objects)
                          (error 'format "No value for escape sequence")
                          (begin
                            (write (car objects) buffer)
                            (loop (cddr format-list) (cdr objects)))))
                     ((#\%)
                      (newline buffer)
                      (loop (cddr format-list) objects))
                     ((#\~)
                      (write-char #\~ buffer)
                      (loop (cddr format-list) objects))
                     (else
                      (error 'format "Unrecognized escape sequence")))))
              (else (write-char (car format-list) buffer)
                    (loop (cdr format-list) objects)))))))

(define (printf . args)
  (display (apply format args)))

(define (sub1 n)
  (- n 1))

(import (srfi 95))
(define (list-sort x y) (sort y x))

(define (exists p l)
  (if (null? l)
    #f
    (let ((res (p (car l))))
      (if (null? (cdr l))
        res
        (if res
          res
          (exists p (cdr l)))))))

(import (srfi 1))
#;(define (find p l)
  (if (null? l)
      #f
      (if (p (car l))
          (car l)
          (find p (cdr l)))))

(define (remp p l)
  (if (null? l)
      '()
      (if (p (car l))
          (remp p (cdr l))
          (cons (car l) (remp p (cdr l))))))

(define (for-all p l)
  (if (null? l)
    #t
    (let ((res (p (car l))))
      (if (null? (cdr l))
        res
        (if res
          (for-all p (cdr l))
          #f)))))

(import (chibi io))
(define call-with-string-output-port call-with-output-string)

(load "mk.scm")
