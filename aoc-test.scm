(use-modules (srfi srfi-64) (aoc))
(test-begin "harness")

; test lines-in
(test-equal "lines-in splits on newline"
            '("1" "2" "3")
            (lines-in "1
2
3"))

(test-equal "lines-in discards trailing newlines"
            '("1" "2" "3")
            (lines-in "1
2
3

"))

(test-equal "lines-in handles a single line"
            '("1")
            (lines-in "1"))

(test-equal "lines-in handles empty input"
            '()
            (lines-in ""))

; test string->char-matrix
(define matrix (string->char-matrix "@#
1."))
(test-equal "string->char-matrix reads 2x2 matrix 0/0" #\@ (array-ref matrix 0 0))
(test-equal "string->char-matrix reads 2x2 matrix 1/0" #\# (array-ref matrix 1 0))
(test-equal "string->char-matrix reads 2x2 matrix 0/1" #\1 (array-ref matrix 0 1))
(test-equal "string->char-matrix reads 2x2 matrix 1/1" #\. (array-ref matrix 1 1))

; test char-matrix->string
(test-equal "char-matrix->string renders 3x2 matrix" "abc
def
" (char-matrix->string (string->char-matrix "abc
def
")))

; test char-matrix-find-any
(define char-matrix-find-any-test-matrix (string->char-matrix "@#-
1 ."))
(test-equal "char-matrix-find-any finds top left" '(0 . 0) (char-matrix-find-any char-matrix-find-any-test-matrix #\@))
(test-equal "char-matrix-find-any finds top right" '(2 . 0) (char-matrix-find-any char-matrix-find-any-test-matrix #\-))
(test-equal "char-matrix-find-any finds bottom left" '(0 . 1) (char-matrix-find-any char-matrix-find-any-test-matrix #\1))
(test-equal "char-matrix-find-any finds bottom right" '(2 . 1) (char-matrix-find-any char-matrix-find-any-test-matrix #\.))
(test-equal "char-matrix-find-any finds bottom right" #f (char-matrix-find-any char-matrix-find-any-test-matrix #\0))

; test split-on-ws
(test-equal "split-on-ws yields empty list on empty string" '() (split-on-ws ""))
(test-equal "split-on-ws yields string if it doesn't contain whitespace" '("a") (split-on-ws "a"))
(test-equal "split-on-ws splits on space" '("a" "b") (split-on-ws "a b"))
(test-equal "split-on-ws splits on tab" '("a" "b") (split-on-ws "a	b"))
(test-equal "split-on-ws ignores leading whitespace" '("a" "b") (split-on-ws " 	a b"))
(test-equal "split-on-ws ignores trailing whitespace" '("a" "b") (split-on-ws "a b 	"))
(test-equal "split-on-ws splits on long whitespace" '("a" "b") (split-on-ws "a  	  b"))

; test string->matrix
(define matrix (string->matrix (lambda (x y s)
                                 (cond
                                   ((and (zero? x) (zero? y)) (string->number s))
                                   ((string= "+" s) #\+)
                                   ((string-every (char-set #\0 #\9) s) (string->number s))
                                   (#t (symbol->keyword (string->symbol s)))))
                               "11 9
   +   abc "))
(test-equal "string->matrix parses field based on position" 11 (array-ref matrix 0 0))
(test-equal "string->matrix replaces field based on content" 9 (array-ref matrix 1 0))
(test-equal "string->matrix parses field based on content" #\+ (array-ref matrix 0 1))
(test-equal "string->matrix parses field based on content" #:abc (array-ref matrix 1 1))

; test sum
(test-equal "sum sums empty list to 0"
            0
            (sum '()))

(test-equal "sum sums list"
            9
            (sum '(1 3 5)))

; test product
(test-equal "product yields 1 for the empty list"
            1
            (product '()))

(test-equal "product yields the product of all list elements"
            105
            (product '(3 5 7)))

; test cartesian-product
(test-equal "cartesian-product works for 2x2"
            '((1 . 3) (1 . 4) (2 . 3) (2 . 4))
            (cartesian-product '(1 2) '(3 4)))

(test-equal "cartesian-half-product works for 3-element list"
            '((1 . 2) (1 . 3) (2 . 3))
            (cartesian-half-product '(1 2 3)))

; test dedup
(test-equal "dedup handles empty list"
            '()
            (dedup '()))

(test-equal "dedup handles list with unique elements"
            '(1 2 3)
            (dedup '(1 2 3)))

(test-equal "dedup removes adjecent duplicates"
            '(1 2 3)
            (dedup '(1 1 2 2 3 3)))

(test-equal "dedup keeps non-adjecent duplicates"
            '(3 1 2 3 2 1)
            (dedup '(3 1 2 3 2 1)))

(test-equal "dedup shrinks all-equal list to a single element"
            '(1)
            (dedup '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)))

(test-end "harness")
