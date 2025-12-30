(use-modules (aoc) (srfi srfi-64) (day10))
(test-begin "harness")

(test-equal "parse-indicators parses indicators"
            #(#\. #\# #\. #\. #\#)
            (parse-indicators "[.#..#]"))

(test-equal "parse-button parses a single-indicator button"
            '(3)
            (parse-button "(3)"))

(test-equal "parse-button parses a multi-indicator button"
            '(0 3 17)
            (parse-button "(0,3,17)"))

(test-equal "parse-joltage-requirements parses joltages"
            #(0 3 17)
            (parse-joltage-requirements "{0,3,17}"))

(test-equal "parse-machine-spec parses machine spec"
            (make-machine-spec #(#\. #\# #\. #\. #\#) '((3) (1 3)) #(3 5 7 11 192))
            (parse-machine-spec "[.#..#] (3) (1,3) {3,5,7,11,192}"))

(test-equal "press-button toggles the appropriate indicators"
            #(#\. #\. #\# #\# #\.)
            (press-button (vector #\. #\# #\# #\. #\.) '(1 3)))

(test-end "harness")
