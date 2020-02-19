(defun chiperAlp (chr)
	; takes a char, converts cipher char
	(case chr
		('a 'e)
		('b 'd)
		('c 'f)
		('d 'p)
		('e 'a)
		('f 'q)
		('g 'b)
		('h 'k)
		('i 'n)
		('j 'c)
		('k 'r)
		('l 's)
		('m 'j)
		('n 'o)
		('o 'y)
		('p 'z)
		('q 'h)
		('r 't)
		('s 'i)
		('t 'm)
		('u 'l)
		('v 'g)
		('w 'u)
		('x 'v)
		('y 'w)
		('z 'x)
	)
)

(defun encoderForWords(dicWord)
	(if (null dicWord) nil
		(append 
			(list (chiperAlp (car dicWord))) (encoderForWords (cdr dicWord))
		)
	)
)

(defun encoderForText (text)
	(if (null text) nil
		(append 
			(list (encoderForWords (car text))) (encoderForText (cdr text))
		)
	)
)

(defun encoderForDocument(document)
	(if (null document) nil
		(append 
			(list (encoderForText (car document))) (encoderForDocument (cdr document))
		)
	)
)


(defun testEncoder ()
	(format t "Encoder for chiperAlp: ~a -> ~a ~%" 'd (chiperAlp 'd) )
	(format t "Encoder for words: ~a -> ~a ~%" '(d e g e r) (encoderForWords '(d e g e r) ) )
	(format t "Encoder for text ~a : ~a ~%" '((d e g e r)(m a n d a l)) 
											 (encoderForText '((d e g e r)(m a n d a l)) 
											 ) 
	)
)


(testEncoder)