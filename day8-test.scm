(use-modules (aoc) (srfi srfi-64) (day8))
(test-begin "harness")

(test-equal "parse-coords parses coords"
            (list (make-coord 1 2 3) (make-coord 4 5 6))
            (parse-coords "1,2,3
4,5,6"))

(test-equal "distance between equal coords is 0"
            0
            (distance (make-coord 1 2 3) (make-coord 1 2 3)))

(test-equal "distance between different coords is Euclidean distance"
            9.27361849549570375251
            (distance (make-coord 1 2 3) (make-coord 10 4 4)))

(test-end "harness")
