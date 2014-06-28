;;; E	 = Env -> S
;;; Proc = V -> S

;; Environment monad

(define (unitE s)
  (lambda (env) s))

(define (bindE e f)
  (lambda (env)
    ((f (e env)) env)))

;; Lifted operators

(define (compute den)
  (comuteS (den (empty-env))))

(define %num (lift-p1-a0 unitE bindE %numS))

(define %+ (lift-p0-a2 unitE bindE %+S))
(define %* (lift-p0-a2 unitE bindE %*S))

(define %if (lift-if unitE bindE %ifS))

(define %fetch (lift-p1-a0 unitE bindE %fetchS))
(define %store (lift-p1-a1 unitE bindE %storeS))
(define %begin (lift-p0-a2 unitE bindE %beginS))

;; New operators

(define ((%var name) env)
  (unitS (env-lookup name env)))

(define ((%lambda name den) env)
  (unitS
    (lambda (val)
      (den (env-extend name val env)))))

(define ((%call d1 d2) env)
  (bindS (d1 env)
	 (lambda (v1)
	   (bindS (d2 env)
		  (lambda (v2)
		    (v1 v2))))))

