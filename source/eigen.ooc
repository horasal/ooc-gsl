include gsl/gsl_eigen

use ooc-gsl
import matrix

/* real-value symmetric matrices */

/* eigen values */
_eigen_symm_alloc : extern(gsl_eigen_symm_alloc) func (n: SizeT) -> Pointer
_eigen_symm_free : extern(gsl_eigen_symm_free) func (w: Pointer)
_eigen_symm: extern(gsl_eigen_symm) func (A: Matrix, eval: Vector, w: Pointer) -> Int
/* eigen values and eigen vectors */
_eigen_symmv_alloc : extern(gsl_eigen_symmv_alloc) func (n: SizeT) -> Pointer
_eigen_symmv_free : extern(gsl_eigen_symmv_free) func (w: Pointer)
_eigen_symmv : extern(gsl_eigen_symmv) func(A: Matrix, eval: Vector, evec: Matrix, w: Pointer) -> Int

/* sort */
gsl_eigen_sort_t: extern enum{
    GSL_EIGEN_SORT_VAL_ASC
    GSL_EIGEN_SORT_VAL_DESC
    GSL_EIGEN_SORT_ABS_ASC
    GSL_EIGEN_SORT_ABS_DESC
}

eigenSymmvSort: extern(gsl_eigen_symmv_sort) func( eval: Vector, evec: Matrix, sort: gsl_eigen_sort_t) -> Int
eigenGensymmvSort: extern(gsl_eigen_gensymmv_sort) func( eval: Vector, evec: Matrix, sort: gsl_eigen_sort_t) -> Int

extend Matrix{
    eigenValue: func -> Vector{
        r := Vector new(this size1())
        p := _eigen_symm_alloc(this size1())
        _eigen_symm(this, r, p)
        _eigen_symm_free(p)
        r
    }

    eigenVector: func -> (Matrix, Vector){
        rv := Vector new(this size1())
        rc := Matrix new(this size1(), this size2())

        p := _eigen_symmv_alloc(this size1())
        _eigen_symmv(this, rv, rc, p)
        _eigen_symmv_free(p)

        (rc, rv)
    }
}


/* real-value non-symmetric matrices */

/* eigen values */
//gsl_eigen_nonsymm_alloc (n: SizeT) -> Pointer
//gsl_eigen_nonsymm_free (w: Pointer)
//gsl_eigen_nonsymm_params (compute_t: Int, balance: Int, w: Pointer)
//gsl_eigen_nonsymm (A: Matrix, gsl_vector_complex * eval, w: Pointer) -> Int
//gsl_eigen_nonsymm_Z (gsl_matrix * A, gsl_vector_complex * eval, gsl_matrix * Z, gsl_eigen_nonsymm_workspace * w) -> Int

/* eigen values and eigen vocters */
//gsl_eigen_nonsymmv_workspace * gsl_eigen_nonsymmv_alloc (const size_t n)
//gsl_eigen_nonsymmv_free (gsl_eigen_nonsymmv_workspace * w)
//gsl_eigen_nonsymmv_params (const int balance, gsl_eigen_nonsymm_workspace * w)
//gsl_eigen_nonsymmv (gsl_matrix * A, gsl_vector_complex * eval, gsl_matrix_complex * evec, gsl_eigen_nonsymmv_workspace * w) -> Int
//gsl_eigen_nonsymmv_Z (gsl_matrix * A, gsl_vector_complex * eval, gsl_matrix_complex * evec, gsl_matrix * Z, gsl_eigen_nonsymmv_workspace * w) -> Int
