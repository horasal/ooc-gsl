include gsl/gsl_complex_math


Complex: cover from gsl_complex{
    dat : extern Double[2]

    new: extern(gsl_complex_rect) static func(Double, Double) -> This
    newTheta: extern(gsl_complex_polar) static func(Double, Double) -> This

    real: extern(gsl_REAL) func -> Double
    imag: extern(gsl_IMAG) func -> Double

    set: extern(GSL_SET_COMPLEX) func(Double, Double)
    setReal: extern(GSL_SET_REAL) func(Double)
    setImag: extern(GSL_SET_IMAG) func(Double)

    arg: extern(gsl_complex_arg) func -> Double
    abs: extern(gsl_complex_abs) func -> Double
    abs2: extern(gsl_complex_abs2) func -> Double
    logabs: extern(gsl_complex_logabs) func -> Double

    add: extern(gsl_complex_add) func(This) -> This
    sub: extern(gsl_complex_sub) func(This) -> This
    mul: extern(gsl_complex_mul) func(This) -> This
    div: extern(gsl_complex_div) func(This) -> This

    addReal: extern(gsl_complex_add_real) func ~real (Double) -> This
    subReal: extern(gsl_complex_sub_real) func ~real (Double) -> This
    mulReal: extern(gsl_complex_mul_real) func ~real (Double) -> This
    divReal: extern(gsl_complex_div_real) func ~real (Double) -> This
    addImag: extern(gsl_complex_add_imag) func ~imag (Double) -> This
    subImag: extern(gsl_complex_sub_imag) func ~imag (Double) -> This
    mulImag: extern(gsl_complex_mul_imag) func ~imag (Double) -> This
    divImag: extern(gsl_complex_div_imag) func ~imag (Double) -> This

    conjugate: extern(gsl_complex_conjugate) func -> This
    inverse: extern(gsl_complex_inverse) func -> This
    negative: extern(gsl_complex_negative) func -> This

    sqrt: extern(gsl_complex_sqrt) func -> This
    //move this to extend Double
    //sqrtReal: extern(gsl_complex_sqrt_real) func -> This
    pow: extern(gsl_complex_pow) func(This) -> This
    pow: extern(gsl_complex_pow_real) func ~real (Double) -> This
    exp: extern(gsl_complex_exp) func() -> This
    log: extern(gsl_complex_log) func() -> This
    log10: extern(gsl_complex_log10) func() -> This
    logb: extern(gsl_complex_log_b) func(This) -> This

    sin: extern(gsl_complex_sin) func -> This
    cos: extern(gsl_complex_cos) func -> This
    tan: extern(gsl_complex_tan) func -> This
    sec: extern(gsl_complex_sec) func -> This
    csc: extern(gsl_complex_csc) func -> This
    cot: extern(gsl_complex_cot) func -> This
    arcsin: extern(gsl_complex_arcsin) func -> This
    arccos: extern(gsl_complex_arccos) func -> This
    arcsec: extern(gsl_complex_arcsec) func -> This
    arccsc: extern(gsl_complex_arccsc) func -> This
    arccot: extern(gsl_complex_arccot) func -> This

    sinh: extern(gsl_complex_sinh) func -> This
    cosh: extern(gsl_complex_cosh) func -> This
    tanh: extern(gsl_complex_tanh) func -> This
    sech: extern(gsl_complex_sech) func -> This
    csch: extern(gsl_complex_csch) func -> This
    coth: extern(gsl_complex_coth) func -> This
    arcsinh: extern(gsl_complex_arcsinh) func -> This
    arccosh: extern(gsl_complex_arccosh) func -> This
    arctanh: extern(gsl_complex_arctanh) func -> This
    arcsech: extern(gsl_complex_arcsech) func -> This
    arccoth: extern(gsl_complex_arccoth) func -> This

    //move this to extend Double
    //arcsin_real
    //arccos_real
    //arcsec_real
    //arccsc_real
    //arccosh_real
    //arctanh_real

    operator + (other: This) -> This{ add(other) }
    operator - (other: This) -> This{ sub(other) }
    operator * (other: This) -> This{ mul(other) }
    operator / (other: This) -> This{ div(other) }
    operator ~ () -> This{ inverse() }
    operator - () -> This{ negative() }
}
