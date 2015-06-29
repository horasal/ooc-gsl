use ooc-gsl
import matrix
import blas

import eigen

import math/Random

a := Matrix new(10, 10)

a set(|i, j| Random random() as Double /INT_MAX )

"A = " print()
a toString() println()

"A + A^T / 2 = " print()
(b := (a + a transposeTo()) / 2 ) toString() println()

"A * A = " print()
(c := a * a) toString() println()

"A isNull? -> " print()
a isNull?() toString() println()
"A isPos? -> " print()
a isPos?() toString() println()
"A isNeg? -> " print()
a isNeg?() toString() println()
"A isNonNeg? -> " print()
a isNonneg?() toString() println()

"A + 1 = " print()
(a+1) toString() println()

"eigen vector and eigen value of A + A^T / 2 = " print()

(ev, ec) := a eigenVector()

ev toString() println()
ec toString() println()
ev free()
ec free()

c free()
b free()
a free()
