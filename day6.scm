(define-module (day6))
(use-modules (aoc) (srfi srfi-1))

(define-public (solve1 input)
               (letrec ((problems (string->matrix
                                 (lambda (x y s)
                                   (cond
                                     ((string-every char-numeric? s) (string->number s))
                                     ((equal? s "+") +)
                                     ((equal? s "*") *)))
                                 input))
                        (dimensions (array-dimensions problems))
                        (current-problem '())
                        (total 0))
                 (for-each (lambda (row)
                             (for-each (lambda (col)
                                         (let ((cur (array-ref problems row col)))
                                           (if (procedure? cur)
                                             (begin
                                               (set! total (+ total (apply cur current-problem)))
                                               (set! current-problem '()))
                                             (set! current-problem (cons cur current-problem)))))
                                       (iota (cadr dimensions))))
                           (iota (car dimensions)))
                 total))

(run solve1)
