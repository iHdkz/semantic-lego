;;; Monoids: F(T)(A) = T(A * M)

(define (monoid-trans t)
  (with-monad t
	      (lambda (unit bind compute)
		(make-monad

		  (lambda (a) (unit (pair a (monoid-unit))))

		  (lambda (c f)
		    (bind c
			  (lambda (a*m)
			    (let ((c2 (f (left a*m))))
			      (bind c2
				    (lambda (a*m2)
				      (unit
					(pair (left a*m2
						    (monoid-product
						      (right a*m) (right a*m2)))))))))))

		  (lambda (c f)
		    (compute
		      c (lambda (a*m)
			  (compute-m (f (left a*m)) (right a*m)))))

		  ))))
