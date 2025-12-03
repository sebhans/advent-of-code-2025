# Advent of Code 2025

This repository contains my solutions to the puzzles of [Advent of Code 2025](https://adventofcode.com/2025) in Guile.

Each solution for day _N_ is implemented as a module in `dayN.scm`.
The module exports two functions, `solve1` and `solve2`, for each part of the puzzle,
and may export additional functions for testing purposes.
The solver functions take the input string as their sole argument
and return the solution.

The modules are executable from the command line like this:

```bash
guile -L . day1.scm myday1input.txt
```

## Testing
All examples contained in the puzzles are collected in `tests.scm` in the form
of unit tests. Run them like this:

```bash
guile -L . tests.scm
```

I develop my solutions bottom-up by writing helper functions and composing them.
I write tests for the helper functions of each day in the file `dayN-test.scm`.
Run them like this:

```bash
guile -L . day1-test.scm
```
