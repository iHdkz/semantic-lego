(define %amb
  (let ((unit (get-unit 'lists 'top))
	(bind (get-bind 'lists 'top)))
    (lambda (x y)
      (bind x
	    (lambda (lx)
	      (bind y
		    (lambda (ly)
		      (unit (append lx ly)))))))))
