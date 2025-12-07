(use-modules (aoc) (srfi srfi-64) (day7))
(test-begin "harness")

(define move-beam-test-diagram (string->char-matrix "...S...
.......
...^...
..^.^..
.^...^."))
(test-equal "move-beam moves beam one down"
            '((3) 1 0)
            (move-beam move-beam-test-diagram (list '(3) 0 0)))
(test-equal "move-beam splits one beam"
            '((4 2) 2 1)
            (move-beam move-beam-test-diagram (list '(3) 1 0)))
(test-equal "move-beam splits two beams next to each other into 3"
            '((5 3 1) 3 2)
            (move-beam move-beam-test-diagram (list '(2 4) 2 0)))
(test-equal "move-beam splits two beams not next to each other into 4"
            '((6 4 2 0) 4 2)
            (move-beam move-beam-test-diagram (list '(1 5) 3 0)))

(test-end "harness")
