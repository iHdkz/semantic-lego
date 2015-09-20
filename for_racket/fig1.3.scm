
(define first car)
(define second cadr)
(define third caddr)
(define fourth cadddr)
;--
(define variable? symbol?)

(define (lambda? exp)
  (eq? 'lambda (first exp)))

(define lambda-variable second)
(define lambda-body third)

(define call-operator first)
(define call-operand second)

(define (if? exp)
  (eq? 'if (first exp)))

(define if-condition second)
(define if-consequent third)
(define if-alternative fourth)

(define (+? exp)
  (eq? '+ (first exp)))

(define (*? exp)
  (eq? '* (first exp)))

(define op-arg1 second)
(define op-arg2 third)
