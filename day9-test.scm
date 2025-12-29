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

(define test-coord-mapping (generate-coord-mapping (list (make-coord 5 10) (make-coord 10 20) (make-coord 15 30))))

(test-equal "coord-mapping maps coord outside range (lower bounds)"
            (make-coord -1 -1)
            (mapped test-coord-mapping (make-coord 1 2)))

(test-equal "coord-mapping maps coord on lower bounds"
            (make-coord 0 0)
            (mapped test-coord-mapping (make-coord 5 10)))

(test-equal "coord-mapping maps coord inside lower bounds"
            (make-coord 1 1)
            (mapped test-coord-mapping (make-coord 6 11)))

(test-equal "coord-mapping maps coord on inner bounds"
            (make-coord 3 3)
            (mapped test-coord-mapping (make-coord 10 20)))

(test-equal "coord-mapping maps coord just inside upper bounds"
            (make-coord 5 5)
            (mapped test-coord-mapping (make-coord 14 29)))

(test-equal "coord-mapping maps coord on upper bounds"
            (make-coord 6 6)
            (mapped test-coord-mapping (make-coord 15 30)))

(test-equal "coord-mapping maps coord right outside upper bounds"
            (make-coord 7 7)
            (mapped test-coord-mapping (make-coord 16 31)))

(test-equal "coord-mapping unmaps coord outside range (lower bounds)"
            (make-coord 0 0)
            (unmapped test-coord-mapping (make-coord -1 -1)))

(test-equal "coord-mapping unmaps coord outside range (upper bounds)"
            (make-coord 999999999 999999999)
            (unmapped test-coord-mapping (make-coord 8 8)))

(test-equal "coord-mapping unmaps coord on upper bound"
            (make-coord 15 30)
            (unmapped test-coord-mapping (make-coord 6 6)))

(test-equal "coord-mapping unmaps coord in range"
            (make-coord 6 21)
            (unmapped test-coord-mapping (make-coord 1 4)))

(test-end "harness")
