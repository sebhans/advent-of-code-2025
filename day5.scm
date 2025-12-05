(define-module (day5))
(use-modules (aoc) (srfi srfi-1))

(define-public (is-range? s)
  (string-any #\- s))

(define-public (parse-range s)
  (let ((parts (string-split s #\-)))
    (cons (string->number (car parts)) (string->number (cadr parts)))))

(define-public (parse-db input)
               (fold (lambda (line db)
                       (if (string-null? line)
                         db
                         (if (is-range? line)
                           (cons (cons (parse-range line) (car db)) (cdr db))
                           (cons (car db) (cons (string->number line) (cdr db))))))
                     '(() . ())
                     (lines-in input)))

(define-public (sort-db db)
               (cons (sort (car db) (lambda (a b) (< (car a) (car b)))) (sort (cdr db) <)))

(define-public (check-against range ingredient)
               (if (< ingredient (car range))
                 #:too-small
                 (if (> ingredient (cdr range))
                   #:too-large
                   #:fresh)))

(define-public count-fresh-ingredients
               (case-lambda
                 ((db) (let ((sorted-db (sort-db db))) (count-fresh-ingredients (car sorted-db) (cdr sorted-db) 0)))
                 ((ranges ingredients count)
                  (if (null? ingredients)
                    count
                    (if (null? ranges)
                      count
                      (case (check-against (car ranges) (car ingredients))
                        ((#:too-small) (count-fresh-ingredients ranges (cdr ingredients) count))
                        ((#:fresh)     (count-fresh-ingredients ranges (cdr ingredients) (1+ count)))
                        ((#:too-large) (count-fresh-ingredients (cdr ranges) ingredients count))))))))

(define-public (solve1 input)
               (count-fresh-ingredients (parse-db input)))

(run solve1)
