(use-modules (srfi srfi-64) (day1))
(test-begin "harness")

(test-equal "example day 1, part 1"
            3
            (solve1 "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"))

(test-end "harness")
