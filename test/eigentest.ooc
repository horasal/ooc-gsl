use ooc-gsl
import matrix, eigen
import blas

a := Matrix new(4, 4)

a setIdentity()
a set(1, 2, 1.)
a set(2, 1, 1.)

"Matrix is:" println()
a toString() println()

"Eigenvalue is: " println()
a eigenValue() toString() println()

(ev, ec) := a eigenVector()

"Eigenvalue and eigen vector is: " println()
ev toString() println()
ec toString() println()

"Check if eigev value and eigen vector fits Ax=ax" println()
"x = " print() 
ev getCol(1) toString() println()
"a = " print()
ec get(1) toString() println()
"Ax = " print()
a mul(ev getCol(1)) toString() println()
"ax = " print()
(b := ev getCol(1) clone()) mul(ec get(1))
b toString() println()
a free()
