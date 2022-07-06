#lang scribble/manual

@(require (for-label vec))
@(require (for-label racket))
@(require scribble/example)

@title{Vec: Very Excellent veCtors}
@author[(author+email "Aeva Palecek" "aeva.ntsc@gmail.com")]
@defmodule[vec]

Vec is a simple vector math library for Racket.

Vec's functionality and semantics mostly mirrors that of GLSL and HLSL's built
in vector math intrinsics, which makes manual translation of math to and from
shaders relatively painless.

Vec has no dependencies beyond the Racket standard library.  The source code and
this documentation are licensed under the Apache 2.0 license.

@(define make-vec-eval
   (make-eval-factory '(vec)))

@section{Features}

@itemlist[
 @item{Vector math functions, constructors, and swizzling forms similar to those
  found in all mainstream shader languages.}
 @item{Functions for creating and working with column-major 4x4 matrices.}
 @item{Functions for creating and working with quaternions.}]

@section{Conventions}

Vec maintains the following conventions when they are significant:

@itemlist[
 @item{The coordinate system is assumed to be right-handed.}
 @item{Matrices constructed by the library are always column-major.}
 @item{Angular inputs for rotations are always degrees not radians.}]

These conventions are easily worked around for applications with conflicting
needs.  Left-handed applications may need to flip the cross product operands.
Row-major applications will need to periodically transpose matrices.  Irrational
number enthusiasts will need to call @racket[radians->degrees] on their angles
(or multiply by their favorite 180/PI constant) and are encouraged to reflect
upon their life decisions.

@section{Vector Construction}

@deftogether[(@defproc[(vec2 [arg any/c] ...+) vec2?]
               @defproc[(vec3 [arg any/c] ...+) vec3?]
               @defproc[(vec4 [arg any/c] ...+) vec4?])]{

Vector construction is similar to that of GLSL.  Fixed sized vectors are
typically constructed with the @racket[vec2], @racket[vec3], or @racket[vec4]
functions.  The arguments for these functions may be either a singular scalar
value (which is copied into each channel of the output vector), or a mix of
scalar values and vectors which are flattened into a new vector of the correct
size.

The following are all valid, equivalent, and return @racket['(1. 1. 1. 1.)]:

@examples[
 #:eval (make-vec-eval)
 (eval:check (vec4 1.)
             '(1. 1. 1. 1.))
 
 (eval:check (vec4 1. 1. 1. 1.)
             '(1. 1. 1. 1.))
 
 (eval:check (vec4 1. (vec2 1.) 1.)
             '(1. 1. 1. 1.))
 
 (eval:check (vec4 (vec3 1. (vec2 1.)) 1.)
             '(1. 1. 1. 1.))

 (eval:check (vec4 1. 1. 1. 1. "Please don't do this.")
             '(1. 1. 1. 1.))

 (eval:check (vec4 (vec4 1.) 1. 3. 1. 2.)
             '(1. 1. 1. 1.))
 ]}

@deftogether[(@defproc[(vec2? [x any/c]) boolean?]
               @defproc[(vec3? [x any/c]) boolean?]
               @defproc[(vec4? [x any/c]) boolean?])]{
 Predicates recognizing vectors of particular lengths.
 These could have been written as, for example:
 @racketblock[
 (define vec3?
   (list/c number? number? number?))]
}

@section{Vector Swizzling}

@defproc[(swiz [vec (or/c vec2? vec3? vec4?)]
               [channel (integer-in 0 (length vec))]
               ...)
         (listof number?)]{

When working with vectors, it is common to need to rearrange, duplicate, or
extract a subset of a vector's channels.  This @italic{verb} is called
@hyperlink["https://en.wikipedia.org/wiki/Swizzling_(computer_graphics)" "swizzling"].
Vec provides rudimentary swizzling via the @racket[swiz] function.

@examples[
 #:eval (make-vec-eval)
 (define fnord (vec4 2. 4. 6. 8.))

 (eval:check (swiz fnord 0 0 1 1)
             '(2. 2. 4. 4.))
 
 (eval:check (swiz fnord 1 3 1 2)
             '(4. 8. 4. 6.))

 (eval:check (swiz fnord 2 2 1)
             '(6. 6. 4.))
 ]}

@section{API}

TODO!

If you are feeling bold, @hyperlink["https://github.com/Aeva/vec/blob/excelsior/vec/main.rkt" "the source code"] is fairly simple though.