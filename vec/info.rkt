#lang info
(define collection "vec")
(define version "NaN")
(define license 'Apache-2.0)

(define deps '("base"))

(define build-deps
  '("racket-doc"
    "scribble-lib"))

(define scribblings '(["scribblings/vec.scrbl"]))