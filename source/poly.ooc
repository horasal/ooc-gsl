include gsl/gsl_poly

use ooc-gsl
import gslcomplex

Poly: cover{
    eval: static func ~wraps (data: Double[], x: Double) -> Double{
        eval(data data, data length, x)
    }

    eval: extern (gsl_poly_eval) static func ~gsl (const Double*, const Int, const Double) -> Double

    eval: static func ~wrapc (data: Double[], x: Complex) -> Complex{
        eval(data data, data length, x)
    }

    eval: extern (gsl_poly_complex_eval) static func ~gslcomplex (const Double*, const Int, const Complex) -> Complex

    eval: static func ~wrapcc (data: Complex[], x: Complex) -> Complex{
        eval(data data, data length, x)
    }

    eval: extern (gsl_complex_complex_eval) static func ~gslcc (const Complex*, const Int, const Complex) -> Complex
    
    derivs: extern(gsl_poly_eval_derivs) static func(const Double*, const SizeT, const Double, const Double*, const SizeT) -> Int

    derivs: static func ~wrap (data: Double[], x: Double, k: SizeT) -> Double[]{
        res := gc_malloc(Double size * k)
        derivs(data data, data length, x, res, k)

        result: Double[]
        result data = res
        result length = k

        result
    }


    ddInit: extern(gsl_poly_dd_init) static func (Double*, const Double*, const Double*, SizeT) -> Int
    ddEval: extern(gsl_poly_dd_eval) static func (Double*, const Double*, SizeT, Double) -> Int

    ddTaylor: extern(gsl_poly_dd_taylor) static func(Double*, Double, const Double*, const Double, SizeT, Double*) -> Int
    ddHermiteInit: extern(gsl_poly_dd_hermite_init) static func(Double*, Double*, Double*, Double*, Double*, SizeT) -> Int

    solveQuadratic: extern(gsl_poly_solve_quadratic) static func(Double, Double, Double, Double*, Double*) -> Int
    solveQuadratic: extern(gsl_poly_complex_solve_quadratic) static func ~complex (Double, Double, Double, Complex*, Complex*) -> Int

    solveCubic: extern(gsl_poly_solve_cubic) static func(Double, Double, Double, Double*, Double*, Double*) -> Int
    solveCubic: extern(gsl_poly_complex_solve_cubic) static func ~complex (Double, Double, Double, Complex*, Complex*, Complex*) -> Int
}


PolySolver: cover from gsl_poly_complex_workspace*{
    new: extern(gsl_poly_complex_workspace_alloc) static func(SizeT) -> This
    free: extern(gsl_poly_complex_workspace_free) func

    solve: func ~array(a: Double[]) -> Double[]{
        solve(a data, a length)
    }

    solve: func(a: Double*, size: SizeT) -> Double[]{
        data := gc_malloc(Double size * 2 * (size - 1))
        _gslsolve(a, size, this, data)
        res : Double[]
        res data = data
        res length = 2*(size-1)
        res
    }
}

_gslsolve: extern(gsl_poly_complex_solve) func(Double*, SizeT, PolySolver, Double*) -> Int
