(use-modules (aoc) (srfi srfi-64) (day9))
(test-begin "harness")

(test-equal "parse-coords parses coords"
            (list (make-coord 1 2) (make-coord 3 4))
            (parse-coords "1,2
3,4"))

(test-equal "area of single point is 1"
            1
            (area (cons (make-coord 1 1) (make-coord 1 1))))

(test-equal "area is correct for coord 2 > coord 1"
            15
            (area (cons (make-coord 1 2) (make-coord 3 6))))

(test-equal "area is correct for coord 2 < coord 1"
            15
            (area (cons (make-coord 3 6) (make-coord 1 2))))

(test-equal "area is correct for mixed coords"
            15
            (area (cons (make-coord 1 6) (make-coord 3 2))))

(test-end "harness")
