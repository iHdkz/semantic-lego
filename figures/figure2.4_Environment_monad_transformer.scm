;; F(T)(A) = Env -> T(A)

(define (environment-transformer m)
  (let ((unitT (monad-unit m))
	(mapT  (monad-map m))
	(joinT (monad-join m)))

    (define (unit a)
      (lambda (env) (unitT a)))

    (define ((map f) fta)
      (lambda (env)
	((mapT f) (fta env))))

    (define (join ftfta)
      (lambda (env)
	(joinT
	  ((mapT (lambda (fta) (fta env)))
	   (ftfta env)))))
    (make-monad unit map join)))


