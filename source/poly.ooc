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
}
