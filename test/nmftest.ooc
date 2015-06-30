use ooc-gsl

import matrix, blas

import math/Random

extend Double{
    abs: func ~test -> Double{ this > 0 ? this : -this }
}


NMF : class{
    x: Matrix
    W,H: Matrix

    random: static func(i,j: SizeT) -> Double{
        Random random() as Double / INT_MAX as Double
    }

    init: func(=x, k: SizeT){
        W = Matrix new(x size1(), k)
        H = Matrix new(k, x size2())
        W set(this random)
        H set(this random)
    }

    free: func{
        W free()
        H free()
    }

    error: func -> Double{
        t1 := W*H
        t2 := x - t1

        sum : Double = 0.0
        //t2 get(|i,j,x| sum += x abs~test() )
        t2 get(|i,j,x| sum += x * x  )

        t2 free()
        t1 free()

        sum
    }

    updateH: func{
        upp := W transposeTo()
        low := W transposeTo()

        t1 := upp mul(x)
        upp free()

        t2 := low mul(W)
        t3 := t2 mul(H)

        low free()

        t1 divElem(t3)
        H mulElem(t1)

        t1 free()
        t2 free()
        t3 free()
    }

    updateW: func{
        upp := x clone()
        low := W clone()

        t1 := low mul(H)

        mH := H transposeTo()

        t2 := upp mul(mH)
        t3 := t1 mul(mH)

        upp free()
        low free()
        mH free()

        t2 divElem(t3)
        W mulElem(t2)

        t1 free()
        t2 free()
        t3 free()
    }

    run: func(maxiter: SizeT = 100){
        k := 0
        while(k < maxiter){
            updateH()
            updateW()
            k += 1
            if(k % 10 == 0){ (e := error()) toString() println() }
        }
    }
}

data := const [
    [1. as Double, 1., 0.],
    [1.5, 0.5, 0 ],
    [2., 1., 0.],
    [0.5, 1.2, 0.5],
    [0.3, 1.5, 0.3],
    [0.7, 2.8, 2.5],
    [0.1, 2.4, 2.],
    [1.0, 3.5, 1],
    [0., 2.0, 2.0],
    [0.5, 3.0, 2.0]]

testX := Matrix new(3, 10)
testX set(|i, j| data[j][i])
nmf := NMF new(testX, 2)

nmf run(1000)

"W is : " print()
nmf W toString() println()

"H is : " print()
nmf H toString() println()

xapp := nmf W * nmf H

"X is : " print()
testX toString() println()

"W*H is : " print()
xapp toString() println()

nmf free()
testX free()
xapp free()
