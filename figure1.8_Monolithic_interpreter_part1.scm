;; Den  = Env → Sto → Val × Sto
;; Proc = Val → Sto → Val × Sto

(define (((%num n) env) sto)
  (pair n sto))

(define (((%var name) env) sto)
  (pair (env-lookup name env) sto))

(define (((%lambda name den) env) sto)
  (pair (lambda (val) (den (env-extend env name val)))
	sto))

(define (((%call d1 d2) env) sto)
  (with-pair ((d1 env) sto)
	     (lambda (v1 s1)
	       (with-pair ((d2 env) s1)
			  (lambda (v2 s2)
			    ((v1 v2) s2))))))

(define (((%if d1 d2 d3) env) sto)
  (with-pair ((d1 env) sto)
	     (lambda (v1 s1)
	       (if v1
		 ((d2 env) s1)
		 ((d3 env) s1)))))
