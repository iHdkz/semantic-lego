;; Computation ADT

(define computations
  (make-computations environments continuations2 nondeterminism))

;; Basic semantics

(-> Env (let AO (List Ans) (-> (-> Val AO) AO)))

;; Simplified %amb

(lambda (x y)
  (lambda (env)
    (lambda (k)
      (append ((x env) k) ((y env) k)))))

;; Example

(compute
  (%+ (%num 1)
      (%call/cc
	(%lambda 'k
		 (%* (%num 10)
		     (%amb (%num 3) (%call (%var 'k) (%num 4))))))))

;; => (31 5)

