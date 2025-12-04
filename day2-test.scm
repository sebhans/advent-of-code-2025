(use-modules (srfi srfi-64) (day2))
(test-begin "harness")

(test-equal "list->pairs turns empty list into empty list"
            '()
            (list->pairs '()))

(test-equal "list->pairs turns a two-element list into a list of one pair"
            '((1 . 2))
            (list->pairs '(1 2)))

(test-equal "list->pairs works for a longer list"
            '((1 . 2) (3 . 4) (5 . 6) (7 . 8))
            (list->pairs '(1 2 3 4 5 6 7 8)))

(test-equal "string->ranges converts well-formed string"
            '((3 . 4) (5 . 6))
            (string->ranges "3-4,5-6"))

(test-equal "range-iterator on empty range returns initial value"
            13
            ((range-iterator '(1 . 0)) + 13))

(test-equal "range-iterator on single-element range works"
            1
            ((range-iterator '(1 . 1)) + 0))

(test-equal "range-iterator accumulates"
            21
            ((range-iterator '(1 . 6)) + 0))

(test-equal "halve-string halves the empty string"
            ""
            (halve-string ""))

(test-equal "halve-string halves a string with an even number of characters"
            "a"
            (halve-string "ab"))

(test-equal "halve-string halves a string with an odd number of characters"
            "a"
            (halve-string "abc"))

(test-equal "invalid-id? recognizes a valid ID"
            #f
            (invalid-id? "12"))

(test-equal "invalid-id? recognizes an invalid ID"
            #t
            (invalid-id? "11"))

(test-equal "sum-if yields 0 if predicate never matches"
            0
            (sum-if (lambda (n) #f) '(1 . 2)))

(test-equal "sum-if sums matching numbers"
            3
            (sum-if (lambda (n) #t) '(1 . 2)))

(test-equal "repeat-string yields the empty string if repeated 0 times"
            ""
            (repeat-string "a" 0))

(test-equal "repeat-string yields the string if repeated once"
            "a"
            (repeat-string "a" 1))

(test-equal "repeat-string yields the string repeated n times"
            "aaaaa"
            (repeat-string "a" 5))

(test-equal "repeated-string? yields #f if string is not a repeated string"
            #f
            (repeated-string? "abcdefg" 2))

(test-equal "repeated-string? yields #t if string is sequence repeated twice"
            #t
            (repeated-string? "abcabc" 2))

(test-equal "repeated-string? recognizes a single repeat character"
            #t
            (repeated-string? "aaaaaaa" 7))

(test-equal "repeated-string? without repeat count recognizes a single repeat character"
            #t
            (repeated-string? "aaaaaaa"))

(test-equal "repeated-string? without repeat count recognizes double-string"
            #t
            (repeated-string? "abab"))

(test-equal "repeated-string? without repeat count recognizes 5 time repetition of a longer segment"
            #t
            (repeated-string? "YodelihoYodelihoYodelihoYodelihoYodeliho"))

(test-end "harness")
