Functor
;; mapT : (A -> B) -> (T(A) -> T(B))

(mapT id)	 = id
(mapT (oC g f)	 = (oD (mapT g) (mapT f))


;; T(A) = A × A

(define ((map f) ta)
  (pair (f (left ta)) (f (right ta))))

;; T(A) = Env -> A

(define (((map f) ta) env)
  (f (ta env)))

Natural transformation

sigma:S(A) -> T(A)



(define ((unit a) env)
  a)

(define ((join tta) env)
  ((tta env) env))

;; Motivation
(define (unitS a)
  (lambda (sto) (pair a sto)))

(define (unitL a)
  (list a))


(define (unitT a)
  (pair a (empty-store))
;; Formalization

;; F(T)(A) = List(T(A))

(define ((mapF K) fta)
  (map K fta))


;; F(T)(A) = Env -> T(A)

;; unitFT : A -> F(T)(A)
;; bindFT : F(T)(A) x (A -> F(T)(B)) -> F(T)(B)

(define (unitFT a)
  (lambda (env) (unitT a)))

(define (bindFT fta f)
  (lambda (env)
    (bindT (fta env)
	   (lambda (a)
	     ((f a) env)))))


;; F(T)(A) = Env -> T(A)

;; mapF : (S(A) -> T(A)) -> (F(S)(A) -> F(T)(A))

(define (((mapF K) fsa) env)
  (K (fsa env)))


;; F(T)(A) = Env -> T(A)

;; unitF : T(A) -> F(T)(A)
;; bindF : F(T)(A) x (T(A) -> F(T)(B)) -> F(T)(B)

(define (unitF ta)
  (lambda (env) ta))

(define (bindF fta f)
  (lambda (env)
    ((f (fta env)) env)))

;; Classes of monad transformers

(define (bindFT fta f)
  (bindT fta
	 (lambda (env->a)
	   ...)))

(define (bindFT fta f)
  (unitT
    (lambda (env)
      (bindT fta		 ; ***
	     (lambda (env->a)
	       (env->a env))))))

;; Composition of monad transformers

(compose
 environments
 stores
 continuations
 nondeterminism
 exceptions))
