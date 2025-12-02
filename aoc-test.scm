(use-modules (srfi srfi-64) (aoc))
(test-begin "harness")

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

(test-end "harness")
