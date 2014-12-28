;;; Exceptions: F(T)(A) = T(A + X)

(define (exception-trans t)
  (with-monad t
	      (lambda(unit bind compute)
		(make-monad

		  (lambda (a) (unit (in-left a)))

		  (lambda (c f)
		    (bind c (sum-function f (lambda (x) (unit (in-right x))))))
		  (lambda (c f)
		    (compute c (sum-function f compute-x)))

		  ))))
