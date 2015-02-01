include gsl/gsl_block
include gsl/gsl_vector


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
    mul: extern(gsl_vector_mul) func(This) -> Int
    div: extern(gsl_vector_div) func(This) -> Int

    scale: extern(gsl_vector_scale) func(Double) -> Int
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
        result mul(other)
        result
    }
    operator / (other: This) -> This{
        result := this clone()
        result div(other)
        result
    }
}
