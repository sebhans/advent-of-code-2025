(define-module (day6))
(use-modules (aoc) (ice-9 string-fun) (srfi srfi-1))

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

(define (op s)
  (if (string= s "+")
    +
    (if (string= s "*")
      *
      #f)))

(define-public (solve2 input)
               (cdr
                 (fold (lambda (cur acc)
                         (if (string-every char-numeric? cur)
                           (cons (cons (string->number cur) (car acc)) (cdr acc))
                           (cons '() (+ (cdr acc) (apply (op cur) (car acc))))))
                       '(() . 0)
                       (reverse
                         (string-tokenize
                           (string-replace-substring
                             (string-replace-substring
                               (char-matrix->string
                                 (transpose-array
                                   (string->char-matrix
                                     (let ((lines (lines-in input)))
                                       (string-join (cons (last lines) (drop-right lines 1)) 
                                                  "
"))) 1 0))
                               "*" "* ")
                             "+" "+ "))))))

(run solve1)
(run solve2)
