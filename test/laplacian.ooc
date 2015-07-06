use ooc-gsl
import matrix, eigen, blas
import math

A := [
    [0 as Double, 1., 2., 3.],
    [2., 1., -0.5, 3],
    [2.,-1.5, 0.5, 2.],
    [-3., -1.2, 2., -1]]

x := Matrix new(4, 4)
x set(|i, j| A[i][j])

"Data: " print()
x toString() println()

aff := Matrix new(4, 4)
for(i in 0..4){
    ta := x getRow(i)
    aff set(i, i, 0.)
    for(j in i+1..4){
        tb := x getRow(j)
        sum := 0.0
        (ta - tb) get(|x| sum += x * x)
        aff set(i, j, sum sqrt())
        aff set(j, i, sum sqrt())
    }
}

x free()
x = aff

"Aff matrix: " print()
x toString() println()

D := Matrix new ~zero (4, 4)
D set(|i, j| if(i == j){
        sum := 0.0 as Double
        tr := x getRow(i)
        tr get(|x| sum += x)
        tr free()
        return 1. as Double / (sum sqrt())
    }
    return 0)

"D^-1/2: "print()
D toString() println()

// memory leaks because D * x generate new matrix which is not freed
L := D * x * D

"Laplacian: (D^-1/2xD^-1/2)" print()
L toString() println()

(vc, vv) := L eigenVector()

eigenGensymmvSort(vv, vc, gsl_eigen_sort_t GSL_EIGEN_SORT_VAL_DESC)
"Eigen val, vec: "print()
vc toString() println()
vv toString() println()

col1 := vc getCol(0)
col2 := vc getCol(1)

"compressed : "println()
for(i in 0..4){ "%lf %lf" printfln(col1 get(i), col2 get(i)) }

col1 free()
col2 free()

L free()
vc free()
vv free()
x free()
D free()
