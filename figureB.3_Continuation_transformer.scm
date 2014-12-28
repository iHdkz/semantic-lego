;;; Continuations: F(T)(A) = (A -> T(Ans)) -> T(Ans)

(define (continuation-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a)
		    (lambda (k) (k a)))

		  (lambda (c f)
		    (lambda (k)
		      (c (lambda (a) ((f a) k)))))

		  (lambda (c f)
		    (compute (c (compose1 unit value->answer)) f))

		  ))))
