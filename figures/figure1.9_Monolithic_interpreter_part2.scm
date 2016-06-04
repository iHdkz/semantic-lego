(define ((((make-op op) d1 d2) env) sto)
  (with-pair ((d1 env) sto)
	     (lambda (v1 s1)
	       (with-pair ((d2 env) s1)
			  (lambda (v2 s2)
			    (pair (op v1 v2) s2))))))
(define %+ (make-op +))
(define %* (make-op *))

(define (((%begin d1 d2) env) sto)
  ((d2 env) (right ((d1 env) sto))))

(define (((%fetch loc) env) sto)
  (pair (store-fetch loc sto) sto))

(define (((%store loc den) env) sto)
  (with-pair ((den env) sto)
	     (lambda (val sto)
	       (pair 'unit (store-store loc val sto)))))

(define (with-pair p k)
  (k (left p) (right p)))
