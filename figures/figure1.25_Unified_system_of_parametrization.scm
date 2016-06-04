;; Computation and language ADTs

(define computations
  (make-computations cbn-environments exp-environments))

(load "error-values" "numbers" "booleans" "numeric-predicates"
      "environmens" "exp-environments")

;; Simplified %evar and %elet

(lambda (name)
  (lambda (env)
    (lambda (eenv)
      (if (env-lookup eenv name)
	((right (env-lookup eenv name)) eenv) ; ***
	(in 'errors (unbound-error name))))))

(lambda (name c1 c2)
  (lambda (env)
    (lambda (eenv)
      ((c2 env) (env-extend eenv name (c1 env))))))
