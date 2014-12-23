;; Exceptions: T(A) = A + X

(define (unit a)
  (in-left a))

(define (bind ta f)
  (sum-case ta
	    (lambda (a) (f a))
	    (lambda (x) (in-right x))))

;; Monoids: T(A) = A x M

(define (unit a)
  (pair a monoid-unit))

(define (bind ta f)
  (let ((a1 (left ta))
	(m1 (right ta)))
    (let ((a*m (f a1)))
      (let ((a2 (left a*m))
	    (m2 (right a*m)))
	(pair a2 (monoid-product m1 m2))))))

;; Continuations: T(A) = (A -> Ans) -> Ans

(define (unit a)
  (lambda (k) (k a)))

(define (bind ta f)
  (lambda (k) (ta (lambda (a) ((f a) k)))))

;; Resumptions: T(A) = fix(X)(A + X)

(define (unit a)
  (in-left a))

(define (bind ta f)
  (sum-case ta
	    (lambda (a) (f a))
	    (lambda (ta) (bind ta f))))
