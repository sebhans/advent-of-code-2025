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

; test sum
(test-equal "sum sums empty list to 0"
            0
            (sum '()))

(test-equal "sum sums list"
            9
            (sum '(1 3 5)))

(test-end "harness")
