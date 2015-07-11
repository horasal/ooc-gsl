include gsl/gsl_block
include gsl/gsl_vector
include gsl/gsl_matrix



// TODO use gc_malloc instead of gsl_alloc family

gslBlock: cover from gsl_block{
    size: extern SizeT
    data: extern Double*
}

Block: cover from gslBlock*{
    new: extern(gsl_block_alloc) static func(SizeT) -> This
    new: extern(gsl_block_calloc) static func ~zero (SizeT) -> This
    free: extern(gsl_block_free) func
}


gslVector: cover from gsl_vector{
    size: extern SizeT
    stride: extern SizeT
    data: extern Double*
    block: extern Block
    owner: extern Int
}

Vector: cover from gslVector*{
    new: extern(gsl_vector_alloc) static func(SizeT) -> This
    new: extern(gsl_vector_calloc) static func ~zero (SizeT) -> This
    free: extern(gsl_vector_free) func

    toString: func -> String{
        result := "["
        for(i in 0.. this size()){
            result += this[i] toString() + ","
        }
        result + "]"
    }

    size : func -> SizeT{ this@ size }

    get: extern(gsl_vector_get) func(SizeT) -> Double
    set: extern(gsl_vector_set) func(SizeT, Double)

    set: func ~closureix (f: Func(SizeT, Double)->Double){
        for(i in 0..this size()){ set(i, f(i, get(i))) }
    }

    set: func ~closurex (f: Func(Double)->Double){
        for(i in 0..this size()){ set(i, f(get(i))) }
    }

    set: func ~closure (f: Func()->Double){
        for(i in 0..this size()){ set(i, f()) }
    }

    get: func ~closurex(f: Func(Double)){
        for(i in 0..this size()){ f(get(i)) }
    }

    get: func ~closureix (f: Func(SizeT,Double)){
        for(i in 0..this size()){ f(i,get(i)) }
    }

    basis: extern(gsl_vector_set_basis) func(SizeT) -> Int

    swap: extern(gsl_vector_swap_elements) func(SizeT, SizeT) -> Int

    reverse: extern(gsl_vector_reverse) func -> Int

    copyFrom: extern(gsl_vector_memcpy) func(This) -> Int

    clone : func -> This{
        other := Vector new(this@ size)
        other copyFrom(this)
        other
    }

    add: extern(gsl_vector_add) func(This) -> Int
    sub: extern(gsl_vector_sub) func(This) -> Int
    mulElem: extern(gsl_vector_mul) func(This) -> Int
    div: extern(gsl_vector_div) func(This) -> Int

    mul: extern(gsl_vector_scale) func ~constant (Double) -> Int
    add: extern(gsl_vector_add_constant) func ~constant(Double) -> Int

    operator [] (i: SizeT) -> Double{ get(i) }
    operator []= (i: SizeT, v: Double){ set(i, v) }

    operator + (other: Double) -> This{
        result := this clone()
        result add(other)
        result
    }
    operator + (other: This) -> This{
        result := this clone()
        result add(other)
        result
    }
    operator - (other: This) -> This{
        result := this clone()
        result sub(other)
        result
    }
    operator * (other: This) -> This{
        result := this clone()
        result mulElem(other)
        result
    }
    operator / (other: This) -> This{
        result := this clone()
        result div(other)
        result
    }
}

gslMatrix: cover from gsl_matrix{
    size1: extern SizeT
    size2: extern SizeT
    tda: extern SizeT
    data: extern Double*
    block: extern Block;
    owner: extern Int
}

Matrix: cover from gslMatrix*{
    new: extern(gsl_matrix_alloc) static func(n1, n2: SizeT) -> This
    new: extern(gsl_matrix_calloc) static func ~zero (n1, n2: SizeT) -> This
    free: extern(gsl_matrix_free) func

    size1: func -> SizeT{ this@ size1 }
    size2: func -> SizeT{ this@ size2 }

    get: extern(gsl_matrix_get) func(i,j: SizeT) -> Double
    set: extern(gsl_matrix_set) func(i,j: SizeT, x: Double) -> Double
    getPtr: extern(gsl_matrix_ptr) func(i, j: SizeT) -> Double*
    setAll: extern(gsl_matrix_set_all) func(x: Double)
    setZero: extern(gsl_matrix_set_zero) func
    setIdentity: extern(gsl_matrix_set_identity) func

    set: func ~closure (f: Func->Double){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                set(i, j, f())
            }
        }
    }

    set: func ~closurex (f: Func(Double)->Double){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                set(i, j, f(get(i,j)))
            }
        }
    }

    set: func ~closureij (f: Func(SizeT,SizeT)->Double){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                set(i, j, f(i, j))
            }
        }
    }

    set: func ~closureijx (f: Func(SizeT,SizeT,Double)->Double){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                set(i, j, f(i, j, get(i,j)))
            }
        }
    }

    get: func ~closurex (f: Func(Double)){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                f(get(i, j))
            }
        }
    }

    get: func ~closureijx (f: Func(SizeT, SizeT, Double)){
        for(i in 0 .. this size1()){
            for(j in 0 .. this size2()){
                f(i, j, get(i, j))
            }
        }
    }

    copyFrom: extern(gsl_matrix_memcpy) func(other: This)
    copyTo: func(other: This){ other copyFrom(this) }
    swap: extern(gsl_matrix_swap) func(other: This)
    clone: func -> This{
        other := Matrix new(this size1(), this size2())
        other copyFrom(this)
        other
    }
    
    /* private function 
     From the manual of gsl, get_row and get_col is function of matrix, however,
     they are not started from parameter matrix.
     */
    _get_row: extern(gsl_matrix_get_row) static func(v: Vector, m: Matrix, i: SizeT)
    _get_col: extern(gsl_matrix_get_col) static func(v: Vector, m: Matrix, i: SizeT)

    getRow: func(i: SizeT) -> Vector{
        v := Vector new(this size2())
        _get_row(v, this, i)
        v
    }
    getCol: func(i: SizeT) -> Vector{
        v := Vector new(this size1())
        _get_col(v, this, i)
        v
    }

    setRow: extern(gsl_matrix_set_row) func(i: SizeT, v: Vector)
    setCol: extern(gsl_matrix_set_col) func(i: SizeT, v: Vector)

    _transposeTo: extern(gsl_matrix_transpose_memcpy) static func(a, b: Matrix) -> Int

    transpose: extern(gsl_matrix_transpose) func -> Int
    transposeTo: func -> Matrix{
        m := Matrix new(this size2(), this size1())
        _transposeTo(m, this)
        m
    }

    swapRow: extern(gsl_matrix_swap_rows) func(i, j: SizeT) -> Int
    swapCol: extern(gsl_matrix_swap_rows) func(i, j: SizeT) -> Int
    swapRowCol: extern(gsl_matrix_swap_rowcol) func(i, j: SizeT) -> Int
    swapColRow: func(i, j: SizeT) -> Int{ swapRowCol(j, i) }

    add: extern(gsl_matrix_add) func(other: Matrix) -> Int
    sub: extern(gsl_matrix_sub) func(other: Matrix) -> Int
    mulElem: extern(gsl_matrix_mul_elements) func(other: Matrix) -> Int
    divElem: extern(gsl_matrix_div_elements) func(other: Matrix) -> Int
    mul: extern(gsl_matrix_scale) func ~elem (other: Double) -> Int
    add: extern(gsl_matrix_add_constant) func ~elem (other: Double) -> Int

    max: extern(gsl_matrix_max) func -> Double
    min: extern(gsl_matrix_min) func -> Double

    isNull?: extern(gsl_matrix_isnull) func -> Bool
    isPos?: extern(gsl_matrix_ispos) func -> Bool
    isNeg?: extern(gsl_matrix_isneg) func -> Bool
    isNonneg?: extern(gsl_matrix_isnonneg) func -> Bool

    isEqual?: extern(gsl_matrix_equal) func(other: Matrix) -> Bool

    toString: func -> String{
        result := "{\n"
        for(i in 0..this size1()){
            result += "["
            for(j in 0..this size2()){
                result += "%lf, " format(this get(i, j))
            }
            result += "]\n"
        }
        result + "}"
    }

    operator + (other: This) -> This{
        r := this clone()
        r add(other)
        r
    }

    operator + (other: Double) -> This{
        r := this clone()
        r add(other)
        r
    }

    operator - (other: This) -> This{
        r := this clone()
        r sub(other)
        r
    }

    operator - (other: Double) -> This{
        r := this clone()
        r add(-other)
        r
    }

    operator / (other: Double) -> This{
        r := this clone()
        r mul(1./other)
        r
    }

    operator / (other: This) -> This{
        r := this clone()
        r divElem(other)
        r
    }
}
