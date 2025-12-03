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

(test-equal "sum-invalid-ids finds no invalid ids in [12,21]"
            0
            (sum-invalid-ids '(12 . 21)))

(test-equal "sum-invalid-ids sums the invalid ids in [11,22]"
            33
            (sum-invalid-ids '(11 . 22)))

(test-equal "sum sums empty list to 0"
            0
            (sum '()))

(test-equal "sum sums list"
            9
            (sum '(1 3 5)))

(test-end "harness")
