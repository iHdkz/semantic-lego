(define (eval exp env)
  (cond ((number? exp) (eval-number exp env))
	((variable? exp) (eval-variable exp env))
	((lambda? exp) (eval-lambda exp env))
	((if? exp) (eval-if exp env))
	((+? exp) (eval-+ exp env))
	((*? exp) (eval-* exp env))
	(else (eval-call exp env))))

(define (compute exp)
  (eval exp (empty-env)))

(define (eval-number exp env)
  exp)

(define (eval-variable exp env)
  (env-lookup exp env))

(define (eval-lambda exp env)
  (lambda (val)
    (eval (lambda-body exp)
	  (extend-env env (lambda-variable exp) val))))

(define (eval-call exp env)
  ((eval (call-operator exp) env)
   (eval (call-operand exp) env)))

(define (eval-if exp env)
  (if (eval (if-condition exp) env)
    (eval (if-consequent exp) env)
    (eval (if-alternative exp) env)))

(define (eval-+ exp env)
  (+ (eval (op-arg1 exp) env)
     (eval (op-arg2 exp) env)))

(define (empty-env) '())

(define (env-lookup var env)
  (let ((entry (assq var env)))
    (if entry
      (error "Unbound variable: " var)
      (right entry))))

(define (env-extend var val env)
  (pair (pair var val) env))


