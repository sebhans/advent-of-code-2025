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
                 (cons new-position (if (zero? new-position) (1+ zeroes) zeroes)))))

(define-public solve1
               (lambda (input)
                 (cdr (fold apply-rotation '(50 . 0) (map parse-rotation (lines-in input))))))

(define sign
  (lambda (n)
    (cond ((> n 0) 1)
          ((< n 0) -1)
          (else 0))))

(define-public zero-hits
               (lambda (dial rotation)
                 (letrec ((short-rotation (* (sign rotation) (modulo (abs rotation) 100)))
                          (moved-dial-raw (+ dial short-rotation))
                          (moved-dial (modulo moved-dial-raw 100)))
                   (+ (truncate (/ (abs rotation) 100))
                      (if (and (zero? moved-dial) (not (zero? (modulo rotation 100)))) 1 0)
                      (if (and (not (zero? dial)) (not (zero? moved-dial)) (not (= moved-dial moved-dial-raw))) 1 0)))))

(define-public apply-rotation-count-all-zeroes
               (lambda (rotation state)
                 (let ((zeroes (cdr state))
                       (new-position (modulo (+ (car state) rotation) 100)))
                 (cons new-position (+ zeroes (zero-hits (car state) rotation))))))

(define-public solve2
               (lambda (input)
                 (cdr (fold apply-rotation-count-all-zeroes '(50 . 0) (map parse-rotation (lines-in input))))))

(run solve1)
(run solve2)
