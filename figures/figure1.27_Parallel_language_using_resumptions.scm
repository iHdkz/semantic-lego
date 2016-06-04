;; Computation and language ADTs

(define computations
  (make-computations resumptions stores lists))

(load "error-values" "numbers" "booleans" "begin" "while"
      "products" "numeric-predicates" "amb" "stores" "resumptions")

;; Examples

(compute
  (%par (%num 1) (%num 2) (%num 3)))

;; => (1 2 1 3 2 3)

(compute
  (%seq
    (%store 'x (%unit))
    (%par
      (%store 'x (%pair (%num 3) (%fetch 'x)))
      (%store 'x (%pair (%num 2) (%fetch 'x)))
      (%store 'x (%pair (%num 1) (%fetch 'x))))
    (%fetch 'x)))

;; =>
;; ((pair 3 (pair 2 (pair 1 unit)))
;;  (pair 2 (pair 3 (pair 1 unit)))
;;  (pair 3 (pair 1 (pair 2 unit)))
;;  (pair 1 (pair 3 (pair 2 unit)))
;;  (pair 2 (pair 1 (pair 3 unit)))
;;  (pair 1 (pair 2 (pair 3 unit))))

(compute
  (%seq
    (%store 'x (%num 1))
    (%store 'go (%true))
    (%par
      (%store 'go (%false))
      (%while (%and (%fetch 'go)
		    (%< (%fetch 'x) (%num 7)))
	      (%pause (%store 'x (%1+ (%fetch 'x))))))
    (%fetch 'x)))

;; => (2 3 4 5 6 7 7 1)

