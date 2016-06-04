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

;; 2.3 monad morphism
;; f : A →S(B)
;; g : B →S(C)

(mapK idS)	 = idT
(mapK (oS g f))	 = (oT (mapK g) (mapK f))


(K (unitS a))	 = (unitT a)
(K (bindS sa f)) = (bindT (K sa) (o K f)) 


(reverse (list a))	   = (list a)
(reverse (append-map f l)) = (append-map (o reverse f) (reverse l))

;; Motivation
(define (unit a)
  (lambda (sto) (list (pair a sto))))

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

;; Chapter 3 Lifting

;; 3.1 Formal lifting
(define ((mapS' f) p)
  (pair (f (left p)) (f (right p))))

(define (sigma a) (pair a a))


(f (pair a a)) = a


;; S'(A) = List(A)

(define (mapS' f l) (map f l))

(define (sigma a) (list a))

T(A) = List(A)
append : T(A) x T(A) → T(A)

;; F(T)(A) = Env -> T(A)
(define (unitF ta)
  (lambda (env) ta))

;; lifted-append : F(T)(A) x F(T)(A) -> F(T)(A)
(define (lifted-append fta1 fta2)
  (lambda (env)
    (append (fta1 env) (fta2 env))))


(define (F ta tb)
  (bind ta
	(lambda (a)
	  (bind tb
		(lambda (b)
		  (unit (f a b)))))))


(F (unit a) (unit b)) = (unit (f a b))


(F (unit a) (unit b))

= (bind (unit a)
	(lambda (a)
	  (bind (unit b)
		(lambda (b)
		  (unit (f a b))))))

= (bind (unit b)
	(lambda (b)
	  (unit (f a b))))

= (unit (f a b))


;; %var : Name -> Env -> T(A)
;; Env = Name -> A

(define (%var name)
  (lambda (env) (unitT (env-lookup env name))))

; Monads and lifting

(define (F ta tb)
  (bind ta
	(lambda (a)
	  (bind tb
		(lambda (b)
		  (unit (f a b)))))))

