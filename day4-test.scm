(use-modules (srfi srfi-64) (day4))
(test-begin "harness")

(define paper-roll-at-test-diagram (make-array #\. 3 3))
(array-set! paper-roll-at-test-diagram #\@ 2 1)
(test-equal "paper-roll-at? finds paper roll where there is a paper roll"
            #t
            (paper-roll-at? paper-roll-at-test-diagram 2 1))
(test-equal "paper-roll-at? finds no paper roll where there is no paper roll"
            #f
            (paper-roll-at? paper-roll-at-test-diagram 1 1))
(test-equal "paper-roll-at? finds no paper roll beyond top"
            #f
            (paper-roll-at? paper-roll-at-test-diagram 2 -1))
(test-equal "paper-roll-at? finds no paper roll beyond bottom"
            #f
            (paper-roll-at? paper-roll-at-test-diagram 2 3))
(test-equal "paper-roll-at? finds no paper roll beyond left"
            #f
            (paper-roll-at? paper-roll-at-test-diagram -1 1))
(test-equal "paper-roll-at? finds no paper roll beyond right"
            #f
            (paper-roll-at? paper-roll-at-test-diagram 3 1))

(define is-accessible-test-diagram (make-array #\. 4 5))
(array-set! is-accessible-test-diagram #\@ 0 0)

(array-set! is-accessible-test-diagram #\@ 3 0)
(array-set! is-accessible-test-diagram #\@ 2 0)
(array-set! is-accessible-test-diagram #\@ 3 1)
(array-set! is-accessible-test-diagram #\@ 2 1)

(array-set! is-accessible-test-diagram #\@ 3 3)
(array-set! is-accessible-test-diagram #\@ 2 3)
(array-set! is-accessible-test-diagram #\@ 2 2)
(array-set! is-accessible-test-diagram #\@ 3 4)
(array-set! is-accessible-test-diagram #\@ 3 2)
(test-equal "is-accessible? finds paper roll with no neighbours accessible"
            #t
            (is-accessible? is-accessible-test-diagram 0 0))
(test-equal "is-accessible? finds paper roll with 3 neighbours accessible"
            #t
            (is-accessible? is-accessible-test-diagram 3 0))
(test-equal "is-accessible? finds paper roll with 4 neighbours inaccessible"
            #f
            (is-accessible? is-accessible-test-diagram 3 3))

(define count-accessible-rolls-test-diagram (make-array #\@ 3 3))
(test-equal "count-accessible-rolls finds 4 accessible rolls in a full 3x3 diagram"
            4
            (count-accessible-rolls count-accessible-rolls-test-diagram))

(test-end "harness")
