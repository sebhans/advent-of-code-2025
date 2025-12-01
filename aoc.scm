(define-module (aoc))
(use-modules (ice-9 textual-ports))
(define-public run
               (lambda (solver)
                 (if (not (null? (cdr (command-line))))
                   (let ((input-port (open-input-file (car (cdr (command-line))))))
                     (display (solver (get-string-all input-port)))
                     (close-port input-port)))))
