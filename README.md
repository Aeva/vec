# What is this?

Vec is a simple vector math library for Racket.

This library mostly mirrors the functionality and semantics of GLSL and HLSL's built in vector math intrinsics, which makes manual translation of math to and from shaders relatively painless.

This library has no dependencies beyond the Racket standard library.

This library was written for [Tangerine](https://github.com/Aeva/tangerine/) specifically, and maintains the following conventions when they are significant:

 * The coordinate system is right-handed.

 * Matrices are column-major.

 * Angular inputs for rotations are always degrees not radians.

These conventions are easily worked around for applications with conflicting conventions.  Left-handed applications may need to flip the cross product operands.  Row-major applications will need to periodically transpose matrices.  Irrational number enthusiasts will need to call `radians->degrees` on their angles (or multiply by their favorite 180/PI constant), and are encouraged to reflect upon their life decisions.
