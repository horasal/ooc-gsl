include gsl/gsl_block_complex_double
include gsl/gsl_vector_complex_double

use ooc-gsl

block_complex: cover from gsl_block_complex_struct{
    size: extern SizeT
    data: extern Double*
}

gslVectorComplex: cover from gsl_vector_complex{
    size: extern SizeT
    stride: extern SizeT
    data: extern Double*
    block: extern block_complex*
    owner: extern Int
}

VectorComplex: cover from gslVectorComplex* {
    new: extern(gsl_vector_complex_alloc) static func(n: SizeT) -> This
    new: extern(gsl_vector_complex_calloc) static func ~zero (n: SizeT) -> This
    new: extern(gsl_vector_alloc_from_vector) static func ~vector (v: Vector, offset, n, stride : SizeT) -> This
    free: extern(gsl_vector_complex_free) func
}
