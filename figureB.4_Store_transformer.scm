;;; Stores: F(T)(A) = Sto -> T(A * Sto)

(define (store-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a)
		    (lambda (sto)
		      (unit (pair a sto))))

		  (lambda (c f)
		    (lambda (sto)
		      (bind (c sto)
			    (lambda (as)
			      ((f (left as)) (right as))))))

		  (lambda (c f)
		    (compute (c (initial-store))
			     (lambda (a*s)
			       (compute-store (f (left a*s)) (right a*s)))))

		  ))))
