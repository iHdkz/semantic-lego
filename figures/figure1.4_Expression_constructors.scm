(define (%num x) x)
(define (%var name) name)
(define (%lambda name exp) (list 'lambda var exp))
(define (%call e1 e2) (list e1 e2))
(define (%if e1 e2 e3) (list 'if e1 e2 e3))
(define (%+ e1 e2) (list '+ e1 e2))
(define (%* e1 e2) (list '* e1 e2))

