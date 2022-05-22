#lang scribble/manual

@(require (for-label vec))
@(require (for-label racket/math))

@title{Vec: Very Excellent veCtors}
@defmodule[vec]

Vec is a simple vector math library for Racket.

Vec's functionality and semantics mostly mirrors that of GLSL and HLSL's built
in vector math intrinsics, which makes manual translation of math to and from
shaders relatively painless.

Vec has no dependencies beyond the Racket standard library.  The source code and
this documentation are licensed under the Apache 2.0 license.

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

Vector construction is similar to that of GLSL.  Fixed sized vectors are
typically constructed with the @racket[vec2], @racket[vec3], or @racket[vec4]
functions.  The arguments for these functions may be either a singular scalar
value (which is copied into each channel of the output vector), or a mix of
scalar values and vectors which are flattened into a new vector of the correct
size.

The following are all valid, equivalent, and return @racket['(1. 1. 1. 1.)]:

@racketblock[
 (vec4 1.)
 
 (vec4 1. 1. 1. 1.)
 
 (vec4 1. (vec2 1.) 1.)
 
 (vec4 (vec3 1. (vec2 1.)) 1.)

 (vec4 1. 1. 1. 1. "Please don't do this.")

 (vec4 (vec4 1.) 1. 3. 1. 2.)]

@section{Vector Swizzling}

When working with vectors, it is common to need to rearrange, duplicate, or
extract a subset of a vector's channels.  This @italic{verb} is called
@hyperlink["https://en.wikipedia.org/wiki/Swizzling_(computer_graphics)" "swizzling"].
Vec provides rudimentary swizzling via the @racket[swiz] function.

@#reader scribble/comment-reader
 (racketblock
   (define fnord (vec4 2. 4. 6. 8.))

   (swiz fnord 0 0 1 1) ; => '(2. 2. 4. 4.)
 
   (swiz fnord 1 3 1 2) ; => '(4. 8. 4. 6.)

   (swiz fnord 2 2 1) ; => '(6. 6. 4.)
 )

@section{API}

TODO!

If you are feeling bold, @hyperlink["https://github.com/Aeva/vec/blob/excelsior/vec/main.rkt" "the source code"] is fairly simple though.