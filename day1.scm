(define-module (day1))
(use-modules (aoc) (srfi srfi-1))

(define-public parse-rotation
               (lambda (rotation)
                 (if (equal? (string-ref rotation 0) #\L)
                   (- 0 (string->number (substring rotation 1)))
                   (string->number (substring rotation 1)))))

(define-public apply-rotation
               (lambda (rotation state)
                 (let ((zeroes (cdr state))
                       (new-position (modulo (+ (car state) rotation) 100)))
                 (cons new-position (if (= 0 new-position) (1+ zeroes) zeroes)))))

(define-public solve1
               (lambda (input)
                 (cdr (fold apply-rotation '(50 . 0) (map parse-rotation (lines-in input))))))

(run solve1)
