(define (b-eval exp env)
  (cond ((number? exp) (eval-number exp env))
        ((variable? exp) (eval-variable exp env))
        ((lambda? exp) (eval-lambda exp env))
        ((if? exp) (eval-if exp env))
        ((+? exp) (eval-+ exp env))
        ((*? exp) (eval-* exp env))
        (else (eval-call exp env))))

(define (compute exp)
  (b-eval exp (empty-env)))

(define (eval-number exp env)
  exp)

(define (eval-variable exp env)
  (env-lookup exp env))

(define (eval-lambda exp env)
  (lambda (val)
    (b-eval(lambda-body exp)
	  (env-extend env (lambda-variable exp) val))))

(define (eval-call exp env)
  ((b-eval(call-operator exp) env)
   (b-eval(call-operand exp) env)))

(define (eval-if exp env)
  (if (b-eval(if-condition exp) env)
    (b-eval(if-consequent exp) env)
    (b-eval(if-alternative exp) env)))

(define (eval-+ exp env)
  (+ (b-eval (op-arg1 exp) env)
     (b-eval (op-arg2 exp) env)))

(define (eval-* exp env)
  (* (b-eval (op-arg1 exp) env)
     (b-eval (op-arg2 exp) env)))
