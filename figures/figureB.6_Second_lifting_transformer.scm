;;; Lifting 2: F(T)(A) = T(1 -> A)

(define (lift2-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a)
		    (unit (lambda () a)))

		  (lambda (c f)
		    (bind c (lambda (l) (f (l)))))

		  (lambda (c f)
		    (compute c (lambda (l) (f (l)))))

		  ))))
