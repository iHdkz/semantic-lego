(define ((unit2 a) k)
  (unitM a))

(define ((bind2 c f) k)
  (bindM (c k)
    (lambda (a)
      ((f a) k))))