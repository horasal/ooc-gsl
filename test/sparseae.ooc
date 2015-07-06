use ooc-gsl

import matrix, blas
import math

AE : class{
    A : Matrix
    b,c : Vector

    init: func(i, j: SizeT{
            A = Matrix new(i, j)
            b = Vector new(j)
            c = Vector new(i)

            A set(|| Random random() as Double / INT_MAX)
            b set(|| Random random() as Double / INT_MAX)
            c set(|| Random random() as Double / INT_MAX)
    }

    run: func(x: Matrix, maxiter: SizeT){
        // h = Ax + b
        // x1 = A^Th + c
        // x1 = A^T(Ax+b) -> A^TAx + A^Tb
        // |x - x1|_2 --> 0
        // dA = (x-x1)*(2Ax+b)
        // db = (x-x1)*(A)
    }
}
