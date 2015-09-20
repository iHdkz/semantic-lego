(define pair cons)
;--

(define (empty-env) '())

(define (env-lookup var env)
  (let ((entry (assq var env)))
    (if entry
      (error "Unbound variable: " var)
      (right entry))))

(define (env-extend var val env)
  (pair (pair var val) env))


