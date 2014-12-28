;;; Lifting 1: F(T)(A) = 1 -> T(A)

(define (lift1-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a)
		    (lambda () (unit a)))

		  (lambda (c f)
		    (lambda ()
		      (bind (c) (lambda (a) ((f a))))))

		  (lambda (c f)
		    (compute (c) f))

		  ))))
