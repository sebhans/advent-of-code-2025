(use-modules (srfi srfi-64))
(use-modules ((day1) #:prefix day1:))
(use-modules ((day2) #:prefix day2:))
(use-modules ((day3) #:prefix day3:))
(use-modules ((day4) #:prefix day4:))
(test-begin "harness")

(define day1-example "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82")
(test-equal "example day 1, part 1" 3 (day1:solve1 day1-example))
(test-equal "example day 1, part 2" 6 (day1:solve2 day1-example))

(define day2-example "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124")
(test-equal "example day 2, part 1" 1227775554 (day2:solve1 day2-example))
(test-equal "example day 2, part 2" 4174379265 (day2:solve2 day2-example))

(define day3-example "987654321111111
811111111111119
234234234234278
818181911112111")
(test-equal "example day 3, part 1" 357 (day3:solve1 day3-example))
(test-equal "example day 3, part 2" 3121910778619 (day3:solve2 day3-example))

(define day4-example "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.")
(test-equal "example day 4, part 1" 13 (day4:solve1 day4-example))

(test-end "harness")
