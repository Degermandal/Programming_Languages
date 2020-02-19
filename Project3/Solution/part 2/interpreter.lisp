(setq flag 0) ;agacin 
(setq tree nil) ;parse tree

;asil fonksiyonum baslangic degerleri atiyorum
(defun parser(lexerOutput)
	(setq tokens lexerOutput)
	(setq tree nil)
	(add "START" 0)
	(add "INPUT" 1)
	(parserHelper 1)
)
;nonterminal'ler icin parse tree'ye add fonksiyonu
(defun add (node level) 
	(push (concatenate 'string (addHelper "" level) (string node)) tree)
)
;bu fonsiyonu parseTree'yi bosluklu, biraz agaca benzer sekilde yazabilmek icin kullandim
(defun addHelper (str level)
    (cond 
	     ((= level 0) str)
	     (t 
 			(setq temp (concatenate 'string str (string "     ")))
  			(addHelper (concatenate 'string str (string "     ")) (- level 1))
  		 )
    )
)
;START -> INPUT
;INPUT -> EXPI | EXPLISTI
; bu fonksiyon parser fonksiyonun devami ayrica baslangic olarak da dusunulebilir.
;;ilk olarak null durumunu kontrol ediyor. Daha sonra ise explisti yada expi olma durumunu
(defun parserHelper (level) 
	;(format t "hello\n")
	(cond 
		((null  tokens)
			(printTree (reverse tree))
		)
		((not (equal nil (check '("'" "null") (firstLex))))
			(EXPLISTI (+ 1 level))
			(parserHelper level)
		)
		((not (equal nil (check '("append" "concat") (secondLex))))
			(EXPLISTI (+ 1 level))
			(parserHelper level)
		)
		(t (EXPI (+ 1 level))
			(parserHelper level)
		)
	)
)
;parse tree'yi bastirmka icin
(defun printTree(tree)
	(cond 
		((not (null  tree))
		(format t (car tree))
		(terpri)
		(printTree (cdr tree)))
	)
)
;sadece verilen kelimeye gore kontrol yapiyor
(defun check(node k)
	(cond ((null node) nil)
		((equal (car node) k) t)
		(t (check (cdr node) k))
    )
)
;asagidaki 4 fonksiyon verilen lexer outputundaki verileri duzgun sekilde alabilmek icindir. lexer outputunda 2 dger vardir token ve degerleri
(defun firstLex()
   (string-downcase (car (cdr (car tokens))))
)
(defun secondLex()
  (string-downcase (car (cdr (car (cdr tokens)))))
)
(defun firstToken()
  (string-upcase (car (car tokens)))
)
(defun secondToken()
  (string-upcase (car (car (cdr tokens))))
)

;;;;;........................................................

;OP_PLUS, OP_MINUS, OP_DIV, OP_MULT, OP_OP, OP_CP, OP_DBLMULT, OP_OC, OP_CC, OP_COMMA

;KW_AND, KW_OR, KW_ NOT, KW_EQUAL, KW_LESS, KW_NIL, KW_LIST,/*KW_APPEND, KW_CONCAT,*/ 
;KW_SET, KW_DEFFUN, KW_FOR, KW_IF,KW_EXIT, KW_LOAD, KW_DISP, KW_TRUE, KW_FALSE


;;Bize verilen CFG'ye uygun olarak lexer outputunu kullanmaya calistim. verilen CFG:
;EXPLISTI -> (concat EXPLISTI EXPLISTI) | (append EXPI EXPLISTI) | LISTVALUE | null
(defun EXPLISTI(level)
	(add "EXPLISTI" level)
	(cond 
		((string= "(" (firstLex))
			(cond 
				((or    (string= "OP_PLUS" (secondToken)) (string= "OP_MINUS" (secondToken)) (string= "OP_DIV" (secondToken)) 
						(string= "OP_MULT" (secondToken))  (string= "OP_OP" (secondToken)) (string= "OP_CP" (secondToken))
						(string= "OP_DBLMULT" (secondToken)) (string= "OP_OC" (secondToken)) (string= "OP_CC" (secondToken)) 
						(string= "OP_COMMA" (secondToken))
					)
					(EXPI (+ 1 level))			
				)
				((string= "KW_CONCAT" (secondLex))  
					(KwConcat (+ 1 level))
				)
				((string= "KW_APPEND" (secondLex))  
					(KwAppend (+ 1 level))
				)
				((or    (string= "KW_AND" (secondToken)) (string= "KW_OR" (secondToken)) (string= "KW_NOT" (secondToken)) 
						(string= "KW_EQUAL" (secondToken))  (string= "KW_LESS" (secondToken)) (string= "KW_NIL" (secondToken))
						(string= "KW_LIST" (secondToken)) (string= "KW_SET" (secondToken)) (string= "KW_DEFFUN" (secondToken)) 
						(string= "KW_FOR" (secondToken)) (string= "KW_IF" (secondToken)) (string= "KW_EXIT" (secondToken))
						(string= "KW_LOAD" (secondToken)) (string= "KW_DISP" (secondToken)) (string= "KW_TRUE" (secondToken))
						(string= "KW_FALSE" (secondToken))
					)
					(EXPI (+ 1 level))			
				)
				((string= "IDENTIFIER" (secondToken))
					(EXPI (+ 1 level))
				)
			)
		)
		((string= "IDENTIFIER" (firstToken))
			(EXPI (+ 1 level))
		)
		((string= "VALUE" (firstToken))
			(EXPI (+ 1 level))
		)
		((string= "null" (firstLex))
			(add "null" (+ 1 level))
			(setq tokens (cdr tokens))
		)
		((string= "'" (firstLex))
			(add "'" (+ 1 level))
			(setq tokens (cdr tokens))
			(OPOP (+ 1 level))
			(cond
				((not (string= ")" (firstLex)))
					 (VALUE level)
				)
			)
			(OPCP  (+ 1 level))
		)
	)
)
;EXPI -> (+ EXPI EXPI) | (- EXPI EXPI) | (* EXPI EXPI) | (/ EXPI EXPI) | Id | IntegerValue | (Id EXPLISTI)
;bize verilen grammer buydu ama integer value yerine direk value kullandim.
(defun EXPI(level)
	(add "EXPI" level)
	(cond 
		((null tokens) nil)
		((string= "IDENTIFIER" (firstToken)) 
			(ID (+ 1 level))
		)
		((string= "VALUE" (firstToken) ) 
			(VALUE level)
		)
		((string= "IDENTIFIER" (secondToken)) ;(ID EXPLISTI) 
			(OPOP (+ 1 level))
			(ID (+ 1 level))
			(EXPLISTI (+ 1 level))
			(OPCP (+ 1 level))
		)
		((or    (string= "KW_AND" (secondToken)) (string= "KW_OR" (secondToken)) (string= "KW_NOT" (secondToken)) 
				(string= "KW_EQUAL" (secondToken))  (string= "KW_LESS" (secondToken)) (string= "KW_NIL" (secondToken))
				(string= "KW_LIST" (secondToken)) (string= "KW_APPEND" (secondToken)) (string= "KW_CONCAT" (secondToken)) 
			    (string= "KW_SET" (secondToken)) (string= "KW_DEFFUN" (secondToken)) 
				(string= "KW_FOR" (secondToken)) (string= "KW_IF" (secondToken)) (string= "KW_EXIT" (secondToken))
				(string= "KW_LOAD" (secondToken)) (string= "KW_DISP" (secondToken)) (string= "KW_TRUE" (secondToken))
				(string= "KW_FALSE" (secondToken))
			)
			(keywordCheck level)			
		)

		((or    (string= (secondToken) "OP_PLUS") (string= (secondToken) "OP_MINUS" ) (string= (secondToken) "OP_DIV" ) 
				(string= (secondToken) "OP_MULT" )  (string= (secondToken) "OP_OP" ) (string= (secondToken) "OP_CP" )
				(string= (secondToken) "OP_DBLMULT" ) (string= (secondToken) "OP_OC" ) (string= (secondToken) "OP_CC" ) 
				(string= (secondToken) "OP_COMMA" )
			)
			(opCheck (+ 1 level))			
		)
	)
)

;;;.............................................................

;operator check etmek icin
(defun opCheck (level)
 	(or (string= "+" (secondLex)) (string= "-" (secondLex)) (string= "/" (secondLex)) 
 		(string= "*" (secondLex)) (string= "**" (secondLex)) (string= "," (secondLex))
 	) 
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(EXPI level)
	(EXPI level)
	(OPCP level)
)
;hangi keyword olduguna dair check yapabilmek icin
(defun keywordCheck(level)
  (cond
  	((string= (secondLex) "and")
	(KwAnd (+ 1 level))) 

	((string= (secondLex) "or")
	(KwOr (+ 1 level)))

	((string= (secondLex) "not")
	(KwNot (+ 1 level)))

	((string= (secondLex) "equal")
	(KwEqual (+ 1 level)))

	((string= (secondLex) "less")
	(KwLess (+ 1 level)))

	((string= (secondLex) "nil")
	(KwNil (+ 1 level)))

	((string= (secondLex) "list")
	(KwList (+ 1 level)))

	((string= (secondLex) "set")
	(KwSet (+ 1 level)))

	((string= (secondLex) "deffun")
	(KwDeffun (+ 1 level)))

	((string= (secondLex) "for")
	(KwFor (+ 1 level)))

	((string= (secondLex) "if")
	(KwIf (+ 1 level)))

	((string= (secondLex) "exit")
	(KwExit (+ 1 level)))

	((string= (secondLex) "load")
	(KwLoad (+ 1 level)))

	((string= (secondLex) "disp")
	(KwDisp (+ 1 level)))

	((string= (secondLex) "true")
	(KwTrue (+ 1 level)))

	((string= (secondLex) "false")
	(KwFalse (+ 1 level)))

	)
)
;EXPB -> (and EXPB EXPB) | (or EXPB EXPB) | (not EXPB) | (equal EXPB EXPB) | (equal EXPI EXPI) | BinaryValue
;binaryValue olmadigi icin binary value kontrolu yapmadim. true ve false ifadeleri keyword olarak tanimlanmistir
(defun EXPB(level)
	(add "EXPB" level)
	(or (string= "KW_AND" (secondToken)) (string= "KW_OR" (secondToken)) (string= "KW_NOT" (secondToken)) 
		(string= "KW_EQUAL" (secondToken))  (string= "KW_LESS" (secondToken)) (string= "KW_NIL" (secondToken))
		(string= "KW_LIST" (secondToken)) (string= "KW_APPEND" (secondToken)) (string= "KW_CONCAT" (secondToken)) 
	    (string= "KW_SET" (secondToken)) (string= "KW_DEFFUN" (secondToken)) 
		(string= "KW_FOR" (secondToken)) (string= "KW_IF" (secondToken)) (string= "KW_EXIT" (secondToken))
		(string= "KW_LOAD" (secondToken)) (string= "KW_DISP" (secondToken)) (string= "KW_TRUE" (secondToken))
		(string= "KW_FALSE" (secondToken))
	)
	(keywordCheck level)			
)
;EXPI -> (deffun Id IDLIST EXPLISTI)
(defun IDLIST (level)
	(add "IDLIST" level)
	(cond 
		((string= (firstLex) "(")
			(OPOP (+ 1 level))
			(IDLIST  (+ 1 level))
			(OPCP (+ 1 level))
		)
		((string= "IDENTIFIER" (firstToken))
			(ID (+ 1 level))
			(cond	
				((string= "IDENTIFIER" (firstToken))
				(IDLIST (+ 1 level)))
			)
		)
	)
)

(defun ID (level)
	(add "ID" level)
	(add (firstLex) (+ level 1))
	(setq tokens (cdr tokens))
)

(defun VALUE(level)
	(add "VALUE" (+ 1 level))
	(add (firstLex) (+ 2 level))
	(setq tokens (cdr tokens))
	(cond 
		((string= (firstToken) "VALUE")
			(VALUE (+ 1 level))
		)
	)
)
;;;;.........................................................................
;;;;Asagidaki fonksiyonlar keywordlerin islevlerine gore yazilmis fonksiyonlardir
(defun OPOP(level) ;;;buna bak
    (string= (car (cdr (car tokens))) "(")
    (add "OP_OP" level)
    (setq tokens (cdr tokens))
)

(defun OPCP(level)
	(string= (car (cdr (car tokens))) ")")
    (add "OP_CP" level)
    (setq tokens (cdr tokens))
)

(defun KwAnd(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(EXPB level)
	(EXPB level)
	(OPCP level)
)
(defun KwOr(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens)) ;remove
	(EXPB level)
	(EXPB level)
	(OPCP level)
)
(defun KwNot(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(EXPB level)
	(OPCP level)
)
(defun KwEqual(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(cond
		((not (equal nil (check '("KW_AND" "KW_OR" "KW_NOT" "KW_EQUAL") (firstLex))))
            	 	 (EXPB level) 
			 		 (EXPB level))
		(t	(EXPI  level)
			(EXPI  level))
	)
	(OPCP level)
)
(defun KwLess(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwNil(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwList(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwAppend(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(EXPI level)
	(EXPLISTI level)
	(OPCP level)
)
(defun KwConcat(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(EXPLISTI level)
	(EXPLISTI level)
	(OPCP level)
)
 
(defun KwSet(level)
	(OPOP level)
	(add "set" level)
	(setq tokens (cdr tokens))
	(ID level)
	(EXPI level)
	(OPCP level)
)
(defun KwDeffun (level)
	(OPOP level)
	(add "deffun" level)
	(setq tokens (cdr tokens))
	(ID level)
	(IDLIST level)
	(EXPLISTI level)
	(OPCP level)
)
(defun KwFor(level)
	(OPOP level)
	(add "for" level)
	(setq tokens (cdr tokens))
	(OPOP level)
	(ID level)
	(EXPI level)
	(EXPI level)
	(OPCP level)
	(EXPLISTI level)
	(OPCP level)
)
(defun KwIf(level)
	(OPOP level)
	(add "if" level)
	(setq tokens (cdr tokens))
	(EXPB level)
	(EXPLISTI  level)
	(cond
	((string= (firstLex) ")")
		(OPCP level))
	(t
		(EXPLISTI level)
		(OPCP level))
	)
)
(defun KwExit(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwLoad(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwDisp(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwTrue(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)
(defun KwFalse(level)
	(OPOP level)
	(add (firstLex) level)
	(setq tokens (cdr tokens))
	(OPCP level)
)

;;;;........................................................
;;;testing

;(deffun sumup (x)
;(if (equal x 0)
;1
;(+ x (sumup (- x 1)))
;)
;)

;;lexer ciktisini kendim verdim. Cikti duzeni:
;("OP_OP" "(") parantezler icinde ilk once keyword ismi daha sonra ise lex olacak sekilde kendimce bir input verdim.
(defun main ()

	(setq lexerOutput '(
	("OP_OP" "(") ("KW_DEFFUN" "deffun") ("IDENTIFIER" "sumup") ("OP_OP" "(") ("IDENTIFIER" "x")
	("OP_CP" ")") ("OP_OP" "(") ("KW_IF" "if") ("OP_OP" "(") ("KW_EQUAL" "equal")("IDENTIFIER" "x")
	("VALUE" "0") ("OP_CP" ")") ("VALUE" "1") ("OP_OP" "(") ("OP_PLUS" "+") ("IDENTIFIER" "x")
	("OP_OP" "(") ("IDENTIFIER" "sumup") ("OP_OP" "(") ("OP_MINUS" "-") ("IDENTIFIER" "x") ("VALUE" "1")
	("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")"))
	)
	
	(parser lexerOutput)
)


(main)




























