Lexer Output'unu bu sekilde kendim tanimlayip fonksiyona verdim:
(setq lexerOutput '(
	("OP_OP" "(") ("KW_DEFFUN" "deffun") ("IDENTIFIER" "sumup") ("OP_OP" "(") ("IDENTIFIER" "x")
	("OP_CP" ")") ("OP_OP" "(") ("KW_IF" "if") ("OP_OP" "(") ("KW_EQUAL" "equal")("IDENTIFIER" "x")
	("VALUE" "0") ("OP_CP" ")") ("VALUE" "1") ("OP_OP" "(") ("OP_PLUS" "+") ("IDENTIFIER" "x")
	("OP_OP" "(") ("IDENTIFIER" "sumup") ("OP_OP" "(") ("OP_MINUS" "-") ("IDENTIFIER" "x") ("VALUE" "1")
	("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")") ("OP_CP" ")"))
	)

Ismi ve kendisi seklinde parantezler icinde yazdim. Bize verilen odev dosyasinda bazi farkliliklar gordum. Ornegin grammerde binaryValue, IntegerValue gibi degerler verilmistir ama terminal olarak verilen listede bunlar yoktur. true ve false keyword olarak tanimlanmistir. IntegerValue yoktur sadece value olarak tanimlanmistir. bu yuzden IntgerValue, Values, BinaryValue gibi grammerleri kullanmadim.
Eksikler:
Syntax kontrollerim yoktur.


****Fonksiyonlara kisim kisim yorumlar yazilmistir.


Ornek Output:

(deffun sumup (x)
	(if (equal x 0)
		1
		(+ x (sumup (- x 1)))
	)
)

[7]> (load "interpreter.lisp")
;; Loading file interpreter.lisp ...
START
     INPUT
          EXPI
               OP_OP
               deffun
               ID
                    sumup
               IDLIST
                    OP_OP
                    IDLIST
                         ID
                              x
                    OP_CP
               EXPLISTI
                    EXPI
                         OP_OP
                         if
                         EXPB
                              OP_OP
                              equal
                              EXPI
                                   ID
                                        x
                              EXPI
                                   VALUE
                                        0
                              OP_CP
                         EXPLISTI
                              EXPI
                                   VALUE
                                        1
                         EXPLISTI
                              EXPI
                                   OP_OP
                                   +
                                   EXPI
                                        ID
                                             x
                                   EXPI
                                        OP_OP
                                        ID
                                             sumup
                                        EXPLISTI
                                             EXPI
                                                  OP_OP
                                                  -
                                                  EXPI
                                                       ID
                                                            x
                                                  EXPI
                                                       VALUE
                                                            1
                                                  OP_CP
                                        OP_CP
                                   OP_CP
                         OP_CP
               OP_CP
;; Loaded file interpreter.lisp
T
[8]> 
