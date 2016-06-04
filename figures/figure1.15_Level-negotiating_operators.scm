;; E = Env -> S
;; S = Sto -> V x Sto
;; V = Val

(define ((unitSE s) env)
  s)

(define ((unitVS v) sto)
  (pair v sto))

(define (((unitVE v) env) sto)
  (pair v sto))

(define ((bindSE t f) env)
  ((f (t env)) env))

(define (((bindVE t f) env) sto)
  (let ((p ((t env) sto)))
    (let ((v (left p))
	  (s (right p)))
      (((f v ) env) s))))

