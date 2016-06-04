;; E	= Env -> S
;; S	= Sto -> V x Sto
;; V	= Val
;; Proc = V -> S

(define (%num v)
  (unitVE v))

(define ((%var name) env)
  (unitVS (env-lookup env name)))

(define ((%lambda name den) env)
  (unitVS
    (lambda (val)
      (den (env-extend env name val)))))

(define (%call d1 d2)
  (bindVE d1
	  (lambda (v1)
	    (bindVE d2
		    (lambda (v2)
		      (unitSE (v1 v2)))))))

(define (%if d1 d2 d3)
  (bindVE d1
	  (lambda (v1)
	    (if v1 d2 d3))))
