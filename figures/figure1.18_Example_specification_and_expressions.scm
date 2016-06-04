;; Computation ADT
(define computations
  (make-computations
    cbv-environments stores continuations nondeterminism errors))

;; Language ADT

(load "error-exceptions" "numbers" "booleans" "numeric-predicates"
      "amb" "procedures" "environments" "stores" "while" "callcc")

;; Basic Semantics

(show-computations)

=> (-> Env
       (-> Sto
	   (let A0 (* Val Sto)
	     (let A1 (+ (list A0) Err)
	       (-> (-> A0 A1) A1)))))

;; Sample expressions

(compute
  (%call (%lambda 'x (%+ (%var 'x) (%var 'x)))
	 (%amb (%num 1) (%num 2))))

=> (2 4)	 ; would be (2 3 3 4) in call-by-name

(compute
  (%begin
    (%store 'n (%amb (%num 4) (%num 5)))
    (%store 'r (%num 1))
    (%call/cc
      (%lambda 'exit
	       (%while (%true)
		       (%begin
			 (%if (%zero? (%fetch 'n))
			      (%call (%var 'exit) (%fetch 'r))
			      (%unit))
			 (%store 'r (%* (%fetch 'r) (%fetch 'n)))
			 (%store 'n (%- (%fetch 'n) (%num 1)))))))))

=> (24 120)
