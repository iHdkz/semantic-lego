(define %let
  (let ((unitE (get-unit 'envs 'top))
	(bindE (get-bind 'envs 'top))
	(bindV (get-bind 'env-values 'top)))
    (lambda (name c1 c2)
      (bindV c1
	     (lambda (v1)
	       (bindE c2
		      (lambda (e2)
			(unitE
			  (lambda (env)
			    (e2 (env-extend env name v1)))))))))))
