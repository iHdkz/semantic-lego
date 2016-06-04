;; Identity: T(A) = A

(define (unit a)
  a)

(define (bind ta f)
  (f ta))

;; Lists: T(A) = List(A)

(define (unit a)
  (list a))

(define (bind ta f)
  (reduce append '() (map f ta)))

;; Environments: T(A) = Env -> A

(define (unit a)
  (lambda (env) a))

(define (bind ta f)
  (lambda (env)
    ((f (ta env)) env)))

;; Stores: T(A) = Sto -> A x Sto

(define (unit a)
  (lambda (sto) (pair a sto)))

(define (bind ta f)
  (lambda (sto)
    (let ((a*s (ta sto)))
      (let ((a (left a*s))
	    (s (right a*s)))
	((f a) s)))))

