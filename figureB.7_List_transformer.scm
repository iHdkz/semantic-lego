;;; Lists: F(T)(A) = T(List(A))

(define (list-trans t)
  (with-monad t
	      (lambda (unit bind compute)

		(define (amb x y)
		  (bind x
			(lambda (x)
			  (bind y
				(lambda (y)
				  (unit (append x y)))))))

		(make-monad

		  (lambda (a)
		    (unit (list a)))

		  (lambda (c f)
		    (bind c
			  (lambda (l)
			    (reduce amb (unit '()) (map f l)))))

		  (lambda (c f)
		    (compute c (lambda (l) (map f l))))

		  ))))
