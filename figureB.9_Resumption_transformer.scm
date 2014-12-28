;;; Resumptions: F(T)(A) = fix(X) T(A + X)

(define (resumption-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a) (unit (in-left a)))

		  (lambda (c f)
		    (let loop ((c c))
		      (bind c
			    (sum-function
			      f (lambda (c)
				  (unit (in-right (loop c))))))))

		  (lambda (c f)
		    (compute
		      (let loop ((c c))
			(bind c
			      (sum-function
				(compose1 unit f)
				loop)))
		      id))

		  ))))
