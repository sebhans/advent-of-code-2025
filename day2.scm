(define-module (day2))
(use-modules (aoc) (srfi srfi-1))

(define-public list->pairs
               (case-lambda
                 ((l) (list->pairs l '()))
                 ((l p)
                  (if (null? l)
                    (reverse p)
                    (list->pairs (cdr (cdr l)) (cons (cons (first l) (second l)) p))))))

(define-public (string->ranges s)
               (list->pairs (map string->number (string-tokenize s char-set:digit))))

(define-public (range-iterator range)
               (let ((last (cdr range)))
                 (define i
                   (case-lambda
                     ((f initial) (i f initial (car range)))
                     ((f acc cur) (if (> cur last)
                                    acc
                                    (i f (f acc cur) (1+ cur))))))
                 i))

(define-public (halve-string s)
               (substring s 0 (floor-quotient (string-length s) 2)))

(define-public (invalid-id? s)
               (let ((half-s (halve-string s)))
                 (string=? s (string-append half-s half-s))))

(define-public (sum-if predicate range)
               ((range-iterator range) (lambda (count id)
                                                (if (predicate (number->string id))
                                                  (+ count id)
                                                  count)) 0))

(define-public (solve1 input)
               (sum (map (lambda (range) (sum-if invalid-id? range)) (string->ranges input))))

(define-public repeat-string
               (case-lambda
                 ((s n) (repeat-string s n ""))
                 ((s n acc) (if (<= n 0)
                              acc
                              (repeat-string s (- n 1) (string-append acc s))))))

(define-public repeated-string?
               (case-lambda
                 ((s) (repeated-string? s 2 (string-length s)))
                 ((s n) (let ((subseq (substring s 0 (floor-quotient (string-length s) n))))
                          (string=? s (repeat-string subseq n))))
                 ((s repetitions len) (if (> repetitions len)
                                        #f
                                        (if (repeated-string? s repetitions)
                                          #t
                                          (repeated-string? s (1+ repetitions) len))))))

(define-public (strict-invalid-id? s)
               (repeated-string? s))

(define-public (solve2 input)
               (sum (map (lambda (range) (sum-if strict-invalid-id? range)) (string->ranges input))))

(run solve1)
(run solve2)
