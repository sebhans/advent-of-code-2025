(use-modules (srfi srfi-64) (day3))
(test-begin "harness")

(test-equal "find-leftmost-joltage finds joltage at 0"
            0
            (find-leftmost-joltage "9234273427934249" 9 0))

(test-equal "find-leftmost-joltage finds joltage at end"
            15
            (find-leftmost-joltage "1234273427534249" 9 0))

(test-equal "find-leftmost-joltage starts search at start"
            2
            (find-leftmost-joltage "99999" 9 2))

(test-equal "find-best-joltage finds the leftmost highest joltage"
            '(5 . 3)
            (find-best-joltage "1325455" 0 7))

(test-equal "find-best-joltage starts search at start"
            '(5 . 5)
            (find-best-joltage "1325455" 4 7))

(test-equal "find-best-joltage stops search before end"
            '(5 . 3)
            (find-best-joltage "1325456" 0 6))

(test-end "harness")
