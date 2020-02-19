; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Yakup Genc                       *
; *********************************************

;; utility functions 
(load "include.lisp") ;; "c2i and "i2c"


(defun read-as-list (filename)
	; Reads a file containing one word per line and returns a list of words (each word is in turn a list of characters)."

	; Implement this function...

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


;; -----------------------------------------------------
;; DECODE FUNCTIONS

(defun Gen-Decoder-A (paragraph)
	;you should implement this function
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
  (setq doc (read-as-list "document1.txt"))
  (print doc)
)


;; test code...
(test_on_test_data)