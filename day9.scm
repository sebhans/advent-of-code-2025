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

(define-record-type <coord-mapping>
  (make-coord-mapping xs ys nx ny)
  coord-mapping?
  (xs coord-mapping-xs)
  (ys coord-mapping-ys)
  (nx coord-mapping-size-x)
  (ny coord-mapping-size-y))

(define (with-neighbours x)
  (list (1- x) x (1+ x)))

(define-public (generate-coord-mapping coords)
               (let ((xs (cdr (dedup (sort (append-map with-neighbours (map coord-x coords)) <))))
                     (ys (cdr (dedup (sort (append-map with-neighbours (map coord-y coords)) <)))))
                 (make-coord-mapping xs ys (length xs) (length ys))))

(define map-axis
  (case-lambda
    ((axis x) (map-axis axis x -1))
    ((axis x i) (cond ((null? axis) i)
                      ((< x (car axis)) i)
                      (else (map-axis (cdr axis) x (1+ i)))))))

(define-public (mapped coord-mapping coord)
               (make-coord (map-axis (coord-mapping-xs coord-mapping) (coord-x coord))
                           (map-axis (coord-mapping-ys coord-mapping) (coord-y coord))))

(define (unmap-axis axis x)
  (cond ((< x 0) 0)
        ((null? axis) 999999999)
        ((= x 0) (car axis))
        (else (unmap-axis (cdr axis) (1- x)))))

(define-public (unmapped coord-mapping coord)
               (make-coord (unmap-axis (coord-mapping-xs coord-mapping) (coord-x coord))
                           (unmap-axis (coord-mapping-ys coord-mapping) (coord-y coord))))

(define paint
  (case-lambda
    ((tiles coord) (array-set! tiles #\X (coord-x coord) (coord-y coord)))
    ((tiles x y) (array-set! tiles #\X x y))))

(define (draw-line tiles c1 c2)
  (paint tiles c1)
  (cond ((> (coord-x c1) (coord-x c2)) (draw-line tiles (make-coord (1- (coord-x c1)) (coord-y c1)) c2))
        ((< (coord-x c1) (coord-x c2)) (draw-line tiles (make-coord (1+ (coord-x c1)) (coord-y c1)) c2))
        ((> (coord-y c1) (coord-y c2)) (draw-line tiles (make-coord (coord-x c1) (1- (coord-y c1))) c2))
        ((< (coord-y c1) (coord-y c2)) (draw-line tiles (make-coord (coord-x c1) (1+ (coord-y c1))) c2))
        (else #t)))

(define (connect-red-tiles tiles head tail)
  (if (null? tail)
    #t
    (let ((next (car tail)))
      (draw-line tiles head next)
      (connect-red-tiles tiles next (cdr tail)))))

(define (painted? tiles x y)
  (and (>= x 0) (equal? (array-ref tiles x y) #\X)))

(define (fill-green tiles width height x y above)
  (cond
    ((>= x width) #t)
    ((>= y height) (fill-green tiles width height (1+ x) 0 #:outside))
    (else
      (letrec ((painted (painted? tiles x y))
               (painted-left (painted? tiles (1- x) y))
               (go-down (lambda (state)
                          (when (eq? state #:inside) (paint tiles x y))
                          (fill-green tiles width height x (1+ y) state))))
        (cond
          ((and (eq? above #:outside)               (not painted))                    (go-down #:outside))
          ((and (eq? above #:outside)                    painted)                     (go-down #:opening-border))
          ((and (eq? above #:opening-border)             painted       painted-left)  (go-down #:right-opening-border))
          ((and (eq? above #:opening-border)             painted  (not painted-left)) (go-down #:left-opening-border))
          ((and (eq? above #:opening-border)        (not painted))                    (go-down #:inside))
          ((and (eq? above #:left-opening-border)        painted)                     (go-down #:left-opening-border))
          ((and (eq? above #:left-opening-border)   (not painted)      painted-left)  (go-down #:inside))
          ((and (eq? above #:left-opening-border)   (not painted) (not painted-left)) (go-down #:outside))
          ((and (eq? above #:right-opening-border)       painted)                     (go-down #:right-opening-border))
          ((and (eq? above #:right-opening-border)  (not painted)      painted-left)  (go-down #:inside))
          ((and (eq? above #:right-opening-border)  (not painted) (not painted-left)) (go-down #:outside))
          ((and (eq? above #:inside)                (not painted))                    (go-down #:inside))
          ((and (eq? above #:inside)                     painted)                     (go-down #:closing-border))
          ((and (eq? above #:closing-border)        (not painted))                    (go-down #:outside))
          ((and (eq? above #:closing-border)             painted       painted-left)  (go-down #:right-closing-border))
          ((and (eq? above #:closing-border)             painted  (not painted-left)) (go-down #:left-closing-border))
          ((and (eq? above #:left-closing-border)        painted)                     (go-down #:left-closing-border))
          ((and (eq? above #:right-closing-border)       painted)                     (go-down #:right-closing-border))
          ((and (eq? above #:left-closing-border)   (not painted)      painted-left)  (go-down #:inside))
          ((and (eq? above #:left-closing-border)   (not painted) (not painted-left)) (go-down #:outside))
          ((and (eq? above #:right-closing-border)  (not painted)      painted-left)  (go-down #:inside))
          ((and (eq? above #:right-closing-border)  (not painted) (not painted-left)) (go-down #:outside)))))))

(define (color-tiles coords width height)
  (let ((tiles (make-array #\. width height))
        (wrapped-coords (append coords (list (car coords)))))
    (connect-red-tiles tiles (last coords) coords)
    (fill-green tiles width height 0 0 #:outside)
    tiles))

(define (contains-unpainted tiles coord-mapping)
  (lambda (coord-pair)
    (letrec ((c1 (mapped coord-mapping (car coord-pair)))
             (c2 (mapped coord-mapping (cdr coord-pair)))
             (x1 (min (coord-x c1) (coord-x c2)))
             (x2 (max (coord-x c1) (coord-x c2)))
             (y1 (min (coord-y c1) (coord-y c2)))
             (y2 (max (coord-y c1) (coord-y c2))))
      (or (any (lambda (x) (or (not (painted? tiles x y1)) (not (painted? tiles x y2)))) (iota (- x2 x1) (1+ x1) 1))
          (any (lambda (y) (or (not (painted? tiles x1 y)) (not (painted? tiles x2 y)))) (iota (- y2 y1) (1+ y1) 1))))))

(define-public (solve2 input)
               (letrec ((coords (parse-coords input))
                        (mapping (generate-coord-mapping coords))
                        (mapped-coords (map (lambda (c) (mapped mapping c)) coords))
                        (tiles (color-tiles mapped-coords (coord-mapping-size-x mapping) (coord-mapping-size-y mapping))))
                 (area (last (remove (contains-unpainted tiles mapping) (sort (cartesian-half-product coords) area<))))))

(run solve1)
(run solve2)
