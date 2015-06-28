include gsl/gsl_blas

use ooc-gsl
import matrix

Order: enum{ RowMajor = 101 , ColMajor = 102 }
Transpose: enum{ NoTrans = 111, Trans = 112, ConjTrans = 113}
Uplo: enum{ Upper = 121, Lower = 122}
Diag: enum{ NonUnit = 131, Unit = 132}
Side: enum{Left = 141, Right = 142}

/* Level 1 */
_ddot:extern( gsl_blas_ddot ) func(x: Vector, y: Vector, result: Double*) -> Int 
_dnrm2:extern( gsl_blas_dnrm2 ) func( x: Vector )-> Double 
_dasum:extern( gsl_blas_dasum ) func( x: Vector )-> Double 
_idamax:extern( gsl_blas_idamax ) func( x: Vector) -> SizeT
_dswap:extern( gsl_blas_dswap ) func(x, y: Vector)->Int 
_dcopy:extern( gsl_blas_dcopy ) func( x, y: Vector)->Int 
_daxpy:extern( gsl_blas_daxpy ) func(alpha: Double,  x: Vector, y: Vector)->Int 
_dscal:extern( gsl_blas_dscal ) func(alpha: Double, x: Vector)
_drotg:extern( gsl_blas_drotg ) func(a, b, c, s: Double*)->Int 
_drot:extern( gsl_blas_drot ) func(x, y: Vector, c, s: Double)->Int 
_drotmg:extern( gsl_blas_drotmg ) func(d1, d2, b1: Double*, b2: Double, P: Double*)->Int 
_drotm:extern( gsl_blas_drotm ) func(x, y: Vector,  P: Double*)->Int 

/* Level 2 */
_dgemv:extern( gsl_blas_dgemv ) func(TransA: Transpose, alpha: Double, A: Matrix, x: Vector, beta: Double, y: Vector)->Int 
_dtrmv:extern( gsl_blas_dtrmv ) func(uplo: Uplo, TransA: Transpose, diag: Diag, A: Matrix, x: Vector)->Int 
_dtrsv:extern( gsl_blas_dtrsv ) func(uplo: Uplo, TransA: Transpose, diag: Diag, A: Matrix, x: Vector)->Int 
_dsymv:extern( gsl_blas_dsymv ) func(uplo: Uplo, alpha: Double, A: Matrix, x: Vector, beta: Double, y: Vector)->Int 
_dger:extern( gsl_blas_dger ) func(alpha: Double,  x, y: Vector, A: Matrix)->Int 
_dsyr:extern( gsl_blas_dsyr ) func(uplo: Uplo, alpha: Double, x: Vector, A: Matrix)->Int 
_dsyr2:extern( gsl_blas_dsyr2 ) func(uplo: Uplo, alpha: Double, x, y: Vector, A: Matrix)->Int 

/* Level 3 */
_dgemm:extern( gsl_blas_dgemm ) func(TransA, TransB: Transpose, alpha: Double,  A, B: Matrix, beta: Double, C: Matrix)->Int 
_dsymm:extern( gsl_blas_dsymm ) func(side: Side, uplo: Uplo, alpha: Double,  A, B: Matrix, beta: Double, C: Matrix)->Int 
_dtrmm:extern( gsl_blas_dtrmm ) func(side: Side, uplo: Uplo, TransA: Transpose, diag: Diag, alpha: Double,  A, B: Matrix)->Int 
_dtrsm:extern( gsl_blas_dtrsm ) func(side: Side, uplo: Uplo, TransA: Transpose, diag: Diag, alpha: Double,  A, B: Matrix)->Int 
_dsyrk:extern( gsl_blas_dsyrk ) func(uplo: Uplo, Trans: Transpose, alpha: Double,  A: Matrix, beta: Double, C: Matrix)->Int 
_dsyr2k:extern( gsl_blas_dsyr2k ) func(uplo: Uplo, Trans: Transpose, alpha: Double, A, B: Matrix, beta: Double, C: Matrix)->Int 


/* add blas functions to Matrix and Vector */
extend Vector{
}

extend Matrix{
    mul: func ~matrix (other: Matrix) -> This {
        c := Matrix new(this size1(), this size2())
        _degmm(Transpose NoTrans, Transpose NoTRans, 1., this, other, 0, c)
        c
    }
}
