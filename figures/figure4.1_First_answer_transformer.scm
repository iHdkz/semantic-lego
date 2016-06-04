(define ((unit1 a) k)
  (bindT (unitM a) k))

(define ((bind1 c f) k)
  (bindM (c unitT)
    (lambda (a)
      ((f a) k))))