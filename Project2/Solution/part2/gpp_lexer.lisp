(setq KEYWORDS '("and" "or" "not" "equal" "less" "nil" "list" "append" "concat" "set" "deffun" "for" "if" "exit" "load" "disp" "true" "false"))

(setq OPERATORS '("+" "-" "/" "*" "(" ")" "**" "\"" "\"" ","))

(setq COMMENT '(";;"))


;......................................
;READ FILE
(defun readChar (s output)
	(let ((c (read-char s nil)))
		(unless (null c)
		  (format output "~c" c)
		  (readChar s output))
	)
)

(defun readFile (filename)
	(with-open-file (s filename)
	  	(with-output-to-string (output)
		    (readChar s output)
	    	output
    	)
	)
)

;.........................................

(defun changeParenthesis(str stringL)
	(setq s (car stringL));ilk elemani s'e ata
	(if (equal s nil) str ;eger ilk eleman yok ise bitmistir listemiz en son elde ettigimiz str'i return et
		(if (equal (string s) "(") ;ac parantez durumu
			(progn;bu islemler sirayla gerceklestirilecek
				;str bos string olarak gonderildi asagidaki islemler bu bos stringi doldurmak icin
				(setq str (concatenate 'string str (string s))) ;s'i str'a ekle (concatenate iki stringi birlestirmek icin) 
				(setq str (concatenate 'string str " ")) ;space koy
				(changeParenthesis str (cdr stringL))) ;tekrar ayni islemler icin kontrol yap

			(if (equal (string s) ")") ;kapa paratez durumlari
				(progn
					(setq str (concatenate 'string str " ")) ;space koy
					(setq str (concatenate 'string str (string s))) ;daha sonra s ile birlestir
					(changeParenthesis str (cdr stringL))) 
				(progn
					(setq str (concatenate 'string str  (string s)));birlestirmeye devam et
					(changeParenthesis str (cdr stringL))) ;control et
			)
		)
	)
)

;space tab ve newline'a gore ayiriyor
(defun seperateTokens (string &optional (separator '(#\Space #\Tab #\Newline)) (r nil))
  	(let ((n (position separator string
		    :from-end t
		    :test #'(lambda (x y)
			    (find y x :test #'string=)))))
	    (if n (seperateTokens  (subseq string 0 n) separator (cons (subseq string (1+ n)) r))
		    (cons string r) )
   	)
)

; Identifier control [a-z A-Z]
(defun isIdentifier (mylist)
	(setq val (car mylist))
	(if (equal val nil)
		t
		(if (or (and (<= (char-code #\a) (char-code val)) (<= (char-code val) (char-code #\z))) 
			(and (<= (char-code #\A) (char-code val)) (<= (char-code val) (char-code #\Z))))
			(isIdentifier (cdr mylist))
			nil
		)
	)
)

; Comment control
(defun isComment (mylist)
	(setq val (car mylist))
	(if (equal val nil)
		t
		(if (equal ";;" (string (car mylist)))
			(isComment (cdr mylist))
		)
	)
)

; Integer control
(defun isInteger(mylist)
	(if (equal "-" (string (car mylist)))
		(isNegative (concatenate 'list (cdr mylist)))
		(isPositive (concatenate 'list mylist))
	)
)

; Negative integer control [1-9]
(defun isNegative (mylist)
	(setq val (car mylist))
	(if (equal val nil)
		t
		(if (and (<= (char-code #\1) (char-code val)) (<= (char-code val) (char-code #\9)))
			(isPositive (cdr mylist))
			nil
		)
	)
)

; Pozitive integer control [0-9]
(defun isPositive(mylist)
	(setq val (car mylist))
	(if (equal val nil)
		t
		(if (and (<= (char-code #\0) (char-code val)) (<= (char-code val) (char-code #\9)))
			(isPositive (cdr mylist))
			nil
		)
	)
)

; Determines which type of tokens (KEYWORDS, OPERATORS, BINARYVALUE, IDENTIFIER, INTEGERVALUE)
(defun typeChecker(liste lexemes)
	(setq lexem (car lexemes))
	(if (equal lexem nil)
		liste
		(if (find lexem KEYWORDS :test #'string=)
			(progn
				(setq liste (append liste (list (list "KEYWORD" lexem))))
				(typeChecker liste (cdr lexemes)))
			(if (find lexem OPERATORS :test #'string=)
				(progn
					(setq liste (append liste (list (list "OPERATORS" lexem))))
					(typeChecker liste (cdr lexemes)))
				(if (find lexem COMMENT :test #'string=)
					(progn
						(setq liste (append liste (list (list "COMMENT" lexem))))
						(typeChecker liste (cdr lexemes)))
					(if (isIdentifier (concatenate 'list lexem))
						(progn
							(setq liste (append liste (list (list "IDENTIFIER" lexem))))
							(typeChecker liste (cdr lexemes)))
						(if (isInteger (concatenate 'list lexem))
							(progn
								(setq liste (append liste (list (list "INTEGER" lexem))))
								(typeChecker liste (cdr lexemes)))
							lexem
						)
					)
				)	
		    )
	    )
	)
)

;concatenate 2 tane stringi birlestiriyor
(defun gppinterpreter(filename)
	(setq stringL (readFile filename))
	(setq lexemes (seperateTokens (changeParenthesis "" (concatenate 'list stringL)))) 
	(setq resultList (typeChecker '() lexemes)) 

	(format t "Herhangi bir cikti uretilmiyor. Lutfen koda bakiniz. :( ~%Bir cok sey eksik. Errorlar ve bazi DFA kosullari eksiktir. ~%")
)


(defun main ()
	(gppinterpreter "helloworld.g++") 
)

(main)
