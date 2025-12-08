(define-module (day8))
(use-modules (aoc) (srfi srfi-1) (srfi srfi-9))

(define-record-type <coord>
  (make-coord x y z)
  coord?
  (x coord-x)
  (y coord-y)
  (z coord-z))
(export <coord> make-coord coord? coord-x coord-y coord-z)

(define-public (parse-coords input)
               (map (lambda (line)
                      (let ((numbers (map string->number (string-split line #\,))))
                        (apply make-coord numbers)))
                    (lines-in input)))

(define-public (distance c1 c2)
               (sqrt (+ (expt (- (coord-x c1) (coord-x c2)) 2)
                        (expt (- (coord-y c1) (coord-y c2)) 2)
                        (expt (- (coord-z c1) (coord-z c2)) 2))))

(define (to-junction-pairs junction-boxes)
  (cartesian-half-product junction-boxes))

(define (sorted-by-distance junction-pairs)
  (map car
       (sort
         (map (lambda (junctions)
                (let ((j1 (car junctions))
                      (j2 (cdr junctions)))
                  (cons junctions (distance j1 j2))))
              junction-pairs)
         (lambda (js1 js2)
           (< (cdr js1) (cdr js2))))))

(define (to-circuit-set junction-boxes)
  (let ((circuits (make-hash-table (length junction-boxes))))
    (for-each (lambda (junction-box)
                (let ((circuit (make-hash-table (length junction-boxes))))
                  (hash-set! circuit junction-box #t)
                  (hash-set! circuits junction-box circuit)))
              junction-boxes)
    circuits))

(define (connect circuits junction-pair)
  (letrec ((j1 (car junction-pair))
           (j2 (cdr junction-pair))
           (c1 (hash-ref circuits j1))
           (c2 (hash-ref circuits j2)))
    (if (hash-ref c1 j2)
      #f
      (begin
        (hash-for-each (lambda (j t)
                         (hash-set! c1 j #t)
                         (hash-set! circuits j c1))
                       c2)
        #t))))

(define (circuit-size circuit)
  (hash-count (const #t) circuit))

(define (largest-circuits circuits n)
  (take
    (sort
      (hash-fold (lambda (junction circuit acc)
                   (lset-adjoin eq? acc circuit))
                 '()
                 circuits)
      (lambda (c1 c2)
        (> (circuit-size c1) (circuit-size c2))))
    n))

(define-public (solve1 input iterations)
               (letrec ((junction-boxes (parse-coords input))
                        (junction-pairs (sorted-by-distance (to-junction-pairs junction-boxes)))
                        (circuits (to-circuit-set junction-boxes))
                        (num-connections 0))
                 (while (< num-connections iterations)
                        (let ((next (first junction-pairs)))
                            (connect circuits next)
                            (set! num-connections (1+ num-connections))
                            (set! junction-pairs (cdr junction-pairs))))
                 (product (map circuit-size (largest-circuits circuits 3)))))

(run solve1 1000)
