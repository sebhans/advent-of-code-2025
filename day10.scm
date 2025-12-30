(define-module (day10))
(use-modules (aoc) (srfi srfi-1) (srfi srfi-9))

(define-record-type <machine-spec>
  (make-machine-spec start-indicators buttons joltage-requirements)
  machine-spec?
  (start-indicators machine-spec-start-indicators)
  (buttons machine-spec-buttons)
  (joltage-requirements machine-spec-joltage-requirements))
(export <machine-spec> make-machine-spec machine-spec? machine-spec-indicators machine-spec-buttons machine-spec-joltage-requirements)

(define-public (parse-indicators s)
               (list->vector (drop-right (drop (string->list s) 1) 1)))

(define (parse-bracketed-numbers s)
               (map string->number (string-split (string-drop-right (string-drop s 1) 1) #\,)))

(define-public parse-button parse-bracketed-numbers)

(define-public (parse-joltage-requirements s)
               (list->vector (parse-bracketed-numbers s)))

(define-public (parse-machine-spec s)
               (let ((parts (string-split s #\space)))
                 (make-machine-spec (parse-indicators (first parts))
                               (map parse-button (drop-right (drop parts 1) 1))
                               (parse-joltage-requirements (last parts)))))

(define (toggle indicators i)
  (vector-set! indicators i (case (vector-ref indicators i)
                              ((#\#) #\.)
                              ((#\.) #\#))))

(define-public (press-button indicators button)
               (let ((new-indicators (vector-copy indicators)))
                 (for-each (lambda (i)
                             (toggle new-indicators i))
                           button)
                 new-indicators))

(define (is-on machine-spec indicators)
  (equal? indicators (machine-spec-start-indicators machine-spec)))

(define-record-type <machine-history>
  (make-machine-history indicators button-sequence)
  machine-history?
  (indicators current-indicators)
  (button-sequence button-sequence))

(define (init-machine-history machine-spec)
  (make-machine-history (make-vector (vector-length (machine-spec-start-indicators machine-spec)) #\.)
                        '()))

(define switch-on (case-lambda
                    ((machine-spec)
                     (switch-on machine-spec (list (init-machine-history machine-spec))))
                    ((machine-spec histories)
                     (letrec ((h (car histories))
                              (i (current-indicators h))
                              (b (button-sequence h))
                              (next (map (lambda (button)
                                           (make-machine-history (press-button i button) (cons button b)))
                                         (machine-spec-buttons machine-spec)))
                              (on (find (lambda (history)
                                          (is-on machine-spec (current-indicators history)))
                                        next)))
                       (if on
                         on
                         (switch-on machine-spec (append (cdr histories) next)))))))

(define-public (solve1 input)
               (sum
                 (map (lambda (history)
                        (length (button-sequence history)))
                      (map switch-on (map parse-machine-spec (lines-in input))))))

(run solve1)
