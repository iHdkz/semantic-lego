(define ((lift-p1-a0 unit bind op) p1)
  (unit (op p1)))

(define ((lift-p1-a1 unit bind op) d1)
  (bind d1
	(lambda (v1)
	  (unit (op v1)))))

(define ((lift-p0-a2 unit bind op) d1 d2)
  (bind d1
	(lambda (v1)
	  (bind d2
		(lambda (v2)
		  (unit (op v1 v2)))))))

(define ((lift-p1-a1 unit bind op) p1 d1)
  (bind d1
	(lambda (v1)
	  (unit (op p1 v1)))))

(define ((lift-if unit bind op) d1 d2 d3)
  (bind d1
	(lambda (v1)
	  (op v1 d2 d3))))
