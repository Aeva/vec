#lang info

(define pkg-name "vec")
(define collection "vec")
(define version "0.0")
(define pkg-desc
  "Simple vector math library")
(define pkg-authors
  '(aeva))
(define license
  'Apache-2.0)

(define implies
  '("vec-lib"))

(define deps
  '("base"
    "vec-lib"))

(define build-deps
  '("racket-doc"
    "scribble-lib"))

(define scribblings
  '(["scribblings/vec.scrbl"]))
