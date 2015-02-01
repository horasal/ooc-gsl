include gsl/gsl_sf_result

GSL_PREC_DOUBLE: extern const Int
GSL_PREC_SINGLE: extern const Int
GSL_PREC_APPROX: extern const Int

ResultError: cover from gsl_sf_result{
    val: extern Double
    err: extern Double
}

ResultErrorE10: cover from gsl_sf_result_e10{
    val: extern Double
    err: extern Double
    e10: extern Int
}

Ai: extern(gsl_sf_airy_Ai) func(Double, Int) -> Double
Aie: extern(gsl_sf_airy_Ai_e) func(Double, Int, ResultError*) -> Int

Bi: extern(gsl_sf_airy_Bi) func(Double, Int) -> Double
Bie: extern(gsl_sf_airy_Bi_e) func(Double, Int, ResultError*) -> Int

AiScaled: extern(gsl_sf_airy_Ai_scaled) func(Double, Int) -> Double
AiScalede: extern(gsl_sf_airy_Ai_scaled_e) func(Double, Int, ResultError*) -> Int

BiScaled: extern(gsl_sf_airy_Bi_scaled) func(Double, Int) -> Double
BiScalede: extern(gsl_sf_airy_Bi_scaled_e) func(Double, Int, ResultError*) -> Int


AiDeriv: extern(gsl_sf_airy_Ai_deriv) func(Double, Int) -> Double
AiDerive: extern(gsl_sf_airy_Ai_deriv_e) func(Double, Int, ResultError*) -> Int

BiDeriv: extern(gsl_sf_airy_Bi_deriv) func(Double, Int) -> Double
BiDerive: extern(gsl_sf_airy_Bi_deriv_e) func(Double, Int, ResultError*) -> Int

AiDerivScaled: extern(gsl_sf_airy_Ai_deriv_scaled) func(Double, Int) -> Double
AiDerivScalede: extern(gsl_sf_airy_Ai_deriv_scaled_e) func(Double, Int, ResultError*) -> Int

BiDerivScaled: extern(gsl_sf_airy_Bi_deriv_scaled) func(Double, Int) -> Double
BiDerivScalede: extern(gsl_sf_airy_Bi_deriv_scaled_e) func(Double, Int, ResultError*) -> Int


//TODO: finish wrapping remaining special functions
