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

(define-public find-best-joltage-with-n-batteries
               (case-lambda
                 ((bank n) (find-best-joltage-with-n-batteries bank 0 n 0))
                 ((bank start n acc) (if (zero? n)
                                       acc
                                       (let ((j (find-best-joltage bank start (- (string-length bank) (- n 1)))))
                                         (find-best-joltage-with-n-batteries bank (1+ (cdr j)) (- n 1) (+ (* acc 10) (car j))))))))

(define-public (solve-with-n-batteries input n)
               (sum (map (lambda (bank) (find-best-joltage-with-n-batteries bank n))
                         (lines-in input))))

(define-public (solve1 input) (solve-with-n-batteries input 2))
(define-public (solve2 input) (solve-with-n-batteries input 12))

(run solve1)
(run solve2)
