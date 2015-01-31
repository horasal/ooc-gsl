include gsl/gsl_math

E: extern const Double
LOG2E: extern const Double
LOG10E: extern const Double
SQRT2: extern const Double
SQRT12: extern const Double
SQRT3: extern const Double
PI: extern const Double
PI2: extern const Double
PI4: extern const Double
SQRTPI: extern const Double
SQRTPI2: extern const Double
PI1: extern const Double
PI2: extern const Double
LN10: extern const Double
LN2: extern const Double
LNPI: extern const Double
EULER: extern const Double

POSINF: extern const Double
NEGINF: extern const Double
NAN: extern const Double

extend Double{
    isNan: extern(gsl_isnan) func -> Int
    isInf: extern(gsl_isinf) func -> Int
    finite: extern(gsl_finite) func -> Int

    log1p: extern(gsl_log1p) func -> Double
    expm1: extern(gsl_expm1) func -> Double
    hypot: extern(gsl_hypot) func -> Double
    hypot3: extern(gsl_hypot3) func -> Double
    acosh: extern(gsl_acosh) func ~gsl -> Double
    asinh: extern(gsl_asinh) func ~gsl -> Double
    atanh: extern(gsl_atanh) func ~gsl -> Double
    ldexp: extern(gsl_ldexp) func(Int) -> Double
    frexp: extern(gsl_frexp) func(Int*) -> Double

    pow: extern(gsl_pow_int) func ~int (Int) -> Double
    pow: extern(gsl_pow_uint) func ~uint (UInt) -> Double

    pow2: extern(gsl_pow_2) func -> Double
    pow3: extern(gsl_pow_3) func -> Double
    pow4: extern(gsl_pow_4) func -> Double
    pow5: extern(gsl_pow_5) func -> Double
    pow6: extern(gsl_pow_6) func -> Double
    pow7: extern(gsl_pow_7) func -> Double
    pow8: extern(gsl_pow_8) func -> Double
    pow9: extern(gsl_pow_9) func -> Double
}

fcmp: extern(gsl_fcmp) func(Double, Double, Double) -> Int
