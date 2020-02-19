; *********************************************
; *  341 Programming Languages                *
; *  Fall 2018                                *
; *  Author: Yakup Genc                       *
; *********************************************


(defun c2i (x)
	; Convert character to int.
	(cond
      ((equal x 'a) 0)
      ((equal x 'b) 1)
      ((equal x 'c) 2)
      ((equal x 'd) 3)
      ((equal x 'e) 4)
      ((equal x 'f) 5)
      ((equal x 'g) 6)
      ((equal x 'h) 7)
      ((equal x 'i) 8)
      ((equal x 'j) 9)
      ((equal x 'k) 10)
      ((equal x 'l) 11)
      ((equal x 'm) 12)
      ((equal x 'n) 13)
      ((equal x 'o) 14)
      ((equal x 'p) 15)
      ((equal x 'q) 16)
      ((equal x 'r) 17)
      ((equal x 's) 18)
      ((equal x 't) 19)
      ((equal x 'u) 20)
      ((equal x 'v) 21)
      ((equal x 'w) 22)
      ((equal x 'x) 23)
      ((equal x 'y) 24)
      ((equal x 'z) 25))

	(- (char-int x) (char-int #\a))
)


(defun i2c (x)
	; Convert int to character.
	(cond
      ((equal x 0) 'a)
      ((equal x 1) 'b)
      ((equal x 2) 'c)
      ((equal x 3) 'd)
      ((equal x 4) 'e)
      ((equal x 5) 'f)
      ((equal x 6) 'g)
      ((equal x 7) 'h)
      ((equal x 8) 'i)
      ((equal x 9) 'j)
      ((equal x 10) 'k)
      ((equal x 11) 'l)
      ((equal x 12) 'm)
      ((equal x 13) 'n)
      ((equal x 14) 'o)
      ((equal x 15) 'p)
      ((equal x 16) 'q)
      ((equal x 17) 'r)
      ((equal x 18) 's)
      ((equal x 19) 't)
      ((equal x 20) 'u)
      ((equal x 21) 'v)
      ((equal x 22) 'w)
      ((equal x 23) 'x)
      ((equal x 24) 'y)
      ((equal x 25) 'z))
	(int-char (+ x (char-int #\a)))
)

