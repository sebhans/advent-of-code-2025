(define-module (aoc))
(use-modules (ice-9 textual-ports)
             (srfi srfi-1))

(define-public run
               (lambda (solver)
                 (if (not (null? (cdr (command-line))))
                   (let ((input-port (open-input-file (car (cdr (command-line))))))
                     (display (solver (get-string-all input-port)))
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
