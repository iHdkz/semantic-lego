(compute
  (%let 'f (%* (%evar 'x) (%evar 'x))
	(%+ (%elet 'x (%num 3) (%var 'f))
	    (%elet 'x (%num 4) (%var 'f)))))

;; => 25

(compute
  (%let 'g (%+ (%evar 'a) (%evar 'a))
	(%let 'f (%elet 'a (%* (%evar 'x) (%evar 'x))
			(%var 'g))
	      (%elet 'x (%num 3) (%var 'f)))))

;; => 18
