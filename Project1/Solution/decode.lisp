; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Yakup Genc                       *
; *********************************************

;; utility functions 
(load "include.lisp") ;; "c2i and "i2c"


(defun splitString (l &key (separators '(#\Space)) (acc '()) (tmp '()))
  (cond ((null l) (nreverse (if tmp (cons (nreverse tmp) acc) acc)))
        ((member (car l) separators)
            (splitString (cdr l) :separators separators 
                           :acc (if tmp (cons (nreverse tmp) acc) acc)
                           :tmp '()
            )
        )
        (t 
         (splitString (cdr l) :separators separators
                        :acc acc
                        :tmp (cons (car l) tmp))
         )
        )
)

(defun readLines (filename)
  (with-open-file (stream filename)
    (loop :for line = (read-line stream nil nil)
          :while line
          :collect  line
            
    )
  )
)


(defun read-as-list (filename)
	; Reads a file containing one word per line and returns a list of words  
	;(each word is in turn a list of characters)."

	; Implement this function...
  (mapcan #'(lambda (str) (splitString (coerce str 'list))) 
            (readLines filename)
  )

)
;; -----------------------------------------------------
;; HELPERS
;; *** PLACE YOUR HELPER FUNCTIONS BELOW ***

(defun spell-checker-0 (word)
	;you should implement this function
)

(defun spell-checker-1 (word)
 	;you should implement this function
)

(defun finder (cipherAlph chr)
  (loop for i from 0 to 25 do
    (if (equal (aref cipherAlph i) chr) 
      (return-from finder i) () )
    )
    nil
)

(defun decodeW (word cipherAlph alpp)
  ;(format t "fgjn ~%")
  (if (null word) nil
    (let* ((index (finder cipherAlph (first word))))
      (if (null index) (append nil (decodeW (cdr word) cipherAlph alpp))
          (append (list (nth index alpp )) (decodeW (cdr word) cipherAlph alpp))
        ))
    
    )

  ;(format t "ff2 ~%")
)


(defun decoder (paragraph cipherAlph alpp)
  ;(format t "hhhhh ~%")
  (let ((tmpText nil))
    (loop for prg in paragraph do
      (let ((tmpPrg nil))
        (loop for word in prg do
          (setf tmpPrg (append tmpPrg (list(decodeW word cipherAlph alpp))))
          )
        (setf tmpText (append tmpText (list tmpPrg)))
      )
    )
    tmpText
  )
)

;; -----------------------------------------------------
;; DECODE FUNCTIONS

(defun Gen-Decoder-A (paragraph)
	;you should implement this function

  (format t "~% ~%")
  (defparameter array (make-array 26))
  (setf (aref array 0) 'd)
  (setf (aref array 1) 'e)
  (setf (aref array 2) 'f)
  (setf (aref array 3) 'p)
  (setf (aref array 4) 'q)
  (setf (aref array 5) 'a)
  (setf (aref array 6) 'b)
  (setf (aref array 7) 'k)
  (setf (aref array 8) 'l)
  (setf (aref array 9) 'c)
  (setf (aref array 10) 'r)
  (setf (aref array 11) 's)
  (setf (aref array 12) 't)
  (setf (aref array 13) 'g)
  (setf (aref array 14) 'y)
  (setf (aref array 15) 'z)
  (setf (aref array 16) 'h)
  (setf (aref array 17) 'i)
  (setf (aref array 18) 'j)
  (setf (aref array 19) 'm)
  (setf (aref array 20) 'n)
  (setf (aref array 21) 'o)
  (setf (aref array 22) 'u)
  (setf (aref array 23) 'v)
  (setf (aref array 24) 'w)
  (setf (aref array 25) 'x)

  (defparameter alpp (make-array 26))
  (setf (aref alpp 0) 'a)
  (setf (aref alpp 1) 'b)
  (setf (aref alpp 2) 'c)
  (setf (aref alpp 3) 'd)
  (setf (aref alpp 4) 'e)
  (setf (aref alpp 5) 'f)
  (setf (aref alpp 6) 'g)
  (setf (aref alpp 7) 'h)
  (setf (aref alpp 8) 'i)
  (setf (aref alpp 9) 'j)
  (setf (aref alpp 10) 'k)
  (setf (aref alpp 11) 'l)
  (setf (aref alpp 12) 'm)
  (setf (aref alpp 13) 'n)
  (setf (aref alpp 14) 'o)
  (setf (aref alpp 15) 'p)
  (setf (aref alpp 16) 'q)
  (setf (aref alpp 17) 'r)
  (setf (aref alpp 18) 's)
  (setf (aref alpp 19) 't)
  (setf (aref alpp 20) 'u)
  (setf (aref alpp 21) 'v)
  (setf (aref alpp 22) 'w)
  (setf (aref alpp 23) 'x)
  (setf (aref alpp 24) 'y)
  (setf (aref alpp 25) 'z)

  ;(setq cipherAlphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x)) 
  (format t "Cipher Alphabet ~a ~%" array)

  (format t "Alphabet ~a ~%" alpp)
    ;(setq lst '(#a) )

  (decoder paragraph array alpp)


)

(defun Gen-Decoder-B-0 (paragraph)
  	;you should implement this function
)

(defun Gen-Decoder-B-1 (paragraph)
  	;you should implement this function
)

(defun Code-Breaker (document decoder)
  	;you should implement this function
)


;; -----------------------------------------------------
;; Test code...

(defun test_on_test_data ()
	(print "....................................................")
	(print "Testing ....")
	(print "....................................................")
	(let ((doc (read-as-list "document1.txt")))
    (print doc))



    (let ((prg '(#\q #\s #\s #\y))) ;HELLO
      (write prg)
      (push #\k prg)
      (write prg)

      ;(Gen-Decoder-A prg)
    )

)

;; test code...
(test_on_test_data)