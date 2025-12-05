(define-module (day4))
(use-modules (aoc) (srfi srfi-1))

(define-public (paper-roll-at? diagram x y)
               (and (array-in-bounds? diagram x y)
                    (eq? #\@ (array-ref diagram x y))))

(define-public (is-accessible? diagram x y)
               (< (sum (map (lambda (nx)
                           (sum (map (lambda (ny)
                                       (if (paper-roll-at? diagram nx ny) 1 0))
                                     (iota 3 (- y 1)))))
                         (iota 3 (- x 1))))
                  5))

(define-public count-accessible-rolls
               (case-lambda
                 ((diagram) (let ((dim (array-dimensions diagram)))
                              (count-accessible-rolls diagram (car dim) (cadr dim) 0 0 0)))
                 ((diagram width height x y count) (if (>= y height)
                                                     count
                                                     (if (>= x width)
                                                       (count-accessible-rolls diagram width height 0 (1+ y) count)
                                                       (count-accessible-rolls diagram width height (1+ x) y
                                                                               (+ count (if (and (paper-roll-at? diagram x y)
                                                                                                 (is-accessible? diagram x y))
                                                                                          1 0))))))))

(define-public (solve1 input)
               (count-accessible-rolls (string->char-matrix input)))

(run solve1)
