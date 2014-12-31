(lambda (name c1 c2)
  (lambda (env)
    (lambda (sto)
      (lambda (k)
	(((c1 env) sto)
	 (lambda (a)	 ; Val x Sto
	   (((c2 (env-extend env name (left a))) (right a)) k)))))))
