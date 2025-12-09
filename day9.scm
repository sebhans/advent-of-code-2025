(define-module (day9))
(use-modules (aoc) (srfi srfi-1) (srfi srfi-9))

(define-record-type <coord>
  (make-coord x y)
  coord?
  (x coord-x)
  (y coord-y))
(export <coord> make-coord coord? coord-x coord-y)

(define-public (parse-coords input)
               (map (lambda (line)
                      (let ((numbers (map string->number (string-split line #\,))))
                        (apply make-coord numbers)))
                    (lines-in input)))

(define-public (area coord-pair)
               (let ((c1 (car coord-pair))
                     (c2 (cdr coord-pair)))
                 (* (1+ (abs (- (coord-x c1) (coord-x c2))))
                    (1+ (abs (- (coord-y c1) (coord-y c2)))))))

(define-public (area< cp1 cp2)
               (< (area cp1) (area cp2)))

(define-public (solve1 input)
               (area (last (sort (cartesian-half-product (parse-coords input)) area<))))

(run solve1)
