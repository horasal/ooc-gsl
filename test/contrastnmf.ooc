use ooc-gsl

import matrix, blas

import math/Random

extend Double{
    abs: func ~test -> Double{ this > 0 ? this : -this }
}


NMF : class{
    x: Matrix
    W,H: Matrix

    x2: Matrix
    W2, H2: Matrix

    lambda : Double = -0.05

    random: static func(i,j: SizeT) -> Double{
        Random random() as Double / INT_MAX as Double
    }

    init: func(=x, =x2, k: SizeT){
        W = Matrix new(x size1(), k)
        H = Matrix new(k, x size2())
        W2 = Matrix new(x2 size1(), k)
        H2 = Matrix new(k, x2 size2())
        W set(this random)
        H set(this random)
        W2 set(this random)
        H2 set(this random)
    }

    free: func{
        W free()
        H free()
        W2 free()
        H2 free()
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

    gradientDescent: func(n: SizeT, maxiter: SizeT = 100){
        // how many data is same
        N := Matrix new(x size2(), n)
        N set(|i,j| i == j ? 1. : 0.)
        Nt := N transposeTo()

        N2 := Matrix new(x2 size2(), n)
        N2 set(|i,j| i == j ? 1. : 0.)
        Nt2 := N2 transposeTo()

        for(i in 0..maxiter){
            // first part of loss func, |x - WH|_F
            recon := W * H
            error := x - recon

            // second part of loss func |x2 - W2H2|_F
            recon2 := W2 * H2
            error2 := x2 - recon2

            cerror := H*N 
            temp2 := H2*N2
            cerror sub(temp2)
            temp2 free()

            /*{
                sum := 0.0
                error get(|x| sum += x * x)
                sum toString() println()
            }*/
            
            // update H
            Wt := W transposeTo()
            dH := Wt * error
            dH mul(lambda)
            ce1 := cerror * Nt
            dH add(ce1)
            H sub(dH)
            H set(|x| x < 0 ? 0. : x)

            ce1 free()
            dH free()
            Wt free()

            Wt2 := W2 transposeTo()
            dH2 := Wt2 * error2
            ce2 := cerror * Nt2
            dH2 sub(ce2)
            dH2 mul(lambda)
            H2 sub(dH2)
            H2 set(|x| x < 0 ? 0. : x)

            ce2 free()
            dH2 free()
            Wt2 free()

            cerror free()

            // update W
            Ht := H transposeTo()
            dW := error * Ht
            dW mul(lambda)
            W sub(dW)
            W set(|x| x < 0 ? 0. : x)

            Ht free()
            recon free()
            error free() 
            dW free()

            Ht2 := H2 transposeTo()
            dW2 := error2 * Ht2
            dW2 mul(lambda)
            W2 sub(dW2)
            W2 set(|x| x < 0 ? 0. : x)

            Ht2 free()
            recon2 free()
            error2 free()
            dW2 free()
        }

        N free()
        Nt free()

        N2 free()
        Nt2 free()
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

testX2 := Matrix new(3, 10)
testX2 set(|i, j| data[j][i])

nmf := NMF new(testX, testX2, 2)
nmf gradientDescent(1, 100)


"W is : " print()
nmf W toString() println()

"H is : " print()
nmf H toString() println()

xapp := nmf W * nmf H

"X is : " print()
testX toString() println()

"W*H is : " print()
xapp toString() println()

xapp free()

///////////////////////////

"W2 is : " print()
nmf W2 toString() println()

"H2 is : " print()
nmf H2 toString() println()

xapp2 := nmf W2 * nmf H2

"X2 is : " print()
testX2 toString() println()

"W2*H2 is : " print()
xapp2 toString() println()

xapp2 free()

nmf free()
testX free()
testX2 free()
