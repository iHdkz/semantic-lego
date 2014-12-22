;; Computation ADT

(define computations
  (make-computations environments nondeterminism continuations))

;; Basic semantics

(-> Env (let AO (List Ans) (-> (-> (List Val) AO) AO)))

;; Simplified %amb

(lambda (x y)
  (lambda (env)
    (lambda (k)
      ((x env)
       (lambda (a)
	 ((y env)
	  (lambda (a0)
	    (k (append a a0)))))))))

;; Example

(compute
  (%+ (%num 1)
      (%call/cc
	(%lambda 'k
		 (%* (%num 10)
		     (%amb (%num 3) (%call (%var 'k) (%num 4))))))))

;; => (5)
