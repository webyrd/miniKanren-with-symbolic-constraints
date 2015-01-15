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

(define (find p l)
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

(define call-with-string-output-port call-with-output-string)

(load "mk.scm")
