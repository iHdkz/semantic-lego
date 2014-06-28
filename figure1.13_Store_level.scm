;;; S = Sto -> V x Sto

;; Store monad

(define (unitS v)
  (lambda (sto)
    (pair v sto)))

(define (bindS s f)
  (lambda (sto)
    (let ((v*sto (s sto)))
      (let ((v (left v*sto))
	    (sto (right v*sto)))
	((f v) sto)))))

;; Lifted operators

(define (computeS den)
  (computeV (left (den (empty-store)))))

(define %numS	(lift-p1-a0 unitS bindS %numV))
(define %+S	(lift-p0-a2 unitS bindS %+V))
(define %*S	(lift-p0-a2 unitS bindS %*V))

(define %ifS	(lift-if unitS bindS %ifV))

;; New operators

(define ((%fetchS loc) sto)
  (pair (store-fetch loc sto) sto))

(define ((%storeS loc den) sto)
  (let ((v*s (den sto)))
    (let ((v (left v*s))
	  (s (right v*s)))
      (pair 'unit
	    (store-store loc v s)))))

(define ((%beginS d1 d2) sto)
  (d2 (right (d1 sto))))
