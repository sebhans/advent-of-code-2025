(define-module (day3))
(use-modules (aoc) (srfi srfi-1))

(define-public (find-leftmost-joltage bank joltage start)
               (string-index bank (integer->char (+ 48 joltage)) start))

(define-public find-best-joltage
               (case-lambda
                 ((bank start end) (find-best-joltage bank start end 9))
                 ((bank start end candidate) (if (< candidate 0)
                                     #f
                                     (let ((pos (find-leftmost-joltage bank candidate start)))
                                       (if (and pos (< pos end))
                                         (cons candidate pos)
                                         (find-best-joltage bank start end (- candidate 1))))))))
(define-public (solve1 input)
               (sum (map (lambda (bank)
                           (letrec ((left-joltage (find-best-joltage bank 0 (- (string-length bank) 1)))
                                    (right-joltage (find-best-joltage bank (1+ (cdr left-joltage)) (string-length bank))))
                             (+ (* (car left-joltage) 10) (car right-joltage))))
                         (lines-in input))))

(run solve1)
