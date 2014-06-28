(define ((make-op op) d1 d2)
  (bindVE d1
	  (lambda (v1)
	    (bindVE d2
		    (lambda (v2)
		      (unitVE (op v1 v2)))))))

(define %+ (make-op +))
(define %* (make-op *))

(define (%begin d1 d2)
  (beindVE d1
	   (lambda (v1)
	     d2)))

(define (%fetch loc)
  (unitSE
    (lambda (sto)
      (pair (store-fetch loc sto) sto))))

(define (%store loc den)
  (bindVE den
	  (lambda (val)
	    (unitSE
	      (lambda (sto)
		(pair 'unit (store-store loc val sto)))))))

