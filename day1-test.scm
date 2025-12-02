(use-modules (srfi srfi-64) (day1))
(test-begin "harness")

(test-equal "parse-rotation parses left rotation"
            -1
            (parse-rotation "L1"))

(test-equal "parse-rotation parses right rotation"
            1
            (parse-rotation "R1"))

(test-equal "parse-rotation handles 0 left"
            0
            (parse-rotation "L0"))

(test-equal "parse-rotation handles 0 right"
            0
            (parse-rotation "R0"))

(test-equal "apply-rotation rotates by 0"
            '(50 . 0)
            (apply-rotation 0 '(50 . 0)))

(test-equal "apply-rotation rotates right"
            '(62 . 0)
            (apply-rotation 12 '(50 . 0)))

(test-equal "apply-rotation rotates right past 0"
            '(1 . 0)
            (apply-rotation 51 '(50 . 0)))

(test-equal "apply-rotation rotates right from 0"
            '(1 . 0)
            (apply-rotation 1 '(0 . 0)))

(test-equal "apply-rotation rotates left past 0"
            '(99 . 0)
            (apply-rotation -51 '(50 . 0)))

(test-equal "apply-rotation rotates left from 0"
            '(99 . 0)
            (apply-rotation -1 '(0 . 0)))

(test-equal "apply-rotation counts zeroes when rotating right"
            '(0 . 1)
            (apply-rotation 50 '(50 . 0)))

(test-equal "apply-rotation counts zeroes when rotating left"
            '(0 . 1)
            (apply-rotation -50 '(50 . 0)))

(test-end "harness")
