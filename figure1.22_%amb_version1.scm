;; Computation ADT
(define computations
  (make-computations environments continuations nondeterminism))

;; Basic semantics

(-> Env (let AO (List Ans) (-> (-> Val AO) AO)))

;; Simplified %amb

(lambda (x y)
  (lambda (env)
    (lambda (k)
      (reduce append ()
	      (map k (append ((x env) list) ((y env) list)))))))

;; Example

(compute
  (%+ (%num 1)
      (%call/cc
	(%lambda 'k
		 (&* (%num 10)
		     (%amb (%num 3) (%call (%var 'k) (%num 4))))))))

;; => (31 51)
