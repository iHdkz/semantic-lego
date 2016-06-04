;; S(A) = EnvS -> A
;; T(A) = EnvT -> A
;; ST(A) = EnvS -> Env T -> A

(define ((joinS ssa) envS)
  ((ssa envS) envS))

(define ((joinT tta) envT)
  ((tta envT) envT))

(define (((joinST ststa) envS) envT)
  ((((ststa envS) envT) envS) envT))
