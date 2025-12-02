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

(test-equal "zero-hits recognizes direct hit after rotating left"
            1
            (zero-hits 50 -50))

(test-equal "zero-hits recognizes direct hit after rotating right"
            1
            (zero-hits 50 50))

(test-equal "zero-hits recognizes no hit"
            0
            (zero-hits 50 10))

(test-equal "zero-hits recognizes no hit when rotating right from 0"
            0
            (zero-hits 0 10))

(test-equal "zero-hits recognizes no hit when rotating left from 0"
            0
            (zero-hits 0 -10))

(test-equal "zero-hits recognizes a full rotation right from 0"
            1
            (zero-hits 0 100))

(test-equal "zero-hits recognizes a full rotation left from 0"
            1
            (zero-hits 0 -100))

(test-equal "zero-hits recognizes crossing to the left"
            1
            (zero-hits 50 -60))

(test-equal "zero-hits recognizes crossing to the right"
            1
            (zero-hits 50 60))

(test-equal "zero-hits recognizes multiple crossings to the left"
            3
            (zero-hits 50 -260))

(test-equal "zero-hits recognizes multiple crossings to the right"
            3
            (zero-hits 50 260))

(test-equal "zero-hits recognizes multiple crossings to the left, landing on 0"
            3
            (zero-hits 50 -250))

(test-equal "zero-hits recognizes multiple crossings to the right, landing on 0"
            3
            (zero-hits 50 250))

(test-equal "zero-hits recognizes 4 crossings to the right"
            4
            (zero-hits 4 401))

(test-equal "zero-hits recognizes 4 crossings to the left"
            4
            (zero-hits 4 -401))

(test-equal "apply-rotation-count-all-zeroes rotates by 0"
            '(50 . 0)
            (apply-rotation-count-all-zeroes 0 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes rotates right"
            '(62 . 0)
            (apply-rotation-count-all-zeroes 12 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes rotates right past 0 and counts the 0"
            '(1 . 1)
            (apply-rotation-count-all-zeroes 51 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes rotates right from 0"
            '(1 . 0)
            (apply-rotation-count-all-zeroes 1 '(0 . 0)))

(test-equal "apply-rotation-count-all-zeroes rotates left past 0 and counts the 0"
            '(99 . 1)
            (apply-rotation-count-all-zeroes -51 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes rotates left from 0"
            '(99 . 0)
            (apply-rotation-count-all-zeroes -1 '(0 . 0)))

(test-equal "apply-rotation-count-all-zeroes counts direct zeroes when rotating right"
            '(0 . 1)
            (apply-rotation-count-all-zeroes 50 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes counts direct zeroes when rotating left"
            '(0 . 1)
            (apply-rotation-count-all-zeroes -50 '(50 . 0)))

(test-equal "apply-rotation-count-all-zeroes counts multiple zeroes during right rotation"
            '(5 . 4)
            (apply-rotation-count-all-zeroes 401 '(4 . 0)))

(test-equal "apply-rotation-count-all-zeroes counts multiple zeroes during left rotation"
            '(3 . 4)
            (apply-rotation-count-all-zeroes -401 '(4 . 0)))

(test-end "harness")
