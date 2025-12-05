(use-modules (srfi srfi-64) (day5))
(test-begin "harness")

(test-equal "is-range? recognizes range"
            #t
            (is-range? "3-5"))

(test-equal "is-range? recognizes no range"
            #f
            (is-range? "11"))

(test-equal "parse-range parses range"
            '(3 . 5)
            (parse-range "3-5"))

(test-equal "parse-db parses correctly"
            '(((12 . 18) (16 . 20) (10 . 14) (3 . 5)) . (32 17 11 8 5 1))
            (parse-db "3-5
10-14
16-20
12-18

1
5
8
11
17
32"))

(test-equal "sort-db sorts the db"
            '(((3 . 5) (10 . 14) (12 . 21) (16 . 20)) . (1 5 8 11 17 32))
            (sort-db '(((12 . 21) (16 . 20) (10 . 14) (3 . 5)) . (32 8 11 17 5 1))))

(test-equal "check-against yields fresh if ingedient is at the beginning of the range"
            #:fresh
            (check-against '(3 . 5) 3))

(test-equal "check-against yields fresh if ingedient is in the range"
            #:fresh
            (check-against '(3 . 5) 4))

(test-equal "check-against yields fresh if ingedient is at the end of the range"
            #:fresh
            (check-against '(3 . 5) 5))

(test-equal "check-against yields too-small if ingedient falls before the range"
            #:too-small
            (check-against '(3 . 5) 2))

(test-equal "check-against yields too-large if ingedient falls after the range"
            #:too-large
            (check-against '(3 . 5) 6))

(test-end "harness")
