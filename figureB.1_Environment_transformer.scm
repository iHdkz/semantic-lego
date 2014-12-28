;; Environments: F(T)(A) = Env -> T(A)

(define (env-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a)
		    (lambda (env) (unit a)))
		  
		  (lambda (c f)
		    (lambda (env)
		      (bind (c env)
			    (lambda (a)
			      ((f a) env)))))

		  (lambda (c f)
		    (compute (c empty-env) f))

		  ))))
