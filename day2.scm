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

(define-public (sum-invalid-ids range)
               ((range-iterator range) (lambda (count id)
                                                (if (invalid-id? (number->string id))
                                                  (+ count id)
                                                  count)) 0))

(define-public (sum l)
               (reduce + 0 l))

(define-public (solve1 input)
               (sum (map sum-invalid-ids (string->ranges input))))


(run solve1)
