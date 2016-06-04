;; Den  = Env -> Val
;; Proc = Val -> Val

(define ((%num n) env)
  n)

(define ((%var name) env)
  (env-lookup name env))

(define ((%lambda name den) env)
  (lambda (val)
    (den (env-extend env var val))))

(define ((%call d1 d2) env)
  ((d1 env) (d2 env)))

(define ((%if d1 d2 d3) env)
  (if (d1 env) (d2 env) (d3 env)))

(define ((%+ d1 d2) env)
  (+ (d1 env) (d2 env)))

(define ((%* d1 d2) env)
  (* (d1 env) (d2 env)))

