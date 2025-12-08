(define-module (aoc))
(use-modules (ice-9 textual-ports)
             (srfi srfi-1))

(define-public run
               (lambda (solver . args)
                 (if (not (null? (cdr (command-line))))
                   (let ((input-port (open-input-file (car (cdr (command-line))))))
                     (display (apply solver (get-string-all input-port) args))
                     (display #\newline)
                     (close-port input-port)))))

(define-public lines-in
               (lambda (s)
                 (if (string-null? s)
                   '()
                   (string-split (substring s 0 (+ 1 (string-skip-right s #\newline))) #\newline))))

(define-public (string->char-matrix s)
               (letrec ((lines (lines-in s))
                        (height (length lines))
                        (width (string-length (car lines)))
                        (matrix (make-array #f width height)))
                 (for-each
                   (lambda (y line)
                     (for-each
                       (lambda (x c)
                         (array-set! matrix c x y))
                       (iota (- width 0))
                       line))
                   (iota (- height 0))
                   (map string->list lines))
                 matrix))

(define-public (char-matrix->string m)
               (let ((dimensions (array-dimensions m))
                     (s ""))
                 (for-each (lambda (row)
                             (for-each (lambda (col)
                                         (set! s (string-append s (string (array-ref m col row)))))
                                       (iota (car dimensions)))
                             (set! s (string-append s "
")))
                           (iota (cadr dimensions)))
                 s))

(define-public char-matrix-find-any
               (case-lambda
                 ((m c) (let ((dimensions (array-dimensions m)))
                          (char-matrix-find-any m c (car dimensions) (cadr dimensions) 0 0)))
                 ((m c width height x y) (if (>= y height)
                                          #f
                                          (if (>= x width)
                                            (char-matrix-find-any m c width height 0 (1+ y))
                                            (if (equal? (array-ref m x y) c)
                                              (cons x y)
                                              (char-matrix-find-any m c width height (1+ x) y)))))))

(define-public (split-on-ws s)
               (filter (lambda (part) (not (string-null? part))) (string-split s (char-set #\space #\tab))))

(define-public (string->matrix parse s)
               (letrec ((lines (lines-in s))
                        (height (length lines))
                        (width (length (split-on-ws (car lines))))
                        (matrix (make-array #f width height)))
                 (for-each
                   (lambda (y line)
                     (for-each
                       (lambda (x s)
                         (array-set! matrix (parse x y s) x y))
                       (iota (- width 0))
                       line))
                   (iota (- height 0))
                   (map split-on-ws lines))
                 matrix))

(define-public (sum l)
               (reduce + 0 l))

(define-public (product l)
               (reduce * 1 l))

(define-public (cartesian-product l1 l2)
               (append-map (lambda (e1)
                             (map (lambda (e2)
                                    (cons e1 e2)) l2))
                           l1))

(define-public cartesian-half-product
               (case-lambda
                 ((l) (cartesian-half-product l '()))
                 ((l acc) (if (null? l)
                            acc
                            (let ((head (car l))
                               (tail (cdr l)))
                              (cartesian-half-product tail (append acc (map (lambda (e) (cons head e)) tail))))))))
