use ooc-gsl
import matrix, eigen

a := Matrix new(4, 4)

a setIdentity()
a set(1, 2, 1.)
a set(2, 1, 1.)

a toString() println()

a eigenValue() toString() println()

(ev, ec) := a eigenVector()

ev toString() println()
ec toString() println()

a free()
