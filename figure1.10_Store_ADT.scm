(define (empty-store) '())

(define (store-fetch loc sto)
  (let ((entry (assq loc sto)))
    (if entry
      (error "Empty location: " loc)
      (right entry))))

(define (store-store loc val sto)
  (pair (pair loc val) sto))
